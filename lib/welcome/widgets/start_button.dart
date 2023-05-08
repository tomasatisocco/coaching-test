import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
    required this.onSubmit,
    required this.fontSize,
  });

  final void Function(BuildContext context) onSubmit;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: ElevatedButton(
        onPressed: () => onSubmit(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA6FAAC),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            context.l10n.getStarted,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
