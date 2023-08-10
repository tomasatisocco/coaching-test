import 'package:bloc/bloc.dart';
import 'package:coaching/coaching_test/models/pdf_page.dart';
import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
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

  Future<void> init() async {
    try {
      final user =
          UserDataModel.fromJson(_dataPersistenceRepository.getUser()!);
      if (user.status == Status.testStarted) return;
      final updated = user.copyWith(status: Status.testStarted);
      final localTest = _dataPersistenceRepository.getCoachingTest();
      if (localTest != null) {
        emit(CoachingTestUpdated(CoachingTest.fromMap(localTest)));
      } else {
        emit(CoachingTestUpdated(CoachingTest.newTest(user.id!)));
      }
      await _firestoreRepository.updateUser(updated.toMap(), user.id!);
    } catch (_) {}
  }

  Future<void> updateTest(String key, int value) async {
    emit(CoachingTestUpdating(state.testModel));
    final updatedTest = _updateTest(key, value);
    final map = await updatedTest.toMap();
    await _dataPersistenceRepository.setCoachingTest(map);
    emit(CoachingTestUpdated(updatedTest));
  }

  Future<void> submitTest(AppLocalizations l10n) async {
    emit(CoachingTestUpdating(state.testModel));
    try {
      await _uploadPDF(l10n);
      final map = await state.testModel.toMap();
      final testId = await _firestoreRepository.addCoachingTest(map);
      final user =
          UserDataModel.fromJson(_dataPersistenceRepository.getUser()!);
      final updated = user.copyWith(
        status: Status.testCompleted,
        testIds: [
          ...user.testIds ?? [],
          testId,
        ],
        isPaid: false,
      );
      await _firestoreRepository.updateUser(updated.toMap(), user.id!);
      await _dataPersistenceRepository.setUser(updated.toJson());
      await _dataPersistenceRepository.setCoachingTest(updated.toMap());
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

  CoachingTest _updateTest(String key, int value) =>
      state.testModel.updateAnswer(key, value);

  int getInitialValue(String key) {
    return state.testModel.questions
            .firstWhere((element) => element.key == key)
            .value ??
        0;
  }
}
