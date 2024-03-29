import 'package:auth_repository/auth_repository.dart';
import 'package:coaching/app/app.dart';
import 'package:coaching/remote_configs.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:storage_repository/storage_repository.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(
        App(
          firestoreRepository: FirestoreRepository.development(),
          storageRepository: StorageRepository.development(),
          dataPersistenceRepository: DataPersistenceRepository(),
          remoteConfigurations: RemoteConfigurations(),
          authRepository: AuthRepository(),
        ),
      );
      expect(find.byType(WelcomePage), findsOneWidget);
    });
  });
}
