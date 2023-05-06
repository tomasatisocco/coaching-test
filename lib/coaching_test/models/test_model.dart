// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  static const int serviceMaxQualification = 55;
  static const int businessMaxQualification = 36;
  static const int personalWellnessMaxQualification = 20;
  static const int professionalCommunityMaxQualification = 32;
  static const int maxQualification = serviceMaxQualification +
      businessMaxQualification +
      personalWellnessMaxQualification +
      professionalCommunityMaxQualification;

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

  int get getQualityOfServiceQualification {
    if (!isTestCompleted) return 0;
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

  int get getBusinessCreationQualification {
    if (!isTestCompleted) return 0;
    return paidSessionsPercentage! +
        minPaymentPercentage! +
        mensualMediaIncome! +
        quantityOfRecommendations! +
        feedBack!;
  }

  int get getPersonalWellnessQualification {
    if (!isTestCompleted) return 0;
    return physicalActivity! +
        familiarRelationship! +
        socialRelationship! +
        natureContact! +
        relaxTime!;
  }

  int get getContributionsToProfessionalCommunityQualification {
    if (!isTestCompleted) return 0;
    return coworkersActivities! +
        professionCommunityContributions! +
        professionIntelectualContributions! +
        certification!;
  }

  int get totalQualification {
    if (!isTestCompleted) return 0;
    return getQualityOfServiceQualification +
        getBusinessCreationQualification +
        getPersonalWellnessQualification +
        getContributionsToProfessionalCommunityQualification;
  }

  int get getTotalQualificationPercentage =>
      (totalQualification * 100) ~/ maxQualification;

  int get getQualityOfServiceQualificationPercentage =>
      (getQualityOfServiceQualification * 100) ~/ serviceMaxQualification;

  int get getBusinessCreationQualificationPercentage =>
      (getBusinessCreationQualification * 100) ~/ businessMaxQualification;

  int get getPersonalWellnessQualificationPercentage =>
      (getPersonalWellnessQualification * 100) ~/
      personalWellnessMaxQualification;

  int get getContributionsQualificationPercentage =>
      (getContributionsToProfessionalCommunityQualification * 100) ~/
      professionalCommunityMaxQualification;

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'coachingTestDate': coachingTestDate.millisecondsSinceEpoch,
      'profesionalImprovement': profesionalImprovement,
      'weeklyMediaSessions': weeklyMediaSessions,
      'supervisedMediaSessions': supervisedMediaSessions,
      'sessionQualityAutoQualification': sessionQualityAutoQualification,
      'weeklyMediaCoacheeSessions': weeklyMediaCoacheeSessions,
      'haveMentor': haveMentor,
      'isMentor': isMentor,
      'systematizedServiceGrade': systematizedServiceGrade,
      'processOfferGrade': processOfferGrade,
      'clientImportanceAutoQualification': clientImportanceAutoQualification,
      'paidSessionsPercentage': paidSessionsPercentage,
      'minPaymentPercentage': minPaymentPercentage,
      'mensualMediaIncome': mensualMediaIncome,
      'coachServiceDifferentiation': coachServiceDifferentiation,
      'quantityOfRecommendations': quantityOfRecommendations,
      'feedBack': feedBack,
      'physicalActivity': physicalActivity,
      'familiarRelationship': familiarRelationship,
      'socialRelationship': socialRelationship,
      'natureContact': natureContact,
      'relaxTime': relaxTime,
      'coworkersActivities': coworkersActivities,
      'professionCommunityContributions': professionCommunityContributions,
      'professionIntelectualContributions': professionIntelectualContributions,
      'certification': certification,
    };
  }

  @override
  String toString() {
    return '''
        CoachingTest(
          email: $email,
          coachingTestDate: $coachingTestDate,
          profesionalImprovement: $profesionalImprovement,
          weeklyMediaSessions: $weeklyMediaSessions,
          supervisedMediaSessions: $supervisedMediaSessions,
          sessionQualityAutoQualification: $sessionQualityAutoQualification,
          weeklyMediaCoacheeSessions: $weeklyMediaCoacheeSessions,
          haveMentor: $haveMentor,
          isMentor: $isMentor,
          systematizedServiceGrade: $systematizedServiceGrade,
          processOfferGrade: $processOfferGrade,
          clientImportanceAutoQualification: $clientImportanceAutoQualification,
          paidSessionsPercentage: $paidSessionsPercentage,
          minPaymentPercentage: $minPaymentPercentage,
          MensualMediaIncome: $mensualMediaIncome,
          coachServiceDifferentiation: $coachServiceDifferentiation,
          quantityOfRecommendations: $quantityOfRecommendations,
          feedBack: $feedBack,
          physicalActivity: $physicalActivity,
          familiarRelationship: $familiarRelationship,
          socialRelationship: $socialRelationship,
          natureContact: $natureContact,
          relaxTime: $relaxTime,
          coworkersActivities: $coworkersActivities,
          professionCommunityContributions: $professionCommunityContributions,
          professionIntelectualContributions: $professionIntelectualContributions,
          certification: $certification
        )
      ''';
  }

  factory CoachingTest.fromMap(Map<String, dynamic> map) {
    return CoachingTest(
      email: map['email'] as String,
      coachingTestDate:
          DateTime.fromMillisecondsSinceEpoch(map['coachingTestDate'] as int),
      profesionalImprovement: map['profesionalImprovement'] != null
          ? map['profesionalImprovement'] as int
          : null,
      weeklyMediaSessions: map['weeklyMediaSessions'] != null
          ? map['weeklyMediaSessions'] as int
          : null,
      supervisedMediaSessions: map['supervisedMediaSessions'] != null
          ? map['supervisedMediaSessions'] as int
          : null,
      sessionQualityAutoQualification:
          map['sessionQualityAutoQualification'] != null
              ? map['sessionQualityAutoQualification'] as int
              : null,
      weeklyMediaCoacheeSessions: map['weeklyMediaCoacheeSessions'] != null
          ? map['weeklyMediaCoacheeSessions'] as int
          : null,
      haveMentor: map['haveMentor'] != null ? map['haveMentor'] as int : null,
      isMentor: map['isMentor'] != null ? map['isMentor'] as int : null,
      systematizedServiceGrade: map['systematizedServiceGrade'] != null
          ? map['systematizedServiceGrade'] as int
          : null,
      processOfferGrade: map['processOfferGrade'] != null
          ? map['processOfferGrade'] as int
          : null,
      clientImportanceAutoQualification:
          map['clientImportanceAutoQualification'] != null
              ? map['clientImportanceAutoQualification'] as int
              : null,
      paidSessionsPercentage: map['paidSessionsPercentage'] != null
          ? map['paidSessionsPercentage'] as int
          : null,
      minPaymentPercentage: map['minPaymentPercentage'] != null
          ? map['minPaymentPercentage'] as int
          : null,
      mensualMediaIncome: map['mensualMediaIncome'] != null
          ? map['mensualMediaIncome'] as int
          : null,
      coachServiceDifferentiation: map['coachServiceDifferentiation'] != null
          ? map['coachServiceDifferentiation'] as int
          : null,
      quantityOfRecommendations: map['quantityOfRecommendations'] != null
          ? map['quantityOfRecommendations'] as int
          : null,
      feedBack: map['feedBack'] != null ? map['feedBack'] as int : null,
      physicalActivity: map['physicalActivity'] != null
          ? map['physicalActivity'] as int
          : null,
      familiarRelationship: map['familiarRelationship'] != null
          ? map['familiarRelationship'] as int
          : null,
      socialRelationship: map['socialRelationship'] != null
          ? map['socialRelationship'] as int
          : null,
      natureContact:
          map['natureContact'] != null ? map['natureContact'] as int : null,
      relaxTime: map['relaxTime'] != null ? map['relaxTime'] as int : null,
      coworkersActivities: map['coworkersActivities'] != null
          ? map['coworkersActivities'] as int
          : null,
      professionCommunityContributions:
          map['professionCommunityContributions'] != null
              ? map['professionCommunityContributions'] as int
              : null,
      professionIntelectualContributions:
          map['professionIntelectualContributions'] != null
              ? map['professionIntelectualContributions'] as int
              : null,
      certification:
          map['certification'] != null ? map['certification'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoachingTest.fromJson(String source) =>
      CoachingTest.fromMap(json.decode(source) as Map<String, dynamic>);
}
