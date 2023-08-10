// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coaching/coaching_test/models/question_model.dart';
import 'package:coaching/coaching_test/models/question_model_implementation.dart';
import 'package:coaching/coaching_test/models/test_model_keys.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CoachingTest {
  const CoachingTest({
    required this.userId,
    required this.coachingTestDate,
    required this.questions,
  });

  factory CoachingTest.newTest(String userId) {
    return CoachingTest(
      userId: userId,
      coachingTestDate: DateTime.now(),
      questions: emptyQuestions,
    );
  }

  // Part 0 - General Information
  final String userId;
  final DateTime coachingTestDate;

  final Set<QuestionModel> questions;

  static const int serviceMaxQualification = 55;
  static const int businessMaxQualification = 36;
  static const int personalWellnessMaxQualification = 20;
  static const int professionalCommunityMaxQualification = 32;
  static const int maxQualification = serviceMaxQualification +
      businessMaxQualification +
      personalWellnessMaxQualification +
      professionalCommunityMaxQualification;

  bool get isTestCompleted =>
      !questions.any((element) => element.value == null);

  int getGroupAnswersTotal(AnswerGroup group) {
    var total = 0;
    for (final question in questions) {
      if (question.key.startsWith(group.groupIndex.toString())) {
        total += question.value ?? 0;
      }
    }
    return total;
  }

  int get totalQualification =>
      getGroupAnswersTotal(AnswerGroup.qualityOfService) +
      getGroupAnswersTotal(AnswerGroup.business) +
      getGroupAnswersTotal(AnswerGroup.personal) +
      getGroupAnswersTotal(AnswerGroup.community);

  int get getTotalQualificationPercentage =>
      (totalQualification * 100) ~/ maxQualification;

  int getQualityOfServiceQualificationPercentage(AnswerGroup group) =>
      (getGroupAnswersTotal(group) * 100) ~/ serviceMaxQualification;

  CoachingTest updateAnswer(String key, int value) {
    final newAnswers = questions.toList();
    final index = newAnswers.indexWhere((element) => element.key == key);
    newAnswers[index] = newAnswers[index].updateValue(value);
    return CoachingTest(
      userId: userId,
      coachingTestDate: coachingTestDate,
      questions: newAnswers.toSet(),
    );
  }

  String _getGuide() {
    final total = getTotalQualificationPercentage;
    if (total <= 35) return 'begginer_guide.pdf';
    if (total <= 63) return 'advanced_begginer_guide.pdf';
    if (total <= 93) return 'advanced_guide.pdf';
    if (total <= 119) return 'expert_guide.pdf';
    return 'master_guide.pdf';
  }

  String get getQualityLevelName {
    final total = getGroupAnswersTotal(AnswerGroup.qualityOfService);
    if (total < 22) return Level.beginner;
    if (total < 28) return Level.advancedBeginner;
    if (total < 37) return Level.advanced;
    if (total < 41) return Level.expert;
    return Level.master;
  }

  String get getBusinessLevelName {
    final total = getGroupAnswersTotal(AnswerGroup.business);
    if (total < 3) return Level.beginner;
    if (total < 17) return Level.advancedBeginner;
    if (total < 28) return Level.advanced;
    if (total < 37) return Level.expert;
    return Level.master;
  }

  String get getPersonalLevelName {
    final total = getGroupAnswersTotal(AnswerGroup.personal);
    if (total < 6) return Level.beginner;
    if (total < 10) return Level.advancedBeginner;
    if (total < 15) return Level.advanced;
    if (total < 20) return Level.expert;
    return Level.master;
  }

  String get getCommunityLevelName {
    final total = getGroupAnswersTotal(AnswerGroup.community);
    if (total < 8) return Level.beginner;
    if (total < 12) return Level.advancedBeginner;
    if (total < 17) return Level.advanced;
    if (total < 25) return Level.expert;
    return Level.master;
  }

  Future<Map<String, dynamic>> toMap() async {
    final answersMap = <String, dynamic>{};
    final qualitySuggestions = <String>[];
    final businessSuggestions = <String>[];
    final wellnessSuggestions = <String>[];
    final communitySuggestions = <String>[];
    for (final question in questions) {
      answersMap[question.key] = question.value;
      final group = AnswerGroup.fromKey(question.key);
      switch (group) {
        case AnswerGroup.qualityOfService:
          final filePath = './suggestions/quality/$getQualityLevelName.json';
          final suggestion = await getSuggestion(filePath, question);
          if (suggestion != null) qualitySuggestions.add(suggestion);
          break;
        case AnswerGroup.business:
          final filePath = './suggestions/business/$getBusinessLevelName.json';
          final suggestion = await getSuggestion(filePath, question);
          if (suggestion != null) businessSuggestions.add(suggestion);
          break;
        case AnswerGroup.personal:
          final filePath = './suggestions/wellness/$getPersonalLevelName.json';
          final suggestion = await getSuggestion(filePath, question);
          if (suggestion != null) wellnessSuggestions.add(suggestion);
          break;
        case AnswerGroup.community:
          final filePath =
              './suggestions/community/$getCommunityLevelName.json';
          final suggestion = await getSuggestion(filePath, question);
          if (suggestion != null) communitySuggestions.add(suggestion);
          break;
        case null:
          break;
      }
    }
    return <String, dynamic>{
      'userId': userId,
      'coachingTestDate':
          DateFormat('yyyy-MM-dd hh:mm').format(coachingTestDate),
      'answers': answersMap,
      'guide': _getGuide(),
      'quality_suggestions': qualitySuggestions,
      'business_suggestions': businessSuggestions,
      'wellness_suggestions': wellnessSuggestions,
      'community_suggestions': communitySuggestions,
    };
  }

  Future<String?> getSuggestion(String filePath, QuestionModel question) async {
    try {
      final file = await rootBundle.loadString(filePath);
      final completeMap = json.decode(file) as Map<String, dynamic>;
      final questionMap = completeMap[question.key] as Map<String, dynamic>?;
      final suggestion =
          questionMap?[(question.answerIndex + 1).toString()] as String?;
      return suggestion;
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    return '''
        CoachingTest(
          userId: $userId,
          coachingTestDate: $coachingTestDate,
          answers: $questions,
        )
      ''';
  }

  factory CoachingTest.fromMap(Map<String, dynamic> map) {
    return CoachingTest(
      userId: map['userId'] as String,
      coachingTestDate: DateTime.parse(map['coachingTestDate'] as String),
      questions: (map['answers'] as Map<String, dynamic>)
          .entries
          .map<QuestionModel>((e) => QuestionModel.fromMap({e.key: e.value})!)
          .toSet(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CoachingTest.fromJson(String source) =>
      CoachingTest.fromMap(json.decode(source) as Map<String, dynamic>);
}

Set<QuestionModel> emptyQuestions = {
  ProfesionalImprovementQuestion(),
  WeeklyMediaSessionsQuestion(),
  SupervisedMediaSessionsQuestion(),
  SessionQualityAutoQualificationQuestion(),
  WeeklyMediaCoacheeSessionsQuestion(),
  HaveMentorQuestion(),
  IsMentorQuestion(),
  SystematizedServiceGradeQuestion(),
  ProcessOfferGradeQuestion(),
  ClientImportanceAutoQualificationQuestion(),
  PaidSessionsPercentageQuestion(),
  MinPaymentPercentageQuestion(),
  MensualMediaIncomeQuestion(),
  CoachServiceDifferentiationQuestion(),
  QuantityOfRecommendationsQuestion(),
  FeedbackQuestion(),
  PhysicalActivityQuestion(),
  FamiliarRelationshipQuestion(),
  SocialRelationshipQuestion(),
  NatureContactQuestion(),
  RelaxTimeQuestion(),
  CoworkersActivitiesQuestion(),
  ProfessionCommunityQuestion(),
  ProfessionIntelectualQuestion(),
  CertificationsQuestion(),
};

class Level {
  static const beginner = 'beginner';
  static const advancedBeginner = 'advanced_beginner';
  static const advanced = 'advanced';
  static const expert = 'expert';
  static const master = 'master';
}
