// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coaching/coaching_test/models/question_model.dart';
import 'package:coaching/coaching_test/models/question_model_implementation.dart';
import 'package:coaching/coaching_test/models/test_model_keys.dart';
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
    if (!isTestCompleted) return 0;
    var total = 0;
    for (final question in questions) {
      if (question.key.startsWith(group.groupIndex.toString())) {
        total += question.value!;
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

  Map<String, dynamic> toMap() {
    final answersMap = <String, dynamic>{};
    for (final question in questions) {
      answersMap[question.key] = question.value;
    }
    return <String, dynamic>{
      'userId': userId,
      'coachingTestDate':
          DateFormat('yyyy-MM-dd hh:mm').format(coachingTestDate),
      'answers': answersMap,
    };
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
