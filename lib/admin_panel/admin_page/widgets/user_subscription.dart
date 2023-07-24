import 'package:coaching/admin_panel/admin_page/cubits/users_cubit/admin_users_cubit.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/welcome/models/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSubscriptionWidget extends StatelessWidget {
  const UserSubscriptionWidget({
    super.key,
    required this.userSubscription,
  });

  final Subscription userSubscription;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Suscripción del usuario',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 300,
          height: 100,
          child: ListView.builder(
            itemCount: Subscription.values.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final subscription = Subscription.values[index];
              return SizedBox(
                width: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      final cubit = context.read<AdminUsersCubit>();
                      final user = (cubit.state as AdminUsersFetched).user!;
                      context.read<AdminUsersCubit>().updateSelectedUser(
                            user.copyWith(subscription: subscription),
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
                          subscription.title(context.l10n),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
