import 'package:coaching/app/cubit/localizations_cubit.dart';
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
import 'package:storage_repository/storage_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.firestoreRepository,
    required this.dataPersistenceRepository,
    required this.storageRepository,
  });

  final FirestoreRepository firestoreRepository;
  final DataPersistenceRepository dataPersistenceRepository;
  final StorageRepository storageRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: firestoreRepository),
        RepositoryProvider.value(value: dataPersistenceRepository),
        RepositoryProvider.value(value: storageRepository),
      ],
      child: BlocProvider(
        create: (context) => LocalizationsCubit(),
        child: const AppView(),
      ),
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
    return BlocBuilder<LocalizationsCubit, LocalizationsState>(
      builder: (context, state) {
        return MaterialApp.router(
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.from(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              background: const Color(0xFFF9F9F9),
              onBackground: const Color(0xFFC43344),
              primary: const Color(0xFFC43344),
              onPrimary: const Color(0xFFF9F9F9),
              secondary: const Color(0xFFF9F9F9),
              onSecondary: const Color(0xFFC43344),
              tertiary: const Color(0xFFF5F5F5),
              onError: Colors.red,
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.locale,
        );
      },
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
      redirect: (context, state) async {
        try {
          final userId = context.read<DataPersistenceRepository>().getUserId();
          if (userId == null) throw Exception('User id is null.');
        } catch (_) {
          await context.read<DataPersistenceRepository>().deleteCoachingTest();
          return '/welcome';
        }
        return null;
      },
    );
  }
}
