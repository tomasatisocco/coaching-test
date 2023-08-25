import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:coaching/app/app.dart';
import 'package:coaching/bootstrap.dart';
import 'package:coaching/firebase_options.dart';
import 'package:coaching/remote_configs.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:functions_repository/functions_repository.dart';
import 'package:storage_repository/storage_repository.dart';

void main() async {
  usePathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestoreRepository = FirestoreRepository.production();
  final storageRepository = StorageRepository.production();
  final dataPersistenceRepository = DataPersistenceRepository();
  final remoteConfigurations = RemoteConfigurations();
  final authRepository = AuthRepository();
  const functionsRepository = FunctionsRepository();

  await dataPersistenceRepository.init();
  await remoteConfigurations.init();
  await authRepository.init();

  unawaited(
    bootstrap(
      () => App(
        firestoreRepository: firestoreRepository,
        storageRepository: storageRepository,
        dataPersistenceRepository: dataPersistenceRepository,
        remoteConfigurations: remoteConfigurations,
        authRepository: authRepository,
        functionsRepository: functionsRepository,
      ),
    ),
  );
}
