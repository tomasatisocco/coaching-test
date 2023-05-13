import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/coaching_test/view/coaching_test_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/test_results/view/coaching_test_results_page.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.firestoreRepository,
    required this.dataPersistenceRepository,
  });

  final FirestoreRepository firestoreRepository;
  final DataPersistenceRepository dataPersistenceRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: firestoreRepository),
        RepositoryProvider.value(value: dataPersistenceRepository),
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
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC43446)),
        useMaterial3: true,
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
            return const CoachingTestPage();
          },
        ),
        GoRoute(
          path: '/coaching_test_result',
          name: CoachingTestResultPage.name,
          builder: (_, state) {
            final testModelMap =
                context.read<DataPersistenceRepository>().getCoachingTest();
            final testModel = CoachingTest.fromMap(testModelMap!);
            return CoachingTestResultPage(
              testModel: testModel,
            );
          },
        )
      ],
      redirect: (context, state) {
        try {
          final email = context.read<DataPersistenceRepository>().getEmail();
          if (email == null) return '/welcome';
        } catch (_) {
          return '/welcome';
        }
        return null;
      },
    );
  }
}
