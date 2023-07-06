import 'package:firebase_auth/firebase_auth.dart';

/// {@template auth_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AuthRepository {
  /// {@macro auth_repository}
  AuthRepository();

  late final FirebaseAuth _firebaseAuth;

  /// Creates a new [AuthRepository] instance.
  Future<void> init() async {
    _firebaseAuth = FirebaseAuth.instance;
  }

  /// Listen to the current authentication state.
  Stream<User?> listenToAuthState() => _firebaseAuth.authStateChanges();

  /// Signs in with the given [email] and [password].
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

  /// Signs out the current user which will emit
  Future<void> signOut() async => _firebaseAuth.signOut();
}
