import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSubscriptionWidget extends StatelessWidget {
  const UserSubscriptionWidget({
    super.key,
    required this.userSubscription,
  });

  final Subscription? userSubscription;

  @override
  Widget build(BuildContext context) {
    final subscriptions = context.read<AdminUsersCubit>().state.subscriptions;
    return Column(
      children: [
        const Text(
          'Suscripción del usuario',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: (subscriptions?.length ?? 0) * 70.0,
          height: 100,
          child: ListView.builder(
            itemCount: subscriptions?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final subscription = subscriptions![index];
              return SizedBox(
                width: 70,
                child: GestureDetector(
                  onTap: () {
                    final cubit = context.read<AdminUsersCubit>();
                    final user = (cubit.state as AdminUsersFetched).user!;
                    context.read<AdminUsersCubit>().updateSelectedUser(
                          user.copyWith(subscription: subscription.name),
                        );
                  },
                  child: Column(
                    children: [
                      Icon(
                        subscription.icon,
                        color: userSubscription == subscription
                            ? Colors.blue
                            : Colors.grey,
                        size: 30,
                      ),
                      Text(
                        subscription.title ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
