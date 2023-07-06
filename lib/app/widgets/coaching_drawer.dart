import 'package:coaching/admin_panel/admin_login/view/adming_login_page.dart';
import 'package:coaching/app/cubit/localizations_cubit.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CoachingDrawer extends StatelessWidget {
  const CoachingDrawer({super.key});

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
                    Icons.settings,
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
          ListTile(
            title: Text(context.l10n.admin),
            leading: const Icon(Icons.admin_panel_settings),
            onTap: () async {
              context.goNamed(AdminLoginPage.name);
            },
          ),
          ListTile(
            title: Text(context.l10n.language),
            leading: const Icon(Icons.flag_circle_rounded),
            onTap: () async {
              await showDialog<void>(
                context: context,
                builder: (context) => Dialog(
                  child: SizedBox(
                    height: 100,
                    width: 200,
                    child: Column(
                      children: [
                        RadioListTile(
                          title: const Text('English'),
                          value: 'en',
                          activeColor: Theme.of(context).colorScheme.primary,
                          groupValue: context
                              .read<LocalizationsCubit>()
                              .state
                              .locale
                              .languageCode,
                          onChanged: (value) {
                            context.read<LocalizationsCubit>().switchLanguage();
                            Navigator.of(context).pop();
                          },
                        ),
                        RadioListTile(
                          title: const Text('Español'),
                          value: 'es',
                          activeColor: Theme.of(context).colorScheme.primary,
                          groupValue: context
                              .read<LocalizationsCubit>()
                              .state
                              .locale
                              .languageCode,
                          onChanged: (value) {
                            context.read<LocalizationsCubit>().switchLanguage();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
