import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'congratulations_state.dart';

class CongratulationsCubit extends Cubit<CongratulationsState> {
  CongratulationsCubit({
    required FirestoreRepository firestoreRepository,
    required DataPersistenceRepository dataPersistenceRepository,
  })  : _firestoreRepository = firestoreRepository,
        _dataPersistenceRepository = dataPersistenceRepository,
        super(const CongratulationsInitial());

  final FirestoreRepository _firestoreRepository;
  final DataPersistenceRepository _dataPersistenceRepository;
  late StreamSubscription<dynamic> _subscription;

  void init() {
    try {
      final currentUser = UserDataModel.fromJson(
        _dataPersistenceRepository.getUser()!,
      );
      _subscription =
          _firestoreRepository.listenUser(currentUser.id!).listen((userData) {
        final data = userData.data();
        if (data == null) return;
        final user = UserDataModel.fromMap(userData.data()!);
        emit(state.copyWith(isPaid: user.isPaid));
      });
    } catch (_) {}
  }

  Future<void> startNewTest() async {
    emit(const CongratulationsLoading(isPaid: true));
    try {
      final user = UserDataModel.fromJson(
        _dataPersistenceRepository.getUser()!,
      );
      final updated = user.copyWith(status: Status.testPaid, isPaid: true);
      await _firestoreRepository.updateUser(updated.toMap(), user.id!);
      await _dataPersistenceRepository.setUser(updated.toJson());
      await _dataPersistenceRepository.deleteCoachingTest();
      emit(const CongratulationsSuccess(isPaid: true));
    } catch (_) {
      emit(const CongratulationsFailure(isPaid: true));
    }
  }

  @override
  Future<void> close() {
    try {
      _subscription.cancel();
    } catch (_) {}
    return super.close();
  }
}
