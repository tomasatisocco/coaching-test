import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/coaching_test/view/coaching_test_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/test_results/view/coaching_test_results_page.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key, required this.firestoreRepository});

  final FirestoreRepository firestoreRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: firestoreRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late GoRouter _router;

  @override
  void initState() {
    _router = router(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('es'),
    );
  }

  GoRouter router(BuildContext context) {
    return GoRouter(
      initialLocation: '/welcome',
      routes: <GoRoute>[
        GoRoute(
          path: '/welcome',
          name: WelcomePage.name,
          builder: (_, state) {
            return const WelcomePage();
          },
        ),
        GoRoute(
          path: '/coaching_test',
          name: CoachingTestPage.name,
          builder: (_, state) {
            final email = state.extra as String?;
            return CoachingTestPage(
              email: email ?? '',
            );
          },
        ),
        GoRoute(
          path: '/coaching_test_result',
          name: CoachingTestResultPage.name,
          builder: (_, state) {
            final testModel = state.extra as CoachingTest?;
            return CoachingTestResultPage(
              testModel: testModel ?? mockTestModel,
            );
          },
        )
      ],
    );
  }
}

CoachingTest mockTestModel = CoachingTest(
  email: '',
  coachingTestDate: DateTime(2023, 1, 1),
  paidSessionsPercentage: 2,
  physicalActivity: 2,
  processOfferGrade: 3,
  profesionalImprovement: 1,
  professionCommunityContributions: 4,
  professionIntelectualContributions: 2,
  minPaymentPercentage: 1,
  coworkersActivities: 2,
  clientImportanceAutoQualification: 4,
  sessionQualityAutoQualification: 3,
  familiarRelationship: 3,
  feedBack: 2,
  systematizedServiceGrade: 0,
  haveMentor: 1,
  isMentor: 1,
  mensualMediaIncome: 2,
  natureContact: 3,
  quantityOfRecommendations: 2,
  relaxTime: 1,
  socialRelationship: 2,
  supervisedMediaSessions: 3,
  weeklyMediaCoacheeSessions: 2,
  weeklyMediaSessions: 1,
  certification: 2,
  coachServiceDifferentiation: 1,
);
