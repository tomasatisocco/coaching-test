import 'package:pdf/pdf.dart';

PdfColor getPdfTotalColor(int score) {
  if (score < 36) return ScorePdfColors.beginner;
  if (score < 64) return ScorePdfColors.advancedBeginner;
  if (score < 94) return ScorePdfColors.advanced;
  if (score <= 120) return ScorePdfColors.expert;
  return ScorePdfColors.master;
}

PdfColor getPdfQualityColor(int score) {
  if (score < 22) return ScorePdfColors.beginner;
  if (score < 28) return ScorePdfColors.advancedBeginner;
  if (score < 37) return ScorePdfColors.advanced;
  if (score <= 41) return ScorePdfColors.expert;
  return ScorePdfColors.master;
}

PdfColor getPdfBusinessColor(int score) {
  if (score < 3) return ScorePdfColors.beginner;
  if (score < 17) return ScorePdfColors.advancedBeginner;
  if (score < 28) return ScorePdfColors.advanced;
  if (score <= 37) return ScorePdfColors.expert;
  return ScorePdfColors.master;
}

PdfColor getPdfWellnessColor(int score) {
  if (score < 6) return ScorePdfColors.beginner;
  if (score < 10) return ScorePdfColors.advancedBeginner;
  if (score < 15) return ScorePdfColors.advanced;
  if (score <= 20) return ScorePdfColors.expert;
  return ScorePdfColors.master;
}

PdfColor getPdfCommunityColor(int score) {
  if (score < 8) return ScorePdfColors.beginner;
  if (score < 12) return ScorePdfColors.advancedBeginner;
  if (score < 17) return ScorePdfColors.advanced;
  if (score <= 25) return ScorePdfColors.expert;
  return ScorePdfColors.master;
}

class ScorePdfColors {
  static PdfColor get beginner => PdfColor.fromHex('FFFFFF');
  static PdfColor get advancedBeginner => PdfColor.fromHex('FFC100');
  static PdfColor get advanced => PdfColor.fromHex('92D051');
  static PdfColor get expert => PdfColor.fromHex('2F5496');
  static PdfColor get master => PdfColor.fromHex('000000');
}
