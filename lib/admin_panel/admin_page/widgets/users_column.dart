import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersColumn extends StatelessWidget {
  const UsersColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 250,
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
          width: 250,
          height: MediaQuery.of(context).size.height - 100,
          color: Colors.grey.shade100,
          child: BlocBuilder<AdminUsersCubit, AdminUsersState>(
            builder: (context, state) {
              if (state is! AdminUsersFetched) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
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
                    onTap: () async {
                      if (userId == null) return;
                      await context.read<AdminUsersCubit>().selectUser(userId);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
