import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'admin_login_state.dart';

class AdminLoginCubit extends Cubit<AdminLoginState> {
  AdminLoginCubit(
      {required AuthRepository authRepository,
      required FirestoreRepository firestoreRepository})
      : _authRepository = authRepository,
        _firestoreRepository = firestoreRepository,
        super(AdminLoginInitial());

  final AuthRepository _authRepository;
  final FirestoreRepository _firestoreRepository;
  late StreamSubscription<User?> _authSubscription;

  Future<void> init() async {
    _authSubscription = _authRepository.listenToAuthState().listen((user) {
      if (user == null) return emit(UserLogOutSuccess());
      emit(AdminLoginSuccess());
    });
  }

  Future<void> login(String email, String password) async {
    try {
      emit(AdminLoginLoading());
      await _authRepository.signInWithEmailAndPassword(email, password);
    } catch (e) {
      emit(AdminLoginFailure());
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
