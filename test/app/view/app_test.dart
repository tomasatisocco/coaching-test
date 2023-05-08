import 'package:coaching/app/app.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(
        App(
          firestoreRepository: FirestoreRepository.development(),
          dataPersistenceRepository: DataPersistenceRepository(),
        ),
      );
      expect(find.byType(WelcomePage), findsOneWidget);
    });
  });
}
