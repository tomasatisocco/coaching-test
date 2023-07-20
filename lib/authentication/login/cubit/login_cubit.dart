import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AuthRepository authRepository,
    required FirestoreRepository firestoreRepository,
  })  : _authRepository = authRepository,
        _firestoreRepository = firestoreRepository,
        super(const LoginInitial());

  final AuthRepository _authRepository;
  final FirestoreRepository _firestoreRepository;

  /// Signs in with the given [email] and [password].
  Future<void> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emit(const LoginLoading());
    try {
      final userCredentials = await _authRepository.signInWithEmailAndPassword(
        email,
        password,
      );
      final userData = await _firestoreRepository.getUserByAuthId(
        userCredentials.user!.uid,
      );

      if (userData == null) {
        final user = UserDataModel.newUser(
          authId: userCredentials.user!.uid,
          createdAt: DateTime.now(),
          email: email,
          name: userCredentials.user?.displayName,
        );
        await _firestoreRepository.addUser(user.toMap());
        return emit(LoginSuccess(user));
      }

      final user = UserDataModel.fromMap(userData);
      return emit(LoginSuccess(user));
    } catch (_) {
      await _authRepository.signOut();
      emit(const LoginFailure());
    }
  }
}
