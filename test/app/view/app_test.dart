import 'package:coaching/app/app.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App(
        firestoreRepository: FirestoreRepository.development(),
      ));
      expect(find.byType(WelcomePage), findsOneWidget);
    });
  });
}
