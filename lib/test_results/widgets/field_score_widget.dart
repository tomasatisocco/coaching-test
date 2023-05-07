import 'package:flutter/material.dart';

class FieldScoreWidget extends StatelessWidget {
  const FieldScoreWidget({
    super.key,
    required this.score,
    required this.title,
    required this.scoreColor,
    this.maxRadio = 16,
    this.removeUpperPadding = false,
    this.radio = 45,
    this.padding = EdgeInsets.zero,
  });

  final int score;
  final Color scoreColor;
  final String title;
  final double radio;
  final double maxRadio;
  final EdgeInsets padding;
  final bool removeUpperPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          Visibility(
            visible: !removeUpperPadding,
            child: const SizedBox(
              height: 55,
            ),
          ),
          Container(
            height: radio * 2,
            width: radio * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: scoreColor,
                width: radio * .15,
              ),
            ),
            child: SizedBox(
              child: Center(
                child: Text(
                  score.toString(),
                  style: TextStyle(
                    fontSize: radio * .9,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: radio * 4,
            height: 55,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: radio * .6 >= maxRadio ? maxRadio : radio * .6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
