import 'package:coaching/app/widgets/language_switch_widget.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CongratulationsPage extends StatelessWidget {
  const CongratulationsPage({super.key});

  static const name = 'CongratulationsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 32,
        actions: const [
          LanguageSwitch(),
          SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.congratulations,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.testSubmitted,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.green,
              size: 128,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 400,
              child: Text(
                context.l10n.testSubmittedDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/live_as_coach_icon.png',
                  width: 150,
                ),
              ),
            ),
            const SizedBox(height: 16),
            //const NewTestButton(isMobile: true),
          ],
        ),
      ),
    );
  }
}
