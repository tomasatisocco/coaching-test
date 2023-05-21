import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Page resultPdfPage(CoachingTest testModel) => pw.Page(
      build: (context) => pw.Center(
        child: pw.Text('Hello World!'),
      ),
    );
