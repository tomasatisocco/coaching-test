import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as nodemailer from "nodemailer";
import * as dotenv from "dotenv";

// Initialize Firebase Admin SDK
admin.initializeApp();

// Read new entries in firestore collection
const testsReference = "environments/development/coaching_tests/{testId}";

// Access the email and password from the environment variables
const senderEmail = dotenv.config().parsed?.GMAIL_EMAIL;
const password = dotenv.config().parsed?.GMAIL_PASSWORD;


// Initialize Nodemailer transport
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: senderEmail,
    pass: password,
  },
});

/**
 * This function sends an email using Nodemailer.
 * @param {string} email The email address to send the email to.
 * @param {string} message The content of the email.
 */
async function sendEmail(email: string, message: string): Promise<void> {
  const mailOptions = {
    from: "coachingtest23@gmail.com",
    to: email,
    subject: "New Document Added",
    text: message,
  };

  try {
    await transporter.sendMail(mailOptions);
  } catch (error) {
    console.error("Error sending email:", error);
  }
}


exports.readTests = functions
  .region("southamerica-east1")
  .firestore.document(testsReference)
  .onCreate( async (snap, context) => {
    const newValue = snap.data();
    const testId = context.params.testId;
    const userId = newValue.userId;
    functions.logger.log("New test read", testId);

    const userReference = await admin.firestore()
      .doc("environments/development/users/"+userId).get();
    const userData = userReference.data();
    const userName = userData?.name;
    const userEmail = userData?.email;
    functions.logger.log("User info", userName, userEmail);

    const message = `Hi ${userName}, your test ${testId} has been read`;
    await sendEmail(userEmail, message);
  });
