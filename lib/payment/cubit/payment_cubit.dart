import 'package:bloc/bloc.dart';
import 'package:coaching/welcome/models/subscription.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required FirestoreRepository firestoreRepository,
  })  : _firestoreRepository = firestoreRepository,
        super(const PaymentInitial());

  final FirestoreRepository _firestoreRepository;

  Future<void> pay(Subscription subscription) async {
    emit(const PaymentLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      final user = UserDataModel.fromMap(_firestoreRepository.user!);
      final updated = user.copyWith(
        subscription: subscription,
        isPaid: true,
        status: Status.testPaid,
      );
      await _firestoreRepository.updateUser(updated.toMap(), user.id!);
      emit(const PaymentSuccess());
    } on Exception {
      emit(const PaymentFailure());
    }
  }
}
