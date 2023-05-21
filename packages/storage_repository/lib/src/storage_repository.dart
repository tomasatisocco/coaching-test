import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

/// {@template storage_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class StorageRepository {
  /// {@macro storage_repository}
  const StorageRepository(Reference environmentReference)
      : _environmentReference = environmentReference;

  /// Creates a new [StorageRepository] instance for development.
  factory StorageRepository.development() => StorageRepository(
        FirebaseStorage.instance.ref().child('development'),
      );

  /// Creates a new [StorageRepository] instance for staging.
  factory StorageRepository.staging() => StorageRepository(
        FirebaseStorage.instance.ref().child('staging'),
      );

  /// Creates a new [StorageRepository] instance for production.
  factory StorageRepository.production() => StorageRepository(
        FirebaseStorage.instance.ref().child('production'),
      );

  final Reference _environmentReference;

  /// Uploads a file to Firebase Storage.
  Future<void> uploadFile(File file, String fileName) async {
    await _environmentReference.putFile(
      file,
      SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'fileName': fileName},
      ),
    );
  }
}
