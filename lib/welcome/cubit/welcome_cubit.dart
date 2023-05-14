import 'package:bloc/bloc.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit({
    required FirestoreRepository firestoreRepository,
    required DataPersistenceRepository dataPersistenceRepository,
  })  : _firestoreRepository = firestoreRepository,
        _dataPersistenceRepository = dataPersistenceRepository,
        super(WelcomeInitial());

  final FirestoreRepository _firestoreRepository;
  final DataPersistenceRepository _dataPersistenceRepository;

  Future<String?> submitUser(UserDataModel userModel) async {
    emit(WelcomeLoading());
    try {
      final id = await _firestoreRepository.addUser(userModel.toMap());
      await _dataPersistenceRepository.setUserId(id);
      emit(WelcomeLoaded());
      return id;
    } catch (e) {
      emit(WelcomeError());
      return null;
    }
  }
}
