import 'package:coaching/admin_panel/admin_login/widgets/admin_drawer.dart';
import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:coaching/admin_panel/admin_page/widgets/user_info_widget.dart';
import 'package:coaching/admin_panel/admin_page/widgets/users_column.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminUsersCubit(
            firestoreRepository: context.read<FirestoreRepository>(),
          )..init(),
        ),
      ],
      child: const AdminView(),
    );
  }
}

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.admin,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      endDrawer: const AdminDrawer(),
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.isMobile) {
            return const UsersColumn(isMobile: true);
          } else {
            return Row(
              children: [
                const UsersColumn(),
                Column(
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 250,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                        child: Text(
                          context.l10n.results,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const UserInfoWidget(),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
