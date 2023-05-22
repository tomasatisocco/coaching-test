import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as nodemailer from "nodemailer";
import * as dotenv from "dotenv";
import {Storage} from "@google-cloud/storage";
import {PDFDocument, StandardFonts, rgb} from "pdf-lib";

// Initialize Firebase Admin SDK
admin.initializeApp();

// Read new entries in firestore collection
const testsReferenceDev = "environments/development/coaching_tests/{testId}";
const testsReferenceStage = "environments/staging/coaching_tests/{testId}";
const testsReferenceProd = "environments/production/coaching_tests/{testId}";

// Access the email and password from the environment variables
const senderEmail = dotenv.config().parsed?.GMAIL_EMAIL;
const password = dotenv.config().parsed?.GMAIL_PASSWORD;

const storage = new Storage();

const bucketName = "gs://coaching-test-3c129.appspot.com/";

const bucket = storage.bucket(bucketName);

// Initialize Nodemailer transport
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: senderEmail,
    pass: password,
  },
});

/**
 * This function creates the cover page of the PDF.
 * @param {PDFDocument} pdfDoc The PDF document.
 * @param {Uint8Array} iconBuffer The icon image buffer.
 * @param {Uint8Array} imageBuffer The image buffer.
 * @param {string} userName The user name.
 * @param {string} date The date of the test.
 */
async function createCoverPage(
  pdfDoc: PDFDocument,
  iconBuffer: Uint8Array,
  imageBuffer: Uint8Array,
  userName: string,
  date: string,
): Promise<void> {
  // Add a new cover page
  const coverPage = pdfDoc.insertPage(0);
  const {width, height} = coverPage.getSize();

  const [coverWidth, coverHeight, coverX, coverY] = [width, height * 0.7, 0, 0];
  const [iconWidth, iconHeight, iconX, iconY] = [
    100, 80, width / 2 - 50, height - 100,
  ];

  // Add the icon image at the top
  const iconImage = await pdfDoc.embedPng(iconBuffer);
  coverPage.drawImage(
    iconImage,
    {x: iconX, y: iconY, width: iconWidth, height: iconHeight},
  );

  // Add the text below the icon
  const font = await pdfDoc.embedFont(StandardFonts.TimesRoman);
  const italicFont = await pdfDoc.embedFont(StandardFonts.TimesRomanItalic);
  const titleFontSize = 24;
  const subTitleFontSize = 12;
  const title = "Test para el desarrollo profesional";
  const subTitle = "Informe";
  const titleWidth = italicFont.widthOfTextAtSize(title, titleFontSize);
  const subTitleWidth = font.widthOfTextAtSize(subTitle, titleFontSize);
  const nameWidth = font.widthOfTextAtSize(userName, subTitleFontSize);
  const dateWidth = font.widthOfTextAtSize(date, subTitleFontSize);
  coverPage.drawText(
    title,
    {
      x: (width - titleWidth) / 2,
      y: height - 136,
      size: titleFontSize,
      color: rgb(0, 0, 0),
      font: italicFont,
    }
  );
  coverPage.drawText(
    subTitle,
    {
      x: (width - subTitleWidth) / 2,
      y: height - 162,
      size: titleFontSize,
      color: rgb(0, 0, 0),
      font: font,
    }
  );
  coverPage.drawText(
    userName,
    {
      x: (width - nameWidth) / 2,
      y: height - 186,
      size: subTitleFontSize,
      color: rgb(0, 0, 0),
      font: font,
    }
  );
  coverPage.drawText(
    date,
    {
      x: (width - dateWidth) / 2,
      y: height - 210,
      size: subTitleFontSize,
      color: rgb(0, 0, 0),
      font: font,
    }
  );

  // Add the image to fill the rest of the cover page
  const image = await pdfDoc.embedPng(imageBuffer);
  coverPage.drawImage(
    image,
    {x: coverX, y: coverY, width: coverWidth, height: coverHeight},
  );
  functions.logger.log("Cover page created");
}

/**
 * This function adds the results to the pdf.
 * @param {PDFDocument} pdfDoc The PDF document.
 * @param {string} resultsPath The path to the results.
 */
async function addResultPDF(
  pdfDoc: PDFDocument,
  resultsPath: string,
): Promise<void> {
  // Load the source PDF
  const sourcePDFData = await bucket.file(resultsPath).download();
  const sourcePDFBuffer = Buffer.from(sourcePDFData[0]);
  const sourcePDFDoc = await PDFDocument.load(sourcePDFBuffer);

  // Copy pages from the source PDF to the target PDF
  const copiedPages = await pdfDoc.copyPages(
    sourcePDFDoc,
    sourcePDFDoc.getPageIndices(),
  );
  pdfDoc.insertPage(5, copiedPages[0]);
  functions.logger.log("Results page added to PDF");
}

/**
 * This function creates the PDF.
 * @param {string} resultsPath The path to the results.
 * @param {string} userName The user name.
 * @param {string} date The date of the test.
 */
async function createPDF(
  resultsPath: string,
  userName: string,
  date: string,
): Promise<PDFDocument> {
  const filePath = "development/testresult.pdf";
  const iconPath = "development/live_as_coach_icon.png";
  const imagePath = "development/live_as_coach_cover.png";
  // Load the PDF file from Firebase Storage
  const [pdfData, iconData, imageData] = await Promise.all([
    bucket.file(filePath).download(),
    bucket.file(iconPath).download(),
    bucket.file(imagePath).download(),
  ]);
  functions.logger.log("All files downloaded");

  const pdfBuffer = Buffer.from(pdfData[0]);
  const iconBuffer = Uint8Array.from(iconData[0]);
  const imageBuffer = Uint8Array.from(imageData[0]);

  // Create a new PDF document
  const pdfDoc = await PDFDocument.load(pdfBuffer);

  // Create a cover page
  await createCoverPage(
    pdfDoc,
    iconBuffer,
    imageBuffer,
    userName,
    date,
  );

  // Add result PDF to the default PDF
  await addResultPDF(pdfDoc, resultsPath);

  return pdfDoc;
}

/**
 * This function sends an email using Nodemailer.
 * @param {PDFDocument} pdfDoc The PDF document.
 * @param {string} email The email address to send the email to.
 * @param {string} userName The user name.
 */
async function sendEmail(
  pdfDoc: PDFDocument,
  email: string,
  userName: string,
): Promise<void> {
  // Serialize the updated PDF document to a buffer
  const updatedPdfBuffer = await pdfDoc.save();

  // Convert the buffer to a Buffer object
  const updatedPdfBufferAsBuffer = Buffer.from(updatedPdfBuffer);
  functions.logger.log("Result PDF added to the default PDF");

  const mailOptions = {
    from: "coachingtest23@gmail.com",
    to: email,
    subject: "Vivir como Coach: Resultados del test",
    // eslint-disable-next-line max-len
    text: "Hola "+userName+",\n\nMuchas gracias por realizar el test. Adjunto encontrarás el informe con los resultados.\n\nUn saludo,\n\nEl equipo de Vivir como Coach",
    attachments: [
      {
        filename: "document.pdf",
        content: updatedPdfBufferAsBuffer,
      },
    ],
  };

  try {
    functions.logger.log("Sending email");
    await transporter.sendMail(mailOptions);
  } catch (error) {
    console.error("Error sending email:", error);
  }
}


exports.readDevTests = functions
  .region("southamerica-east1")
  .firestore.document(testsReferenceDev)
  .onCreate( async (snap, context) => {
    const newValue = snap.data();
    const testId = context.params.testId;
    const userId = newValue.userId;
    functions.logger.log("New test read in dev", testId);

    const userReference = await admin.firestore()
      .doc("environments/development/users/"+userId).get();
    const userData = userReference.data();
    const userName = userData?.name;
    const userEmail = userData?.email;
    const date = newValue?.coachingTestDate;
    functions.logger.log("User info", userName, userEmail);

    const resultsPath = "development/UsersResults/"+userId+".pdf";
    const pdfDoc = await createPDF(resultsPath, userName, date);
    await sendEmail(pdfDoc, userEmail, userName);
  });

exports.readStageTests = functions
  .region("southamerica-east1")
  .firestore.document(testsReferenceStage)
  .onCreate( async (snap, context) => {
    const newValue = snap.data();
    const testId = context.params.testId;
    const userId = newValue.userId;
    functions.logger.log("New test read in stage", testId);

    const userReference = await admin.firestore()
      .doc("environments/staging/users/"+userId).get();
    const userData = userReference.data();
    const userName = userData?.name;
    const userEmail = userData?.email;
    const date = newValue?.coachingTestDate;
    functions.logger.log("User info", userName, userEmail);

    const resultsPath = "staging/UsersResults/"+userId+".pdf";
    const pdfDoc = await createPDF(resultsPath, userName, date);
    await sendEmail(pdfDoc, userEmail, userName);
  });

exports.readProdTests = functions
  .region("southamerica-east1")
  .firestore.document(testsReferenceProd)
  .onCreate( async (snap, context) => {
    const newValue = snap.data();
    const testId = context.params.testId;
    const userId = newValue.userId;
    functions.logger.log("New test read in production", testId);

    const userReference = await admin.firestore()
      .doc("environments/production/users/"+userId).get();
    const userData = userReference.data();
    const userName = userData?.name;
    const userEmail = userData?.email;
    const date = newValue?.coachingTestDate;
    functions.logger.log("User info", userName, userEmail);

    const resultsPath = "development/UsersResults/"+userId+".pdf";
    const pdfDoc = await createPDF(resultsPath, userName, date);
    await sendEmail(pdfDoc, userEmail, userName);
  });
