import 'package:bloc/bloc.dart';
import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';

part 'coaching_test_state.dart';

class CoachingTestCubit extends Cubit<CoachingTestState> {
  CoachingTestCubit({
    required String email,
    required FirestoreRepository firestoreRepository,
  })  : _firestoreRepository = firestoreRepository,
        super(
          CoachingTestInitial(CoachingTest.newTest(email)),
        );

  final FirestoreRepository _firestoreRepository;

  void updateTest(String key, int value) {
    emit(CoachingTestUpdating(state.testModel));
    final updatedTest = _updateTest(key, value);
    emit(CoachingTestUpdated(updatedTest));
  }

  Future<void> submitTest() async {
    emit(CoachingTestUpdating(state.testModel));
    await _firestoreRepository.addCoachingTest(state.testModel.toMap());
    emit(CoachingTestSuccess(state.testModel));
  }

  CoachingTest _updateTest(String key, int value) {
    final test = state.testModel;
    switch (key) {
      case '101':
        return test.copyWith(profesionalImprovement: value);
      case '102':
        return test.copyWith(weeklyMediaSessions: value);
      case '103':
        return test.copyWith(supervisedMediaSessions: value);
      case '104':
        return test.copyWith(sessionQualityAutoQualification: value);
      case '105':
        return test.copyWith(weeklyMediaCoacheeSessions: value);
      case '106':
        return test.copyWith(haveMentor: value);
      case '107':
        return test.copyWith(isMentor: value);
      case '108':
        return test.copyWith(systematizedServiceGrade: value);
      case '109':
        return test.copyWith(processOfferGrade: value);
      case '110':
        return test.copyWith(clientImportanceAutoQualification: value);
      case '201':
        return test.copyWith(paidSessionsPercentage: value);
      case '202':
        return test.copyWith(minPaymentPercentage: value);
      case '203':
        return test.copyWith(mensualMediaIncome: value);
      case '204':
        return test.copyWith(coachServiceDifferentiation: value);
      case '205':
        return test.copyWith(quantityOfRecommendations: value);
      case '206':
        return test.copyWith(feedBack: value);
      case '301':
        return test.copyWith(physicalActivity: value);
      case '302':
        return test.copyWith(familiarRelationship: value);
      case '303':
        return test.copyWith(socialRelationship: value);
      case '304':
        return test.copyWith(natureContact: value);
      case '305':
        return test.copyWith(relaxTime: value);
      case '401':
        return test.copyWith(coworkersActivities: value);
      case '402':
        return test.copyWith(professionCommunityContributions: value);
      case '403':
        return test.copyWith(professionIntelectualContributions: value);
      case '404':
        return test.copyWith(certification: value);
      default:
        return test;
    }
  }
}
