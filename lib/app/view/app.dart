import 'package:auth_repository/auth_repository.dart';
import 'package:coaching/admin_panel/admin_login/view/adming_login_page.dart';
import 'package:coaching/app/cubit/localizations_cubit.dart';
import 'package:coaching/authentication/login/view/login_page.dart';
import 'package:coaching/authentication/register/view/register_page.dart';
import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/coaching_test/view/coaching_test_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/mp_authorized/mp_authorized_page.dart';
import 'package:coaching/payment/view/payment_page.dart';
import 'package:coaching/remote_configs.dart';
import 'package:coaching/start_page.dart';
import 'package:coaching/test_results/view/coaching_test_results_page.dart';
import 'package:coaching/test_results/view/congratulations_page.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:functions_repository/functions_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:storage_repository/storage_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.firestoreRepository,
    required this.dataPersistenceRepository,
    required this.storageRepository,
    required this.remoteConfigurations,
    required this.authRepository,
    required this.functionsRepository,
  });

  final FirestoreRepository firestoreRepository;
  final DataPersistenceRepository dataPersistenceRepository;
  final StorageRepository storageRepository;
  final RemoteConfigurations remoteConfigurations;
  final AuthRepository authRepository;
  final FunctionsRepository functionsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: firestoreRepository),
        RepositoryProvider.value(value: dataPersistenceRepository),
        RepositoryProvider.value(value: storageRepository),
        RepositoryProvider.value(value: remoteConfigurations),
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: functionsRepository),
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
              background: Colors.blueGrey.shade100,
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
      initialLocation: '/start',
      routes: <GoRoute>[
        GoRoute(
          path: '/start',
          name: StartPage.name,
          builder: (_, state) {
            return const StartPage();
          },
        ),
        GoRoute(
          path: '/login',
          name: LoginPage.name,
          builder: (_, state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          path: '/register',
          name: RegisterPage.name,
          builder: (_, state) {
            return const RegisterPage();
          },
        ),
        GoRoute(
          path: '/welcome',
          name: WelcomePage.name,
          builder: (_, state) {
            return const WelcomePage();
          },
        ),
        GoRoute(
          path: '/payment',
          name: PaymentPage.name,
          builder: (_, state) {
            return const PaymentPage();
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
        ),
        GoRoute(
          path: '/congratulations',
          name: CongratulationsPage.name,
          builder: (_, state) {
            return const CongratulationsPage();
          },
        ),
        GoRoute(
          path: '/admin_login',
          name: AdminLoginPage.name,
          builder: (_, state) {
            return const AdminLoginPage();
          },
        ),
        GoRoute(
          path: '/mercadopago',
          name: MPAuthorizedPage.name,
          builder: (_, state) {
            final code = state.queryParameters['code'];
            final identifier = state.queryParameters['state'];
            return MPAuthorizedPage(
              code: code,
              identifier: identifier,
            );
          },
        ),
      ],
      redirect: (context, state) async {
        final location = state.location;

        if (location.contains('mercadopago')) return location;
        if (location == '/admin_login') return location;
        final userMap = context.read<DataPersistenceRepository>().getUser();
        if (userMap == null) return '/start';
        final user = UserDataModel.fromJson(userMap);
        switch (user.status) {
          case Status.registered:
            return '/welcome';
          case Status.infoCompleted:
            return '/payment';
          case Status.testPaid:
          case Status.testStarted:
            return '/coaching_test';
          case Status.resultsSending:
          case Status.resultsSent:
          case Status.testCompleted:
            return '/congratulations';
          case null:
            return '/start';
        }
      },
    );
  }
}
