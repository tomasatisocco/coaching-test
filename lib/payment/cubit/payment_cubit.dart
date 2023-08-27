import 'package:bloc/bloc.dart';
import 'package:coaching/welcome/models/subscription.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:functions_repository/functions_repository.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required FirestoreRepository firestoreRepository,
    required DataPersistenceRepository dataPersistenceRepository,
    required FunctionsRepository functionsRepository,
  })  : _firestoreRepository = firestoreRepository,
        _dataPersistenceRepository = dataPersistenceRepository,
        _functionsRepository = functionsRepository,
        super(const PaymentInitial());

  final FirestoreRepository _firestoreRepository;
  final DataPersistenceRepository _dataPersistenceRepository;
  final FunctionsRepository _functionsRepository;

  Future<void> pay(Subscription subscription) async {
    emit(const PaymentLoading());
    try {
      final user = UserDataModel.fromJson(
        _dataPersistenceRepository.getUser()!,
      );
      final updated = user.copyWith(
        subscription: subscription,
      );
      await _firestoreRepository.updateUser(updated.toMap(), user.id!);
      await _dataPersistenceRepository.setUser(updated.toJson());
      final preference = await _functionsRepository.createPreference(
        subscription.name,
      );
      final preferenceId = preference['id'] as String;
      emit(PaymentSelected(preferenceId));
    } catch (_) {
      emit(const PaymentFailure());
    }
  }

  Future<void> updatePaidUser() async {
    emit(const PaymentLoading());
    try {
      final user = UserDataModel.fromJson(
        _dataPersistenceRepository.getUser()!,
      );
      final updated = user.copyWith(
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
