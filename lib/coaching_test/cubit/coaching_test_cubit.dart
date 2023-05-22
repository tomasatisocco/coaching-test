import 'package:bloc/bloc.dart';
import 'package:coaching/coaching_test/models/pdf_page.dart';
import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:storage_repository/storage_repository.dart';

part 'coaching_test_state.dart';

class CoachingTestCubit extends Cubit<CoachingTestState> {
  CoachingTestCubit({
    required FirestoreRepository firestoreRepository,
    required DataPersistenceRepository dataPersistenceRepository,
    required StorageRepository storageRepository,
  })  : _firestoreRepository = firestoreRepository,
        _dataPersistenceRepository = dataPersistenceRepository,
        _storageRepository = storageRepository,
        super(
          CoachingTestInitial(CoachingTest.newTest('')),
        );

  final FirestoreRepository _firestoreRepository;
  final DataPersistenceRepository _dataPersistenceRepository;
  final StorageRepository _storageRepository;

  void init() {
    final localTest = _dataPersistenceRepository.getCoachingTest();
    if (localTest != null) {
      return emit(CoachingTestUpdated(CoachingTest.fromMap(localTest)));
    }
    final userId = _dataPersistenceRepository.getUserId()!;
    emit(CoachingTestUpdated(CoachingTest.newTest(userId)));
  }

  Future<void> updateTest(String key, int value) async {
    emit(CoachingTestUpdating(state.testModel));
    final updatedTest = _updateTest(key, value);
    await _dataPersistenceRepository.setCoachingTest(updatedTest.toMap());
    emit(CoachingTestUpdated(updatedTest));
  }

  Future<void> submitTest(AppLocalizations l10n) async {
    emit(CoachingTestUpdating(state.testModel));
    try {
      await _uploadPDF(l10n);
      await _firestoreRepository.addCoachingTest(state.testModel.toMap());
      return emit(CoachingTestSuccess(state.testModel));
    } catch (e) {
      return emit(CoachingTestError(state.testModel));
    }
  }

  Future<void> _uploadPDF(AppLocalizations l10n) async {
    final pdf = pw.Document();
    final pdfPage = resultPdfPage(state.testModel, l10n);
    pdf.addPage(
      pdfPage,
    );
    final savedPdf = await pdf.save();
    await _storageRepository.uploadFile(
      savedPdf,
      state.testModel.userId,
    );
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
