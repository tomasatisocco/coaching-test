class CoachingTest {
  const CoachingTest({
    this.profesionalImprovement,
    this.weeklyMediaSessions,
    this.supervisedMediaSessions,
    this.sessionQualityAutoQualification,
    this.weeklyMediaCoacheeSessions,
    this.haveMentor,
    this.isMentor,
    this.systematizedServiceGrade,
    this.processOfferGrade,
    this.clientImportanceAutoQualification,
    this.paidSessionsPercentage,
    this.minPaymentPercentage,
    this.mensualMediaIncome,
    this.coachServiceDifferentiation,
    this.quantityOfRecommendations,
    this.feedBack,
    this.physicalActivity,
    this.familiarRelationship,
    this.socialRelationship,
    this.natureContact,
    this.relaxTime,
    this.coworkersActivities,
    this.professionCommunityContributions,
    this.professionIntelectualContributions,
    this.certification,
    required this.email,
    required this.coachingTestDate,
  });

  factory CoachingTest.newTest(String email) {
    return CoachingTest(
      email: email,
      coachingTestDate: DateTime.now(),
    );
  }

  // Part 0 - General Information
  final String email;
  final DateTime coachingTestDate;

  // Part 1 - Quality of Service
  final int? profesionalImprovement;
  final int? weeklyMediaSessions;
  final int? supervisedMediaSessions;
  final int? sessionQualityAutoQualification;
  final int? weeklyMediaCoacheeSessions;
  final int? haveMentor;
  final int? isMentor;
  final int? systematizedServiceGrade;
  final int? processOfferGrade;
  final int? clientImportanceAutoQualification;

  // Part 2 - Business Creation
  final int? paidSessionsPercentage;
  final int? minPaymentPercentage;
  final int? mensualMediaIncome;
  final int? coachServiceDifferentiation;
  final int? quantityOfRecommendations;
  final int? feedBack;

  // Part 3 - Personal wellness
  final int? physicalActivity;
  final int? familiarRelationship;
  final int? socialRelationship;
  final int? natureContact;
  final int? relaxTime;

  // Part 4 - Contributions to professional community
  final int? coworkersActivities;
  final int? professionCommunityContributions;
  final int? professionIntelectualContributions;
  final int? certification;

  bool get isTestCompleted {
    return profesionalImprovement != null &&
        weeklyMediaSessions != null &&
        supervisedMediaSessions != null &&
        sessionQualityAutoQualification != null &&
        weeklyMediaCoacheeSessions != null &&
        haveMentor != null &&
        isMentor != null &&
        systematizedServiceGrade != null &&
        processOfferGrade != null &&
        clientImportanceAutoQualification != null &&
        paidSessionsPercentage != null &&
        minPaymentPercentage != null &&
        mensualMediaIncome != null &&
        coachServiceDifferentiation != null &&
        quantityOfRecommendations != null &&
        feedBack != null &&
        physicalActivity != null &&
        familiarRelationship != null &&
        socialRelationship != null &&
        natureContact != null &&
        relaxTime != null &&
        coworkersActivities != null &&
        professionCommunityContributions != null &&
        professionIntelectualContributions != null &&
        certification != null;
  }

  int? get qualityOfServiceQualification {
    if (!isTestCompleted) return null;
    return profesionalImprovement! +
        weeklyMediaSessions! +
        supervisedMediaSessions! +
        sessionQualityAutoQualification! +
        weeklyMediaCoacheeSessions! +
        haveMentor! +
        isMentor! +
        systematizedServiceGrade! +
        processOfferGrade! +
        clientImportanceAutoQualification!;
  }

  int? get businessCreationQualification {
    if (!isTestCompleted) return null;
    return paidSessionsPercentage! +
        minPaymentPercentage! +
        mensualMediaIncome! +
        coachServiceDifferentiation! +
        quantityOfRecommendations! +
        feedBack!;
  }

  int? get personalWellnessQualification {
    if (!isTestCompleted) return null;
    return physicalActivity! +
        familiarRelationship! +
        socialRelationship! +
        natureContact! +
        relaxTime!;
  }

  int? get contributionsToProfessionalCommunityQualification {
    if (!isTestCompleted) return null;
    return coworkersActivities! +
        professionCommunityContributions! +
        professionIntelectualContributions! +
        certification!;
  }

  int? get totalQualification {
    if (!isTestCompleted) return null;
    return qualityOfServiceQualification! +
        businessCreationQualification! +
        personalWellnessQualification! +
        contributionsToProfessionalCommunityQualification!;
  }

  CoachingTest copyWith({
    int? profesionalImprovement,
    int? weeklyMediaSessions,
    int? supervisedMediaSessions,
    int? sessionQualityAutoQualification,
    int? weeklyMediaCoacheeSessions,
    int? haveMentor,
    int? isMentor,
    int? systematizedServiceGrade,
    int? processOfferGrade,
    int? clientImportanceAutoQualification,
    int? paidSessionsPercentage,
    int? minPaymentPercentage,
    int? mensualMediaIncome,
    int? coachServiceDifferentiation,
    int? quantityOfRecommendations,
    int? feedBack,
    int? physicalActivity,
    int? familiarRelationship,
    int? socialRelationship,
    int? natureContact,
    int? relaxTime,
    int? coworkersActivities,
    int? professionCommunityContributions,
    int? professionIntelectualContributions,
    int? certification,
    String? email,
    DateTime? coachingTestDate,
  }) {
    return CoachingTest(
      profesionalImprovement:
          profesionalImprovement ?? this.profesionalImprovement,
      weeklyMediaSessions: weeklyMediaSessions ?? this.weeklyMediaSessions,
      supervisedMediaSessions:
          supervisedMediaSessions ?? this.supervisedMediaSessions,
      sessionQualityAutoQualification: sessionQualityAutoQualification ??
          this.sessionQualityAutoQualification,
      weeklyMediaCoacheeSessions:
          weeklyMediaCoacheeSessions ?? this.weeklyMediaCoacheeSessions,
      haveMentor: haveMentor ?? this.haveMentor,
      isMentor: isMentor ?? this.isMentor,
      systematizedServiceGrade:
          systematizedServiceGrade ?? this.systematizedServiceGrade,
      processOfferGrade: processOfferGrade ?? this.processOfferGrade,
      clientImportanceAutoQualification: clientImportanceAutoQualification ??
          this.clientImportanceAutoQualification,
      paidSessionsPercentage:
          paidSessionsPercentage ?? this.paidSessionsPercentage,
      minPaymentPercentage: minPaymentPercentage ?? this.minPaymentPercentage,
      mensualMediaIncome: mensualMediaIncome ?? this.mensualMediaIncome,
      coachServiceDifferentiation:
          coachServiceDifferentiation ?? this.coachServiceDifferentiation,
      quantityOfRecommendations:
          quantityOfRecommendations ?? this.quantityOfRecommendations,
      feedBack: feedBack ?? this.feedBack,
      physicalActivity: physicalActivity ?? this.physicalActivity,
      familiarRelationship: familiarRelationship ?? this.familiarRelationship,
      socialRelationship: socialRelationship ?? this.socialRelationship,
      natureContact: natureContact ?? this.natureContact,
      relaxTime: relaxTime ?? this.relaxTime,
      coworkersActivities: coworkersActivities ?? this.coworkersActivities,
      professionCommunityContributions: professionCommunityContributions ??
          this.professionCommunityContributions,
      professionIntelectualContributions: professionIntelectualContributions ??
          this.professionIntelectualContributions,
      certification: certification ?? this.certification,
      email: email ?? this.email,
      coachingTestDate: coachingTestDate ?? this.coachingTestDate,
    );
  }

  Map<String, int> toMap() {
    return {
      'profesionalImprovement': profesionalImprovement!,
      'weeklyMediaSessions': weeklyMediaSessions!,
      'supervisedMediaSessions': supervisedMediaSessions!,
      'sessionQualityAutoQualification': sessionQualityAutoQualification!,
      'weeklyMediaCoacheeSessions': weeklyMediaCoacheeSessions!,
      'haveMentor': haveMentor!,
      'isMentor': isMentor!,
      'systematizedServiceGrade': systematizedServiceGrade!,
      'processOfferGrade': processOfferGrade!,
      'clientImportanceAutoQualification': clientImportanceAutoQualification!,
      'paidSessionsPercentage': paidSessionsPercentage!,
      'minPaymentPercentage': minPaymentPercentage!,
      'mensualMediaIncome': mensualMediaIncome!,
      'coachServiceDifferentiation': coachServiceDifferentiation!,
      'quantityOfRecommendations': quantityOfRecommendations!,
      'feedBack': feedBack!,
      'physicalActivity': physicalActivity!,
      'familiarRelationship': familiarRelationship!,
      'socialRelationship': socialRelationship!,
      'natureContact': natureContact!,
      'relaxTime': relaxTime!,
      'coworkersActivities': coworkersActivities!,
      'professionCommunityContributions': professionCommunityContributions!,
      'professionIntelectualContributions': professionIntelectualContributions!,
      'certification': certification!,
      'email': email.hashCode,
      'coachingTestDate': coachingTestDate.millisecondsSinceEpoch,
    };
  }
}
