import 'package:coaching/coaching_test/models/question_model.dart';
import 'package:coaching/coaching_test/models/test_model_keys.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/remote_configs.dart';

class ProfesionalImprovementQuestion extends QuestionModel {
  ProfesionalImprovementQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.profesionalImprovement,
          questionImage: 'assets/images/coaching.jpg',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question101;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question101Description;

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
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question102Description;

  @override
  WeeklyMediaSessionsQuestion updateValue(int value) {
    return WeeklyMediaSessionsQuestion(value: value * multiplier);
  }
}

class SupervisedMediaSessionsQuestion extends QuestionModel {
  SupervisedMediaSessionsQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.supervisedMediaSessions,
          questionImage: 'assets/images/coaching.jpg',
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
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question103Description;

  @override
  SupervisedMediaSessionsQuestion updateValue(int value) {
    return SupervisedMediaSessionsQuestion(value: value * multiplier);
  }
}

class SessionQualityAutoQualificationQuestion extends QuestionModel {
  SessionQualityAutoQualificationQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.sessionQualityAutoQualification,
          questionImage: 'assets/images/coaching.jpg',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question104;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question104Description;

  @override
  SessionQualityAutoQualificationQuestion updateValue(int value) {
    return SessionQualityAutoQualificationQuestion(value: value * multiplier);
  }
}

class WeeklyMediaCoacheeSessionsQuestion extends QuestionModel {
  WeeklyMediaCoacheeSessionsQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.weeklyMediaCoacheeSessions,
          questionImage: 'assets/images/coaching.jpg',
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
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question105Description;

  @override
  WeeklyMediaCoacheeSessionsQuestion updateValue(int value) {
    return WeeklyMediaCoacheeSessionsQuestion(value: value * multiplier);
  }
}

class HaveMentorQuestion extends QuestionModel {
  HaveMentorQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.haveMentor,
          questionImage: 'assets/images/coaching.jpg',
        );

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        l10n.no: 0,
        l10n.yes: 1,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question106;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question106Description;

  @override
  HaveMentorQuestion updateValue(int value) {
    return HaveMentorQuestion(value: value * multiplier);
  }
}

class IsMentorQuestion extends QuestionModel {
  IsMentorQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.isMentor,
          questionImage: 'assets/images/coaching.jpg',
        );

  @override
  Map<String, int> answers(AppLocalizations l10n) => {
        l10n.no: 0,
        l10n.yes: 1,
      };

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question107;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question107Description;

  @override
  IsMentorQuestion updateValue(int value) {
    return IsMentorQuestion(value: value * multiplier);
  }
}

class SystematizedServiceGradeQuestion extends QuestionModel {
  SystematizedServiceGradeQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.systematizedServiceGrade,
          questionImage: 'assets/images/coaching.jpg',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question108;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question108Description;

  @override
  SystematizedServiceGradeQuestion updateValue(int value) {
    return SystematizedServiceGradeQuestion(value: value * multiplier);
  }
}

class ProcessOfferGradeQuestion extends QuestionModel {
  ProcessOfferGradeQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.processOfferGrade,
          multiplier: 3,
          questionImage: 'assets/images/coaching.jpg',
        );

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
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question109Description;

  @override
  ProcessOfferGradeQuestion updateValue(int value) {
    return ProcessOfferGradeQuestion(value: value * multiplier);
  }
}

class ClientImportanceAutoQualificationQuestion extends QuestionModel {
  ClientImportanceAutoQualificationQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.clientImportanceAutoQualification,
          questionImage: 'assets/images/coaching.jpg',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question110;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question110Description;

  @override
  ClientImportanceAutoQualificationQuestion updateValue(int value) {
    return ClientImportanceAutoQualificationQuestion(value: value * multiplier);
  }
}

class PaidSessionsPercentageQuestion extends QuestionModel {
  PaidSessionsPercentageQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.paidSessionsPercentage,
          questionImage: 'assets/images/business.jpeg',
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
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question201Description;

  @override
  PaidSessionsPercentageQuestion updateValue(int value) {
    return PaidSessionsPercentageQuestion(value: value * multiplier);
  }
}

class MinPaymentPercentageQuestion extends QuestionModel {
  MinPaymentPercentageQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.minPaymentPercentage,
          questionImage: 'assets/images/business.jpeg',
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
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question202Description +
      l10n.dollarPrice +
      remoteConfigs.dollarPrice.toString();

  @override
  MinPaymentPercentageQuestion updateValue(int value) {
    return MinPaymentPercentageQuestion(value: value * multiplier);
  }
}

class MensualMediaIncomeQuestion extends QuestionModel {
  MensualMediaIncomeQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.mensualMediaIncome,
          multiplier: 5,
          questionImage: 'assets/images/business.jpeg',
        );

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
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question203Description +
      l10n.dollarPrice +
      remoteConfigs.dollarPrice.toString();

  @override
  MensualMediaIncomeQuestion updateValue(int value) {
    return MensualMediaIncomeQuestion(value: value * multiplier);
  }
}

class CoachServiceDifferentiationQuestion extends QuestionModel {
  CoachServiceDifferentiationQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.coachServiceDifferentiation,
          questionImage: 'assets/images/business.jpeg',
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
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question204Description;

  @override
  CoachServiceDifferentiationQuestion updateValue(int value) {
    return CoachServiceDifferentiationQuestion(value: value * multiplier);
  }
}

class QuantityOfRecommendationsQuestion extends QuestionModel {
  QuantityOfRecommendationsQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.quantityOfRecommendations,
          questionImage: 'assets/images/business.jpeg',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question205;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question205Description;

  @override
  QuantityOfRecommendationsQuestion updateValue(int value) {
    return QuantityOfRecommendationsQuestion(value: value * multiplier);
  }
}

class FeedbackQuestion extends QuestionModel {
  FeedbackQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.feedBack,
          questionImage: 'assets/images/business.jpeg',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question206;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question206Description;

  @override
  FeedbackQuestion updateValue(int value) {
    return FeedbackQuestion(value: value * multiplier);
  }
}

class PhysicalActivityQuestion extends QuestionModel {
  PhysicalActivityQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.physicalActivity,
          questionImage: 'assets/images/wellness.png',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question301;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question301Description;

  @override
  PhysicalActivityQuestion updateValue(int value) {
    return PhysicalActivityQuestion(value: value * multiplier);
  }
}

class FamiliarRelationshipQuestion extends QuestionModel {
  FamiliarRelationshipQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.familiarRelationship,
          questionImage: 'assets/images/wellness.png',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question302;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question302Description;

  @override
  FamiliarRelationshipQuestion updateValue(int value) {
    return FamiliarRelationshipQuestion(value: value * multiplier);
  }
}

class SocialRelationshipQuestion extends QuestionModel {
  SocialRelationshipQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.socialRelationship,
          questionImage: 'assets/images/wellness.png',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question303;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question303Description;

  @override
  SocialRelationshipQuestion updateValue(int value) {
    return SocialRelationshipQuestion(value: value * multiplier);
  }
}

class NatureContactQuestion extends QuestionModel {
  NatureContactQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.natureContact,
          questionImage: 'assets/images/wellness.png',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question304;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question304Description;

  @override
  NatureContactQuestion updateValue(int value) {
    return NatureContactQuestion(value: value * multiplier);
  }
}

class RelaxTimeQuestion extends QuestionModel {
  RelaxTimeQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.relaxTime,
          questionImage: 'assets/images/wellness.png',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question305;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question305Description;

  @override
  RelaxTimeQuestion updateValue(int value) {
    return RelaxTimeQuestion(value: value * multiplier);
  }
}

class CoworkersActivitiesQuestion extends QuestionModel {
  CoworkersActivitiesQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.coworkersActivities,
          questionImage: 'assets/images/community.jpg',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question401;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question401Description;

  @override
  CoworkersActivitiesQuestion updateValue(int value) {
    return CoworkersActivitiesQuestion(value: value * multiplier);
  }
}

class ProfessionCommunityQuestion extends QuestionModel {
  ProfessionCommunityQuestion({super.value})
      : super(
          key: AnswerQuestionKeys.professionCommunityContributions,
          questionImage: 'assets/images/community.jpg',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question402;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question402Description;

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
          questionImage: 'assets/images/community.jpg',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question403;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question403Description;

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
          questionImage: 'assets/images/community.jpg',
        );

  @override
  String getQuestion(AppLocalizations l10n) => l10n.question404;

  @override
  String getDescription(
    AppLocalizations l10n,
    RemoteConfigurations remoteConfigs,
  ) =>
      l10n.question404Description;

  @override
  CertificationsQuestion updateValue(int value) {
    return CertificationsQuestion(value: value * multiplier);
  }
}
