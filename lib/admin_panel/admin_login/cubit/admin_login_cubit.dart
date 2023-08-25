import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'admin_login_state.dart';

class AdminLoginCubit extends Cubit<AdminLoginState> {
  AdminLoginCubit({
    required AuthRepository authRepository,
    required FirestoreRepository firestoreRepository,
  })  : _authRepository = authRepository,
        _firestoreRepository = firestoreRepository,
        super(const AdminLoginInitial());

  final AuthRepository _authRepository;
  final FirestoreRepository _firestoreRepository;
  late StreamSubscription<User?> _authSubscription;

  Future<void> init() async {
    _authSubscription = _authRepository.listenToAuthState().listen((u) async {
      if (u == null) return emit(const UserLogOutSuccess());
      final isUserAdmin = await _firestoreRepository.isUserAdmin(u.uid);
      if (!isUserAdmin) return emit(const AdminNotAuthorized());
      emit(AdminLoginSuccess(u.email));
    });
  }

  Future<void> login(String email, String password) async {
    try {
      emit(const AdminLoginLoading());
      await _authRepository.signInWithEmailAndPassword(email, password);
    } catch (e) {
      emit(const AdminLoginFailure());
    }
  }

  Future<void> logout() async => _authRepository.signOut();

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
