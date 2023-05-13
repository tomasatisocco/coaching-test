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
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
        onPressed: () => onSubmit(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            context.l10n.getStarted,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
