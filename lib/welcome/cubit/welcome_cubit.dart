import 'package:bloc/bloc.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit({
    required FirestoreRepository firestoreRepository,
    required DataPersistenceRepository dataPersistenceRepository,
    required UserDataModel userDataModel,
  })  : _firestoreRepository = firestoreRepository,
        _dataPersistenceRepository = dataPersistenceRepository,
        _userDataModel = userDataModel,
        super(WelcomeInitial());

  final FirestoreRepository _firestoreRepository;
  final DataPersistenceRepository _dataPersistenceRepository;
  final UserDataModel _userDataModel;

  Future<void> submitUser({
    required String name,
    required String birthDate,
    required String nationality,
    required String residence,
    required String certificateDate,
  }) async {
    emit(WelcomeLoading());
    try {
      final completedUser = _userDataModel.completeUser(
        name: name,
        nationality: nationality,
        residence: residence,
        certificateDate: certificateDate,
      );
      await _firestoreRepository.updateUser(
        completedUser.toMap(),
        completedUser.id!,
      );
      await _dataPersistenceRepository.deleteCoachingTest();
      await _dataPersistenceRepository.setUserId(completedUser.id!);
      emit(WelcomeLoaded());
    } catch (e) {
      emit(WelcomeError());
    }
  }
}
