import 'package:flutter/material.dart';

class GeneralScoreWidget extends StatelessWidget {
  const GeneralScoreWidget({
    super.key,
    required this.score,
    required this.scoreColor,
    this.radio = 100,
    this.padding = const EdgeInsets.all(16),
  });

  final String score;
  final double radio;
  final EdgeInsets padding;
  final Color scoreColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: radio * 2,
            width: radio * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scoreColor.withOpacity(.3),
            ),
          ),
          Container(
            height: radio * 1.3,
            width: radio * 1.3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scoreColor,
              border: Border.all(
                color: Color.lerp(scoreColor, Colors.white, 0.5)!,
                width: radio * .09,
              ),
            ),
          ),
          Text(
            score,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.lerp(scoreColor, Colors.black, 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
