import 'package:coaching/admin_panel/admin_login/cubit/admin_login_cubit.dart';
import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/remote_configs.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

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
          final showMPAuthorization = context
                  .read<RemoteConfigurations>()
                  .whiteListVendors
                  .contains(
                    state.user?.email?.toLowerCase(),
                  ) &&
              state.user?.email == context.read<AdminLoginCubit>().state.email;
          return Row(
            children: [
              const Spacer(),
              Visibility(
                visible: showMPAuthorization,
                child: ElevatedButton(
                  onPressed: () async {
                    final uuid = const Uuid().v4();
                    final clientId =
                        context.read<RemoteConfigurations>().clientId;
                    await context.read<FirestoreRepository>().addIntent(
                          userEmail: state.user?.email ?? '',
                          identifier: uuid,
                        );

                    final uri = Uri(
                      scheme: 'https',
                      host: 'auth.mercadopago.com.ar',
                      path: '/authorization',
                      queryParameters: {
                        'client_id': clientId,
                        'response_type': 'code',
                        'state': uuid,
                        'platform_id': 'mp',
                        'redirect_uri':
                            'https://coaching-test-3c129.web.app/mercadopago',
                      },
                    );
                    final canLaunch = await canLaunchUrl(uri);
                    if (canLaunch) await launchUrl(uri);
                  },
                  child: const Text('Autorizar Mercado Pago'),
                ),
              ),
              const SizedBox(width: 20),
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
              IconButton(
                onPressed: () async {
                  await showDialog<void>(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text(context.l10n.deleteUser),
                        content: Text(
                          context.l10n.deleteUserWarning,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(context.l10n.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<AdminUsersCubit>().deleteUser();
                            },
                            child: Text(context.l10n.delete),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 20),
            ],
          );
        },
      ),
    );
  }
}
