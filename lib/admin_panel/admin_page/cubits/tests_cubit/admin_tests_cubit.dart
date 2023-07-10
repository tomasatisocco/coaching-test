import 'package:bloc/bloc.dart';
import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:coaching/welcome/models/user_date_model.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'admin_tests_state.dart';

class AdminTestsCubit extends Cubit<AdminTestsState> {
  AdminTestsCubit({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(AdminTestsInitial());

  final FirestoreRepository _firestoreRepository;

  Future<void> getTest(UserDataModel user) async {
    emit(AdminTestsFetching());
    try {
      final test = await _firestoreRepository.getTest(user.id!);
      emit(AdminTestsFetched(test: CoachingTest.fromMap(test!), user: user));
    } catch (_) {
      emit(AdminTestsError());
    }
  }
}