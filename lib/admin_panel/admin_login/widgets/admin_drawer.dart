import 'package:coaching/admin_panel/admin_login/cubit/admin_login_cubit.dart';
import 'package:coaching/app/widgets/language_switch_widget.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.transparent,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.admin_panel_settings_rounded,
                    size: 24,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    context.l10n.configsTitle,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const LanguageSwitch(),
          const Spacer(),
          Visibility(
            visible: context.read<AdminLoginCubit>().state is AdminLoginSuccess,
            child: ListTile(
              title: Text(context.l10n.logout),
              leading: const Icon(Icons.logout),
              onTap: () async => context.read<AdminLoginCubit>().logout(),
            ),
          ),
        ],
      ),
    );
  }
}
