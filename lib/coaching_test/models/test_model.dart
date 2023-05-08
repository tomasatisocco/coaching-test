// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coaching/l10n/l10n.dart';

class CoachingTest {
  const CoachingTest({
    required this.email,
    required this.coachingTestDate,
    required this.questions,
  });

  factory CoachingTest.newTest(String email) {
    return CoachingTest(
        email: email,
        coachingTestDate: DateTime.now(),
        questions: emptyQuestions);
  }

  // Part 0 - General Information
  final String email;
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
      email: email,
      coachingTestDate: coachingTestDate,
      questions: newAnswers.toSet(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'coachingTestDate': coachingTestDate.millisecondsSinceEpoch,
      'answers': questions.map((e) => e.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return '''
        CoachingTest(
          email: $email,
          coachingTestDate: $coachingTestDate,
          answers: $questions,
        )
      ''';
  }

  factory CoachingTest.fromMap(Map<String, dynamic> map) {
    return CoachingTest(
      email: map['email'] as String,
      coachingTestDate:
          DateTime.fromMillisecondsSinceEpoch(map['coachingTestDate'] as int),
      questions: (map['answers'] as List<dynamic>)
          .map<QuestionModel>(
            (e) => QuestionModel.fromMap(e as Map<String, dynamic>)!,
          )
          .toSet(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CoachingTest.fromJson(String source) =>
      CoachingTest.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AnswerQuestionKeys {
  static const String profesionalImprovement = '101';
  static const String weeklyMediaSessions = '102';
  static const String supervisedMediaSessions = '103';
  static const String sessionQualityAutoQualification = '104';
  static const String weeklyMediaCoacheeSessions = '105';
  static const String haveMentor = '106';
  static const String isMentor = '107';
  static const String systematizedServiceGrade = '108';
  static const String processOfferGrade = '109';
  static const String clientImportanceAutoQualification = '110';
  static const String paidSessionsPercentage = '201';
  static const String minPaymentPercentage = '202';
  static const String mensualMediaIncome = '203';
  static const String coachServiceDifferentiation = '204';
  static const String quantityOfRecommendations = '205';
  static const String feedBack = '206';
  static const String physicalActivity = '301';
  static const String familiarRelationship = '302';
  static const String socialRelationship = '303';
  static const String natureContact = '304';
  static const String relaxTime = '305';
  static const String coworkersActivities = '401';
  static const String professionCommunityContributions = '402';
  static const String professionIntelectualContributions = '403';
  static const String certification = '404';
}

abstract class QuestionModel {
  QuestionModel({
    required this.key,
    this.value,
    this.multiplier = 1,
  });

  final String key;
  final int? value;
  final int multiplier;

  String getQuestion(AppLocalizations l10n);
  String getDescription(AppLocalizations l10n);

  Map<String, int> answers(AppLocalizations l10n) => const <String, int>{
        '0': 0,
        '1': 1,
        '2': 2,
        '3': 3,
        '4': 4,
      };

  QuestionModel updateValue(int value);

  Map<String, dynamic> toMap() {
    return {
      key: value,
    };
  }

  static QuestionModel? fromMap(Map<String, dynamic> map) {
    switch (map.keys.first) {
      case AnswerQuestionKeys.profesionalImprovement:
        return ProfesionalImprovementQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.weeklyMediaSessions:
        return WeeklyMediaSessionsQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.supervisedMediaSessions:
        return SupervisedMediaSessionsQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.sessionQualityAutoQualification:
        return SessionQualityAutoQualificationQuestion(
          value: map.values.first as int,
        );
      case AnswerQuestionKeys.weeklyMediaCoacheeSessions:
        return WeeklyMediaCoacheeSessionsQuestion(
          value: map.values.first as int,
        );
      case AnswerQuestionKeys.isMentor:
        return IsMentorQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.haveMentor:
        return HaveMentorQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.systematizedServiceGrade:
        return SystematizedServiceGradeQuestion(
          value: map.values.first as int,
        );
      case AnswerQuestionKeys.processOfferGrade:
        return ProcessOfferGradeQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.clientImportanceAutoQualification:
        return ClientImportanceAutoQualificationQuestion(
          value: map.values.first as int,
        );
      case AnswerQuestionKeys.paidSessionsPercentage:
        return PaidSessionsPercentageQuestion(
          value: map.values.first as int,
        );
      case AnswerQuestionKeys.minPaymentPercentage:
        return MinPaymentPercentageQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.mensualMediaIncome:
        return MensualMediaIncomeQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.coachServiceDifferentiation:
        return CoachServiceDifferentiationQuestion(
          value: map.values.first as int,
        );
      case AnswerQuestionKeys.quantityOfRecommendations:
        return QuantityOfRecommendationsQuestion(
          value: map.values.first as int,
        );
      case AnswerQuestionKeys.feedBack:
        return FeedbackQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.physicalActivity:
        return PhysicalActivityQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.familiarRelationship:
        return FamiliarRelationshipQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.socialRelationship:
        return SocialRelationshipQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.natureContact:
        return NatureContactQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.relaxTime:
        return RelaxTimeQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.coworkersActivities:
        return CoworkersActivitiesQuestion(value: map.values.first as int);
      case AnswerQuestionKeys.professionCommunityContributions:
        return ProfessionCommunityQuestion(
          value: map.values.first as int,
        );
      case AnswerQuestionKeys.professionIntelectualContributions:
        return ProfessionIntelectualQuestion(
          value: map.values.first as int,
        );
      case AnswerQuestionKeys.certification:
        return CertificationsQuestion(value: map.values.first as int);
      default:
        return null;
    }
  }

  @override
  String toString() {
    return '''
        AnswerModel(
          key: $key,
          value: $value,
          multiplier: $multiplier,
        )
      ''';
  }
}

class ProfesionalImprovementQuestion extends QuestionModel {
  ProfesionalImprovementQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.profesionalImprovement,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question101;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question101Description;

  @override
  ProfesionalImprovementQuestion updateValue(int value) {
    return ProfesionalImprovementQuestion(value: value * multiplier);
  }
}

class WeeklyMediaSessionsQuestion extends QuestionModel {
  WeeklyMediaSessionsQuestion({super.value})
      : super(key: AnswerQuestionKeys.weeklyMediaSessions, multiplier: 3);

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        '0%': 0,
        l10n.between1to4: 1,
        l10n.between5to10: 1,
        l10n.between11to20: 2,
        l10n.between21to30: 3,
        l10n.moreThan30: 4,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question102;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question102Description;

  @override
  WeeklyMediaSessionsQuestion updateValue(int value) {
    return WeeklyMediaSessionsQuestion(value: value * multiplier);
  }
}

class SupervisedMediaSessionsQuestion extends QuestionModel {
  SupervisedMediaSessionsQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.supervisedMediaSessions,
        );

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        '0%': 0,
        '10%': 1,
        '25%': 2,
        '50%': 3,
        l10n.byOrder: 4,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question103;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question103Description;

  @override
  SupervisedMediaSessionsQuestion updateValue(int value) {
    return SupervisedMediaSessionsQuestion(value: value * multiplier);
  }
}

class SessionQualityAutoQualificationQuestion extends QuestionModel {
  SessionQualityAutoQualificationQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.sessionQualityAutoQualification,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question104;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question104Description;

  @override
  SessionQualityAutoQualificationQuestion updateValue(int value) {
    return SessionQualityAutoQualificationQuestion(value: value * multiplier);
  }
}

class WeeklyMediaCoacheeSessionsQuestion extends QuestionModel {
  WeeklyMediaCoacheeSessionsQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.weeklyMediaCoacheeSessions,
          multiplier: 3,
        );

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        '0': 0,
        '1': 1,
        '2': 2,
        l10n.between3to5: 3,
        l10n.moreThan5: 4,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question105;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question105Description;

  @override
  WeeklyMediaCoacheeSessionsQuestion updateValue(int value) {
    return WeeklyMediaCoacheeSessionsQuestion(value: value * multiplier);
  }
}

class HaveMentorQuestion extends QuestionModel {
  HaveMentorQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.haveMentor,
        );

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        l10n.no: 0,
        l10n.yes: 1,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question106;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question106Description;

  @override
  HaveMentorQuestion updateValue(int value) {
    return HaveMentorQuestion(value: value * multiplier);
  }
}

class IsMentorQuestion extends QuestionModel {
  IsMentorQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.isMentor,
        );

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        l10n.no: 0,
        l10n.yes: 1,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question107;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question107Description;

  @override
  IsMentorQuestion updateValue(int value) {
    return IsMentorQuestion(value: value * multiplier);
  }
}

class SystematizedServiceGradeQuestion extends QuestionModel {
  SystematizedServiceGradeQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.systematizedServiceGrade,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question108;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question108Description;

  @override
  SystematizedServiceGradeQuestion updateValue(int value) {
    return SystematizedServiceGradeQuestion(value: value * multiplier);
  }
}

class ProcessOfferGradeQuestion extends QuestionModel {
  ProcessOfferGradeQuestion({super.value})
      : super(key: AnswerQuestionKeys.processOfferGrade, multiplier: 3);

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        l10n.noOfferProcess: 0,
        l10n.offerProcessExceptionally: 1,
        l10n.offerProcessFrequently: 1,
        l10n.offerProcessAlways: 2,
        l10n.offerProcessExclusively: 3,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question109;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question109Description;

  @override
  ProcessOfferGradeQuestion updateValue(int value) {
    return ProcessOfferGradeQuestion(value: value * multiplier);
  }
}

class ClientImportanceAutoQualificationQuestion extends QuestionModel {
  ClientImportanceAutoQualificationQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.clientImportanceAutoQualification,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question110;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question110Description;

  @override
  ClientImportanceAutoQualificationQuestion updateValue(int value) {
    return ClientImportanceAutoQualificationQuestion(value: value * multiplier);
  }
}

class PaidSessionsPercentageQuestion extends QuestionModel {
  PaidSessionsPercentageQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.paidSessionsPercentage,
        );

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        '0%': 0,
        l10n.between1to25: 1,
        l10n.between26to50: 2,
        l10n.between51to75: 3,
        l10n.between76to100: 4,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question201;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question201Description;

  @override
  PaidSessionsPercentageQuestion updateValue(int value) {
    return PaidSessionsPercentageQuestion(value: value * multiplier);
  }
}

class MinPaymentPercentageQuestion extends QuestionModel {
  MinPaymentPercentageQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.minPaymentPercentage,
        );

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        l10n.notPaymentYet: 0,
        l10n.between1to10: 1,
        l10n.between11to20: 2,
        l10n.between21to30: 3,
        l10n.moreThan30: 4,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question202;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question202Description;

  @override
  MinPaymentPercentageQuestion updateValue(int value) {
    return MinPaymentPercentageQuestion(value: value * multiplier);
  }
}

class MensualMediaIncomeQuestion extends QuestionModel {
  MensualMediaIncomeQuestion({super.value})
      : super(key: AnswerQuestionKeys.mensualMediaIncome, multiplier: 5);

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        '0': 0,
        l10n.between1to999: 1,
        l10n.between1000to1999: 2,
        l10n.between2000to2999: 3,
        l10n.moreThan3000: 4,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question203;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question203Description;

  @override
  MensualMediaIncomeQuestion updateValue(int value) {
    return MensualMediaIncomeQuestion(value: value * multiplier);
  }
}

class CoachServiceDifferentiationQuestion extends QuestionModel {
  CoachServiceDifferentiationQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.coachServiceDifferentiation,
        );

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        l10n.any: 0,
        l10n.lowPrices: 1,
        l10n.highPrices: 2,
        l10n.typeOfService: 3,
        l10n.onlyOne: 4,
        l10n.firstOne: 5,
        l10n.clientRelationship: 6,
        l10n.paymentMethod: 7,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question204;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question204Description;

  @override
  CoachServiceDifferentiationQuestion updateValue(int value) {
    return CoachServiceDifferentiationQuestion(value: value * multiplier);
  }
}

class QuantityOfRecommendationsQuestion extends QuestionModel {
  QuantityOfRecommendationsQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.quantityOfRecommendations,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question205;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question205Description;

  @override
  QuantityOfRecommendationsQuestion updateValue(int value) {
    return QuantityOfRecommendationsQuestion(value: value * multiplier);
  }
}

class FeedbackQuestion extends QuestionModel {
  FeedbackQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.feedBack,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question206;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question206Description;

  @override
  FeedbackQuestion updateValue(int value) {
    return FeedbackQuestion(value: value * multiplier);
  }
}

class PhysicalActivityQuestion extends QuestionModel {
  PhysicalActivityQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.physicalActivity,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question301;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question301Description;

  @override
  PhysicalActivityQuestion updateValue(int value) {
    return PhysicalActivityQuestion(value: value * multiplier);
  }
}

class FamiliarRelationshipQuestion extends QuestionModel {
  FamiliarRelationshipQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.familiarRelationship,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question302;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question302Description;

  @override
  FamiliarRelationshipQuestion updateValue(int value) {
    return FamiliarRelationshipQuestion(value: value * multiplier);
  }
}

class SocialRelationshipQuestion extends QuestionModel {
  SocialRelationshipQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.socialRelationship,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question303;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question303Description;

  @override
  SocialRelationshipQuestion updateValue(int value) {
    return SocialRelationshipQuestion(value: value * multiplier);
  }
}

class NatureContactQuestion extends QuestionModel {
  NatureContactQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.natureContact,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question304;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question304Description;

  @override
  NatureContactQuestion updateValue(int value) {
    return NatureContactQuestion(value: value * multiplier);
  }
}

class RelaxTimeQuestion extends QuestionModel {
  RelaxTimeQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.relaxTime,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question305;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question305Description;

  @override
  RelaxTimeQuestion updateValue(int value) {
    return RelaxTimeQuestion(value: value * multiplier);
  }
}

class CoworkersActivitiesQuestion extends QuestionModel {
  CoworkersActivitiesQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.coworkersActivities,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question401;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question401Description;

  @override
  CoworkersActivitiesQuestion updateValue(int value) {
    return CoworkersActivitiesQuestion(value: value * multiplier);
  }
}

class ProfessionCommunityQuestion extends QuestionModel {
  ProfessionCommunityQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.professionCommunityContributions,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question402;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question402Description;

  @override
  ProfessionCommunityQuestion updateValue(int value) {
    return ProfessionCommunityQuestion(value: value * multiplier);
  }
}

class ProfessionIntelectualQuestion extends QuestionModel {
  ProfessionIntelectualQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.professionIntelectualContributions,
          multiplier: 3,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question403;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question403Description;

  @override
  ProfessionIntelectualQuestion updateValue(int value) {
    return ProfessionIntelectualQuestion(value: value * multiplier);
  }
}

class CertificationsQuestion extends QuestionModel {
  CertificationsQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.certification,
          multiplier: 3,
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question404;

  @override
  String getDescription(AppLocalizations l10n) => l10n.question404Description;

  @override
  CertificationsQuestion updateValue(int value) {
    return CertificationsQuestion(value: value * multiplier);
  }
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

enum AnswerGroup {
  qualityOfService,
  business,
  personal,
  community;

  int get groupIndex => super.index + 1;
}
