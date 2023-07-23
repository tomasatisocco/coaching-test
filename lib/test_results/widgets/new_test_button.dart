import 'package:coaching/coaching_test/view/coaching_test_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/test_results/cubit/congratulations_cubit.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewTestButton extends StatelessWidget {
  const NewTestButton({
    super.key,
    this.isMobile = false,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CongratulationsCubit(
        dataPersistenceRepository: context.read<DataPersistenceRepository>(),
        firestoreRepository: context.read<FirestoreRepository>(),
      )..init(),
      child: NewTestButtonView(isMobile: isMobile),
    );
  }
}

class NewTestButtonView extends StatelessWidget {
  const NewTestButtonView({super.key, required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CongratulationsCubit, CongratulationsState>(
      listener: (context, state) {
        if (state is! CongratulationsSuccess) return;
        GoRouter.of(context).goNamed(
          CoachingTestPage.name,
        );
      },
      builder: (context, state) {
        return Visibility(
          visible: state.isPaid,
          child: Column(
            children: [
              Text(
                context.l10n.awesome,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Text(
                context.l10n.newTestPossible,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  final dataPersistence =
                      context.read<DataPersistenceRepository>();
                  GoRouter.of(context).goNamed(WelcomePage.name);
                  await dataPersistence.deleteCoachingTest();
                  await dataPersistence.deleteUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: state is CongratulationsLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          context.l10n.newTest,
                          style: TextStyle(
                            fontSize: isMobile ? 24 : 36,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
