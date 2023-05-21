import 'dart:async';

import 'package:coaching/app/app.dart';
import 'package:coaching/bootstrap.dart';
import 'package:coaching/firebase_options.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:storage_repository/storage_repository.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestoreRepository = FirestoreRepository.production();
  final storageRepository = StorageRepository.production();
  final dataPersistenceRepository = DataPersistenceRepository();

  await dataPersistenceRepository.init();

  unawaited(
    bootstrap(
      () => App(
        firestoreRepository: firestoreRepository,
        storageRepository: storageRepository,
        dataPersistenceRepository: dataPersistenceRepository,
      ),
    ),
  );
}
