import 'package:coaching/admin_panel/admin_login/widgets/admin_drawer.dart';
import 'package:coaching/app/widgets/coaching_app_bar.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CoachingAppBar(),
      endDrawer: AdminDrawer(),
    );
  }
}
