import 'dart:async';

import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:coaching/admin_panel/admin_page/widgets/user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersColumn extends StatelessWidget {
  const UsersColumn({
    super.key,
    this.isMobile = false,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final state = context.read<AdminUsersCubit>().state;
        if (state is! AdminUsersFetched) return true;
        final user = state.user;
        if (user == null) return true;
        context.read<AdminUsersCubit>().unSelectUser();
        return false;
      },
      child: Column(
        children: [
          Container(
            height: 40,
            width: isMobile ? MediaQuery.sizeOf(context).width : 250,
            color: Theme.of(context).primaryColor,
            child: const Center(
              child: Text(
                'Usuarios',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: isMobile ? MediaQuery.sizeOf(context).width : 250,
            height: MediaQuery.of(context).size.height - 100,
            color: Colors.grey.shade100,
            child: BlocBuilder<AdminUsersCubit, AdminUsersState>(
              builder: (context, state) {
                if (state is! AdminUsersFetched) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.user != null && isMobile) {
                  return const UserInfoMobileView();
                }
                final users = state.users
                  ..sort(
                    (a, b) => (b.createdAt ?? DateTime.now()).compareTo(
                      a.createdAt ?? DateTime.now(),
                    ),
                  );
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final userId = users[index].authId;
                    final selectedUserId = state.user?.authId;
                    return ListTile(
                      title: Text(users[index].name ?? ''),
                      subtitle: Text(users[index].email ?? ''),
                      selected: selectedUserId == userId,
                      minLeadingWidth: 0,
                      leading: users[index].isRead
                          ? null
                          : const Column(
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.circle,
                                  color: Colors.blue,
                                  size: 10,
                                ),
                                Spacer(),
                              ],
                            ),
                      onTap: () async {
                        if (userId == null) return;
                        unawaited(
                          context
                              .read<AdminUsersCubit>()
                              .markUserAsRead(user: users[index]),
                        );
                        await context
                            .read<AdminUsersCubit>()
                            .selectUser(userId);
                        if (users[index].isRead) return;
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
