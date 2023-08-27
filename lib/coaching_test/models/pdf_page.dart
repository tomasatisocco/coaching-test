import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/coaching_test/models/test_model_keys.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/utils/color_pdf_getters.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Page resultPdfPage(CoachingTest testModel, AppLocalizations l10n) {
  return pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (context) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Tus resultados',
            style: pw.TextStyle(
              color: PdfColor.fromHex('0B1A37'),
              fontSize: 13,
              fontNormal: pw.Font.timesBoldItalic(),
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            'A continuación, te presentamos un gráfico con tus resultados:',
            style: pw.TextStyle(
              color: PdfColor.fromHex('0B1A37'),
              fontSize: 13,
              fontNormal: pw.Font.times(),
            ),
          ),
          pw.SizedBox(height: 36),
          pw.Container(
            width: 600,
            height: 600,
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('0B1A37'),
              borderRadius: const pw.BorderRadius.all(
                pw.Radius.circular(16),
              ),
            ),
            padding: const pw.EdgeInsets.symmetric(vertical: 10),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                FieldScoreWidget(
                  title: l10n.qualityOfService,
                  radio: 30,
                  score: testModel.getGroupAnswersTotal(
                    AnswerGroup.qualityOfService,
                  ),
                  scoreColor: getPdfQualityColor(
                    testModel.getGroupAnswersTotal(
                      AnswerGroup.qualityOfService,
                    ),
                  ),
                  removeUpperPadding: true,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    FieldScoreWidget(
                      title: l10n.businessCreation,
                      radio: 30,
                      score: testModel.getGroupAnswersTotal(
                        AnswerGroup.business,
                      ),
                      scoreColor: getPdfBusinessColor(
                        testModel.getGroupAnswersTotal(
                          AnswerGroup.business,
                        ),
                      ),
                    ),
                    GeneralScoreWidget(
                      score: testModel.totalQualification.toString(),
                      radio: 50,
                      scoreColor: getPdfTotalColor(
                        testModel.totalQualification,
                      ),
                    ),
                    FieldScoreWidget(
                      title: l10n.personalWellness,
                      radio: 30,
                      score: testModel.getGroupAnswersTotal(
                        AnswerGroup.personal,
                      ),
                      scoreColor: getPdfWellnessColor(
                        testModel.getGroupAnswersTotal(
                          AnswerGroup.personal,
                        ),
                      ),
                    ),
                  ],
                ),
                FieldScoreWidget(
                  title: l10n.aportToTheCommunity,
                  radio: 30,
                  score: testModel.getGroupAnswersTotal(
                    AnswerGroup.community,
                  ),
                  scoreColor: getPdfCommunityColor(
                    testModel.getGroupAnswersTotal(
                      AnswerGroup.community,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class FieldScoreWidget extends pw.StatelessWidget {
  FieldScoreWidget({
    required this.score,
    required this.title,
    required this.scoreColor,
    this.maxRadio = 16,
    this.removeUpperPadding = false,
    this.radio = 45,
    this.padding = pw.EdgeInsets.zero,
  });

  final int score;
  final PdfColor scoreColor;
  final String title;
  final double radio;
  final double maxRadio;
  final pw.EdgeInsets padding;
  final bool removeUpperPadding;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: padding,
      child: pw.Column(
        children: [
          if (!removeUpperPadding)
            pw.SizedBox(
              height: 55,
            ),
          pw.Container(
            height: radio * 2,
            width: radio * 2,
            decoration: pw.BoxDecoration(
              color: scoreColor,
              shape: pw.BoxShape.circle,
              border: pw.Border.all(
                color: scoreColor,
                width: radio * .15,
              ),
            ),
            child: pw.SizedBox(
              child: pw.Center(
                child: pw.Text(
                  score.toString(),
                  style: pw.TextStyle(
                    fontSize: radio * .9,
                    color: PdfColors.white,
                  ),
                ),
              ),
            ),
          ),
          pw.SizedBox(
            width: radio * 4,
            height: 55,
            child: pw.Text(
              title,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                color: PdfColors.white,
                fontSize: radio * .6 >= maxRadio ? maxRadio : radio * .6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GeneralScoreWidget extends pw.StatelessWidget {
  GeneralScoreWidget({
    required this.score,
    required this.scoreColor,
    this.radio = 100,
    this.padding = const pw.EdgeInsets.all(16),
  });

  final String score;
  final double radio;
  final pw.EdgeInsets padding;
  final PdfColor scoreColor;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: padding,
      child: pw.Stack(
        alignment: pw.Alignment.center,
        children: [
          pw.Container(
            height: radio * 2,
            width: radio * 2,
            decoration: pw.BoxDecoration(
              shape: pw.BoxShape.circle,
              color: scoreColor.shade(.9),
            ),
          ),
          pw.Container(
            height: radio * 1.3,
            width: radio * 1.3,
            decoration: pw.BoxDecoration(
              shape: pw.BoxShape.circle,
              color: scoreColor,
              border: pw.Border.all(
                color: scoreColor.shade(.2),
                width: radio * .09,
              ),
            ),
          ),
          pw.Text(
            score,
            style: pw.TextStyle(
              fontSize: 32,
              fontWeight: pw.FontWeight.bold,
              color: scoreColor.shade(1.2),
            ),
          ),
        ],
      ),
    );
  }
}
