import 'package:flutter/material.dart';

class CoachingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoachingAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(32);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 32,
      elevation: 0,
      foregroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
