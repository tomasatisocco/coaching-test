import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/view/welcome_page.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
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
    return ElevatedButton(
      onPressed: () async {
        final dataPersistence = context.read<DataPersistenceRepository>();
        GoRouter.of(context).goNamed(WelcomePage.name);
        await dataPersistence.deleteCoachingTest();
        await dataPersistence.deleteEmail();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          context.l10n.newTest,
          style: TextStyle(
            fontSize: isMobile ? 24 : 36,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
