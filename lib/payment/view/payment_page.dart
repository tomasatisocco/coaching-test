import 'package:coaching/app/widgets/coaching_app_bar.dart';
import 'package:coaching/app/widgets/coaching_drawer.dart';
import 'package:coaching/coaching_test/view/coaching_test_page.dart';
import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/payment/cubit/payment_cubit.dart';
import 'package:coaching/payment/widgets/payment_method_widget.dart';
import 'package:coaching/welcome/models/subscription.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  static const name = 'PaymentPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(
        firestoreRepository: context.read<FirestoreRepository>(),
      ),
      child: const PaymentView(),
    );
  }
}

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(context.l10n.paymentError),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        if (state is! PaymentSuccess) return;
        context.goNamed(CoachingTestPage.name);
      },
      child: Scaffold(
        appBar: const CoachingAppBar(),
        endDrawer: const CoachingDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.choosePlan,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  context.l10n.choosePlanDescription,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PaymentMethodWidget(subscription: Subscription.basic),
                      PaymentMethodWidget(subscription: Subscription.premium),
                      PaymentMethodWidget(subscription: Subscription.mensual),
                      PaymentMethodWidget(subscription: Subscription.anual),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
