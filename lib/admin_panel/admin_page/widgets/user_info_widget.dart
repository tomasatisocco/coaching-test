import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:coaching/admin_panel/admin_page/widgets/user_status_row.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AdminUsersCubit, AdminUsersState>(
        builder: (context, state) {
          if (state is! AdminUsersFetched || state.user == null) {
            return Center(
              child: Text(
                context.l10n.notSelected,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          final user = state.user!;
          final userStatus = user.status?.index;
          return Column(
            children: [
              UserStatusRow(userStatus: userStatus ?? 0),
            ],
          );
        },
      ),
    );
  }
}
