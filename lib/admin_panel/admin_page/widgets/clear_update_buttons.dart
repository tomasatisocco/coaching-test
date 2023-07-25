import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClearUpdateButtons extends StatelessWidget {
  const ClearUpdateButtons({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isMobile
          ? MediaQuery.sizeOf(context).width
          : MediaQuery.sizeOf(context).width - 250,
      child: BlocBuilder<AdminUsersCubit, AdminUsersState>(
        builder: (context, state) {
          if (state is! AdminUsersFetched) return const SizedBox();
          return Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: context.read<AdminUsersCubit>().isUserUpdated
                    ? () => context.read<AdminUsersCubit>().clearUser()
                    : null,
                child: Text(context.l10n.clear),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: context.read<AdminUsersCubit>().isUserUpdated
                    ? () => context.read<AdminUsersCubit>().updateUser()
                    : null,
                child: state.isUpdating
                    ? const SizedBox(
                        height: 20,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text(context.l10n.update),
              ),
              IconButton(
                onPressed: () async {
                  await context.read<AdminUsersCubit>().markUserAsUnread();
                },
                icon: const Icon(Icons.remove_red_eye_rounded),
              ),
              const SizedBox(width: 20),
            ],
          );
        },
      ),
    );
  }
}
