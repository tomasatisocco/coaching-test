import 'package:coaching/coaching_test/models/question_model_implementation.dart';
import 'package:coaching/coaching_test/models/test_model_keys.dart';
import 'package:coaching/l10n/l10n.dart';

abstract class QuestionModel {
  QuestionModel({
    required this.key,
    this.value,
    this.multiplier = 1,
    this.questionImage = 'assets/images/question.jpg',
  });

  final String key;
  final int? value;
  final int multiplier;
  final String questionImage;

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
        return ProfesionalImprovementQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.weeklyMediaSessions:
        return WeeklyMediaSessionsQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.supervisedMediaSessions:
        return SupervisedMediaSessionsQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.sessionQualityAutoQualification:
        return SessionQualityAutoQualificationQuestion(
          value: map.values.first as int?,
        );
      case AnswerQuestionKeys.weeklyMediaCoacheeSessions:
        return WeeklyMediaCoacheeSessionsQuestion(
          value: map.values.first as int?,
        );
      case AnswerQuestionKeys.isMentor:
        return IsMentorQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.haveMentor:
        return HaveMentorQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.systematizedServiceGrade:
        return SystematizedServiceGradeQuestion(
          value: map.values.first as int?,
        );
      case AnswerQuestionKeys.processOfferGrade:
        return ProcessOfferGradeQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.clientImportanceAutoQualification:
        return ClientImportanceAutoQualificationQuestion(
          value: map.values.first as int?,
        );
      case AnswerQuestionKeys.paidSessionsPercentage:
        return PaidSessionsPercentageQuestion(
          value: map.values.first as int?,
        );
      case AnswerQuestionKeys.minPaymentPercentage:
        return MinPaymentPercentageQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.mensualMediaIncome:
        return MensualMediaIncomeQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.coachServiceDifferentiation:
        return CoachServiceDifferentiationQuestion(
          value: map.values.first as int?,
        );
      case AnswerQuestionKeys.quantityOfRecommendations:
        return QuantityOfRecommendationsQuestion(
          value: map.values.first as int?,
        );
      case AnswerQuestionKeys.feedBack:
        return FeedbackQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.physicalActivity:
        return PhysicalActivityQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.familiarRelationship:
        return FamiliarRelationshipQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.socialRelationship:
        return SocialRelationshipQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.natureContact:
        return NatureContactQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.relaxTime:
        return RelaxTimeQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.coworkersActivities:
        return CoworkersActivitiesQuestion(value: map.values.first as int?);
      case AnswerQuestionKeys.professionCommunityContributions:
        return ProfessionCommunityQuestion(
          value: map.values.first as int?,
        );
      case AnswerQuestionKeys.professionIntelectualContributions:
        return ProfessionIntelectualQuestion(
          value: map.values.first as int?,
        );
      case AnswerQuestionKeys.certification:
        return CertificationsQuestion(value: map.values.first as int?);
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
