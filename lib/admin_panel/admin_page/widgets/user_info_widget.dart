import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:coaching/admin_panel/admin_page/widgets/user_status_row.dart';
import 'package:coaching/admin_panel/admin_page/widgets/user_subscription.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/models/subscription.dart';
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
          final userMap = user.toMap();
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 250,
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Datos Personales',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ...userMap.entries.map((e) {
                            if (e.key == 'status' ||
                                e.key == 'testIds' ||
                                e.key == 'subscription' ||
                                e.key == 'isPaid' ||
                                e.value == null) {
                              return const SizedBox.shrink();
                            }
                            return SizedBox(
                              width: 500,
                              height: 30,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      e.key,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(e.value.toString()),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                      Column(
                        children: [
                          UserStatusRow(userStatus: userStatus ?? 0),
                          const SizedBox(height: 16),
                          UserSubscriptionWidget(
                            userSubscription:
                                state.user?.subscription ?? Subscription.none,
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: ListTile(
                              title: const Text('Pago'),
                              trailing: Switch(
                                value: state.user?.isPaid ?? false,
                                activeTrackColor: Colors.green,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
