import 'package:coaching/admin_panel/admin_login/view/adming_login_page.dart';
import 'package:coaching/app/widgets/language_switch_widget.dart';
import 'package:coaching/app/widgets/logout_button.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';
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
              await context.pushNamed(AdminLoginPage.name);
            },
          ),
          const LanguageSwitch(),
          const Spacer(),
          const LogoutButton(),
        ],
      ),
    );
  }
}
