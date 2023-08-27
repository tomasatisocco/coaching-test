part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState({this.subscriptions});

  final List<Subscription>? subscriptions;

  @override
  List<Object?> get props => [
        subscriptions,
      ];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial({
    super.subscriptions,
  });
}

class PaymentLoading extends PaymentState {
  const PaymentLoading({super.subscriptions});
}

class PaymentSelected extends PaymentState {
  const PaymentSelected(
    this.preferenceId, {
    super.subscriptions,
  });

  final String preferenceId;
}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess({super.subscriptions});
}

class PaymentFailure extends PaymentState {
  const PaymentFailure({super.subscriptions});
}
