part of 'admin_tests_cubit.dart';

abstract class AdminTestsState {
  const AdminTestsState();
}

class AdminTestsInitial extends AdminTestsState {
  const AdminTestsInitial();
}

class AdminTestsFetching extends AdminTestsState {
  const AdminTestsFetching();
}

class AdminTestsFetched extends AdminTestsState {
  const AdminTestsFetched({
    required this.test,
    required this.user,
  });

  final CoachingTest test;
  final UserDataModel user;
}

class AdminTestsError extends AdminTestsState {
  const AdminTestsError();
}
