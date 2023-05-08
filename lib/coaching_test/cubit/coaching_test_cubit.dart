import 'package:bloc/bloc.dart';
import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';

part 'coaching_test_state.dart';

class CoachingTestCubit extends Cubit<CoachingTestState> {
  CoachingTestCubit({
    required FirestoreRepository firestoreRepository,
    required DataPersistenceRepository dataPersistenceRepository,
  })  : _firestoreRepository = firestoreRepository,
        _dataPersistenceRepository = dataPersistenceRepository,
        super(
          CoachingTestInitial(CoachingTest.newTest('')),
        );

  final FirestoreRepository _firestoreRepository;
  final DataPersistenceRepository _dataPersistenceRepository;

  void init() {
    final localTest = _dataPersistenceRepository.getCoachingTest();
    if (localTest != null) {
      return emit(CoachingTestUpdated(CoachingTest.fromMap(localTest)));
    }
    final email = _dataPersistenceRepository.getEmail()!;
    emit(CoachingTestUpdated(CoachingTest.newTest(email)));
  }

  Future<void> updateTest(String key, int value) async {
    emit(CoachingTestUpdating(state.testModel));
    final updatedTest = _updateTest(key, value);
    await _dataPersistenceRepository.setCoachingTest(updatedTest.toMap());
    emit(CoachingTestUpdated(updatedTest));
  }

  Future<void> submitTest() async {
    emit(CoachingTestUpdating(state.testModel));
    await _firestoreRepository.addCoachingTest(state.testModel.toMap());
    emit(CoachingTestSuccess(state.testModel));
  }

  CoachingTest? getLocalTest() {
    try {
      final localTest = _dataPersistenceRepository.getCoachingTest();
      if (localTest == null) return null;
      final coachingTest = CoachingTest.fromMap(localTest);
      emit(CoachingTestUpdated(coachingTest));
      return coachingTest;
    } catch (_) {
      return null;
    }
  }

  CoachingTest _updateTest(String key, int value) =>
      state.testModel.updateAnswer(key, value);

  int getInitialValue(String key) {
    return state.testModel.questions
            .firstWhere((element) => element.key == key)
            .value ??
        0;
  }
}
