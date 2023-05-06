import 'dart:async';

import 'package:coaching/app/app.dart';
import 'package:coaching/bootstrap.dart';
import 'package:coaching/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestoreRepository = FirestoreRepository.staging();

  unawaited(
    bootstrap(
      () => App(
        firestoreRepository: firestoreRepository,
      ),
    ),
  );
}
