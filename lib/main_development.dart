import 'dart:async';

import 'package:coaching/app/app.dart';
import 'package:coaching/bootstrap.dart';
import 'package:coaching/firebase_options.dart';
import 'package:coaching/remote_configs.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:storage_repository/storage_repository.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestoreRepository = FirestoreRepository.development();
  final storageRepository = StorageRepository.development();
  final dataPersistenceRepository = DataPersistenceRepository();
  final remoteConfigurations = RemoteConfigurations();

  await dataPersistenceRepository.init();
  await remoteConfigurations.init();

  unawaited(
    bootstrap(
      () => App(
        firestoreRepository: firestoreRepository,
        storageRepository: storageRepository,
        dataPersistenceRepository: dataPersistenceRepository,
        remoteConfigurations: remoteConfigurations,
      ),
    ),
  );
}
