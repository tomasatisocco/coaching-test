import 'package:coaching/l10n/l10n.dart';
import 'package:coaching/payment/widgets/pay_button.dart';
import 'package:coaching/welcome/models/subscription.dart';
import 'package:flutter/material.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({super.key, required this.subscription});

  final Subscription subscription;

  @override
  Widget build(BuildContext context) {
    final benefits = subscription.benefits(context.l10n);
    return Container(
      height: 500,
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            blurRadius: 5,
          ),
        ],
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            subscription.icon,
            color: Colors.blue,
            size: 30,
          ),
          const SizedBox(height: 16),
          Text(
            subscription.title(context.l10n),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.attach_money_rounded,
                size: 24,
              ),
              Text(
                subscription.price.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Visibility(
                visible: subscription == Subscription.mensual ||
                    subscription == Subscription.anual,
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
                child: subscription == Subscription.mensual
                    ? Text(context.l10n.month)
                    : Text(context.l10n.year),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: benefits.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 0,
                title: Text(benefits[index]),
              );
            },
          ),
          const Spacer(),
          PayButton(subscription: subscription),
        ],
      ),
    );
  }
}
