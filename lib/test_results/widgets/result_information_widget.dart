import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ResultsInformationWidget extends StatelessWidget {
  const ResultsInformationWidget({
    required this.fontSize,
    super.key,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.testDescription,
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF0B1A37),
          ),
        ),
        SizedBox(
          height: fontSize,
        ),
        Text(
          context.l10n.testLevels,
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF0B1A37),
          ),
        ),
        Text(
          // ignore: lines_longer_than_80_chars
          ' • ${context.l10n.qualityOfService} \n • ${context.l10n.businessCreation} \n • ${context.l10n.personalWellness} \n • ${context.l10n.aportToTheCommunity}',
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF0B1A37),
          ),
        ),
        SizedBox(
          height: fontSize,
        ),
        Text(
          context.l10n.disclaimer,
          style: TextStyle(
            fontSize: fontSize,
            color: const Color(0xFF0B1A37),
          ),
        ),
      ],
    );
  }
}
