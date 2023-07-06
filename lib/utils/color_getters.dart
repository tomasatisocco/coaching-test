import 'package:flutter/material.dart';

Color getTotalColor(int score) {
  if (score < 36) return ScoreColors.beginner;
  if (score < 64) return ScoreColors.advancedBeginner;
  if (score < 94) return ScoreColors.advanced;
  if (score <= 120) return ScoreColors.expert;
  return ScoreColors.master;
}

Color getQualityColor(int score) {
  if (score < 22) return ScoreColors.beginner;
  if (score < 28) return ScoreColors.advancedBeginner;
  if (score < 37) return ScoreColors.advanced;
  if (score <= 41) return ScoreColors.expert;
  return ScoreColors.master;
}

Color getBusinessColor(int score) {
  if (score < 3) return ScoreColors.beginner;
  if (score < 17) return ScoreColors.advancedBeginner;
  if (score < 28) return ScoreColors.advanced;
  if (score <= 37) return ScoreColors.expert;
  return ScoreColors.master;
}

Color getWellnessColor(int score) {
  if (score < 6) return ScoreColors.beginner;
  if (score < 10) return ScoreColors.advancedBeginner;
  if (score < 15) return ScoreColors.advanced;
  if (score <= 20) return ScoreColors.expert;
  return ScoreColors.master;
}

Color getCommunityColor(int score) {
  if (score < 8) return ScoreColors.beginner;
  if (score < 12) return ScoreColors.advancedBeginner;
  if (score < 17) return ScoreColors.advanced;
  if (score <= 25) return ScoreColors.expert;
  return ScoreColors.master;
}

class ScoreColors {
  static const beginner = Color(0xFFFFFFFF);
  static const advancedBeginner = Color(0xFFFFC100);
  static const advanced = Color(0xFF92D051);
  static const expert = Color(0xFF2F5496);
  static const master = Color(0xFF000000);
}
