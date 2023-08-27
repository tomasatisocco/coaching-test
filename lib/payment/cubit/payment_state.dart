part of 'payment_cubit.dart';

abstract class PaymentState {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentSelected extends PaymentState {
  const PaymentSelected(this.preferenceId);

  final String preferenceId;
}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess();
}

class PaymentFailure extends PaymentState {
  const PaymentFailure();
}
