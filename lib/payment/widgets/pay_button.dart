import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/payment/cubit/payment_cubit.dart';
import 'package:firestore_repository/models/subscriptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayButton extends StatelessWidget {
  const PayButton({
    super.key,
    required this.subscription,
  });

  final Subscription subscription;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is PaymentLoading
              ? () {}
              : () => context.read<PaymentCubit>().pay(subscription),
          child: SizedBox(
            height: 40,
            width: 90,
            child: Center(
              child: state is PaymentLoading
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Text(context.l10n.choose),
            ),
          ),
        );
      },
    );
  }
}
