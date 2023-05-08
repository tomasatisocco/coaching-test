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

enum AnswerGroup {
  qualityOfService,
  business,
  personal,
  community;

  int get groupIndex => super.index + 1;
}
