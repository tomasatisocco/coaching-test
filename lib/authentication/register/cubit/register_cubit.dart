import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required AuthRepository authRepository,
    required FirestoreRepository firestoreRepository,
    required DataPersistenceRepository dataPersistenceRepository,
  })  : _authRepository = authRepository,
        _firestoreRepository = firestoreRepository,
        _dataPersistenceRepository = dataPersistenceRepository,
        super(const RegisterInitial());

  final AuthRepository _authRepository;
  final FirestoreRepository _firestoreRepository;
  final DataPersistenceRepository _dataPersistenceRepository;

  /// Signs in with the given [email] and [password].
  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String confirmPassword,
  ) async {
    emit(const RegisterLoading());
    try {
      if (password != confirmPassword) {
        return emit(
          const RegisterFailure('passwords-not-match'),
        );
      }
      final userCredential = await _authRepository.signUpWithEmailAndPassword(
        email,
        password,
      );
      final user = UserDataModel.newUser(
        authId: userCredential.user!.uid,
        createdAt: DateTime.now(),
        email: email,
        name: userCredential.user?.displayName,
      );
      final id = await _firestoreRepository.addUser(user.toMap());
      await _dataPersistenceRepository.setUser(
        user.copyWith(id: id).toJson(),
      );
      emit(RegisterSuccess(user.copyWith(id: id)));
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailure(e.code));
    } catch (e) {
      emit(const RegisterFailure('unknown-error'));
    }
  }
}
