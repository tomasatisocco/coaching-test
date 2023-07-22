import 'package:bloc/bloc.dart';
import 'package:coaching/welcome/models/subscription.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required FirestoreRepository firestoreRepository,
    required DataPersistenceRepository dataPersistenceRepository,
  })  : _firestoreRepository = firestoreRepository,
        _dataPersistenceRepository = dataPersistenceRepository,
        super(const PaymentInitial());

  final FirestoreRepository _firestoreRepository;
  final DataPersistenceRepository _dataPersistenceRepository;

  Future<void> pay(Subscription subscription) async {
    emit(const PaymentLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      final user = UserDataModel.fromJson(
        _dataPersistenceRepository.getUser()!,
      );
      final updated = user.copyWith(
        subscription: subscription,
        isPaid: true,
        status: Status.testPaid,
      );
      await _firestoreRepository.updateUser(updated.toMap(), user.id!);
      await _dataPersistenceRepository.setUser(updated.toJson());
      emit(const PaymentSuccess());
    } catch (_) {
      emit(const PaymentFailure());
    }
  }
}
