import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template firestore_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FirestoreRepository {
  /// {@macro firestore_repository}
  const FirestoreRepository(DocumentReference environmentReference)
      : _environmentReference = environmentReference;

  /// Creates a new [FirestoreRepository] instance for development.
  factory FirestoreRepository.development() => FirestoreRepository(
        FirebaseFirestore.instance
            .collection(CollectionKeys.environments)
            .doc(Environments.development),
      );

  /// Creates a new [FirestoreRepository] instance for staging.
  factory FirestoreRepository.staging() => FirestoreRepository(
        FirebaseFirestore.instance
            .collection(CollectionKeys.environments)
            .doc(Environments.staging),
      );

  /// Creates a new [FirestoreRepository] instance for production.
  factory FirestoreRepository.production() => FirestoreRepository(
        FirebaseFirestore.instance
            .collection(CollectionKeys.environments)
            .doc(Environments.production),
      );

  final DocumentReference _environmentReference;

  /// Adds a coaching test to Firestore.
  Future<void> addCoachingTest(Map<String, dynamic> test) async {
    await _environmentReference
        .collection(CollectionKeys.coachingTests)
        .add(test);
  }

  /// Adds a user to Firestore.
  Future<String> addUser(Map<String, dynamic> user) async {
    final reference =
        await _environmentReference.collection(CollectionKeys.users).add(user);

    return reference.id;
  }

  /// Gets a list of coaching tests from Firestore.
  Future<List<Map<String, dynamic>>> getCoachingTestList() async {
    final snapshot = await _environmentReference
        .collection(CollectionKeys.coachingTests)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  /// Gets a list of users from Firestore.
  Future<List<Map<String, dynamic>>> getUserList() async {
    final snapshot =
        await _environmentReference.collection(CollectionKeys.users).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  /// Get a user from Firestore.
  Future<Map<String, dynamic>> getUser(String id) async {
    final snapshot = await _environmentReference
        .collection(CollectionKeys.users)
        .doc(id)
        .get();
    return snapshot.data()!;
  }

  /// Checks if a user is an admin.
  Future<bool> isUserAdmin(String id) async {
    final snapshot = await _environmentReference
        .collection(CollectionKeys.adminUsers)
        .doc('admin_ids')
        .get();
    final adminIds = snapshot.data()!['id_list'] as List<dynamic>;
    return adminIds.contains(id);
  }
}

/// {@template collection_keys}
/// Collection keys used in Firestore.
/// {@endtemplate}
class CollectionKeys {
  /// Environments collection key.
  static const environments = 'environments';

  /// Coaching tests collection key.
  static const coachingTests = 'coaching_tests';

  /// Users collection key.
  static const users = 'users';

  static const adminUsers = 'admin_users';
}

/// {@template environment_keys}
/// Environment keys used in Firestore.
/// {@endtemplate}
class Environments {
  /// Development environment key.
  static const development = 'development';

  /// Staging environment key.
  static const staging = 'staging';

  /// Production environment key.
  static const production = 'production';
}
