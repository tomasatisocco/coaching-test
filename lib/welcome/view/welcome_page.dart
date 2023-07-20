import 'package:coaching/app/widgets/coaching_app_bar.dart';
import 'package:coaching/app/widgets/coaching_drawer.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/cubit/welcome_cubit.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:coaching/welcome/widgets/welcome_form_widget.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
    required this.userDataModel,
  });

  static const name = 'Welcome Page';
  final UserDataModel userDataModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeCubit(
        firestoreRepository: context.read<FirestoreRepository>(),
        dataPersistenceRepository: context.read<DataPersistenceRepository>(),
        userDataModel: userDataModel,
      ),
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return (sizingInformation.isMobile || sizingInformation.isTablet)
              ? const WelcomePageMobileView()
              : const WelcomePageDesktopView();
        },
      ),
    );
  }
}

class WelcomePageMobileView extends StatelessWidget {
  const WelcomePageMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoachingAppBar(),
      endDrawer: const CoachingDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    context.l10n.welcome,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/live_as_coach_cover.png',
                          width: 350,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Text(
                      context.l10n.fillForm,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const WelcomeFormWidget(width: 300),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomePageDesktopView extends StatelessWidget {
  const WelcomePageDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CoachingAppBar(),
      endDrawer: const CoachingDrawer(),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(48),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        context.l10n.welcome,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        context.l10n.fillForm,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    WelcomeFormWidget(
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/live_as_coach_cover.png',
                  width: 450,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
