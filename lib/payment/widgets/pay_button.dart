import 'package:coaching/payment/cubit/payment_cubit.dart';
import 'package:coaching/welcome/models/subscription.dart';
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
    return ElevatedButton(
      onPressed: () => context.read<PaymentCubit>().pay(subscription),
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return SizedBox(
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
                  // TODO: localize
                  : const Text('Seleccionar'),
            ),
          );
        },
      ),
    );
  }
}
