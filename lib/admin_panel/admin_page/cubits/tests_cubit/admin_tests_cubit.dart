import 'package:bloc/bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coaching/coaching_test/models/test_model.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'admin_tests_state.dart';

class AdminTestsCubit extends Cubit<AdminTestsState> {
  AdminTestsCubit({
    required FirestoreRepository firestoreRepository,
    required String testId,
  })  : _firestoreRepository = firestoreRepository,
        _testId = testId,
        super(const AdminTestsInitial());

  final FirestoreRepository _firestoreRepository;
  final String _testId;

  Future<void> getTest() async {
    if (state is AdminTestsFetched) return;
    emit(const AdminTestsFetching());
    try {
      final test = await _firestoreRepository.getTest(_testId);
      emit(AdminTestsFetched(test: CoachingTest.fromMap(test!)));
    } catch (_) {
      emit(const AdminTestsError());
    }
  }

  Future<void> reSendTest(String? testId) async {
    try {
      if (testId == null) return;
      await FirebaseFunctions.instanceFor(region: 'southamerica-east1')
          .httpsCallable('sendEmail')
          .call<void>(
        <String, dynamic>{'testId': testId},
      );
    } catch (_) {}
  }
}
