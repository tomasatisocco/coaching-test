import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/start_page.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.read<DataPersistenceRepository>().getUser() != null,
      child: ListTile(
        title: Text(context.l10n.logout),
        leading: const Icon(Icons.logout),
        onTap: () async {
          await showDialog<void>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(context.l10n.logout),
                content: Text(context.l10n.sureToLogout),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(context.l10n.cancel),
                  ),
                  TextButton(
                    onPressed: () async {
                      await context
                          .read<DataPersistenceRepository>()
                          .deleteUser();
                      if (!mounted) return;
                      context.goNamed(StartPage.name);
                    },
                    child: Text(context.l10n.logout),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
