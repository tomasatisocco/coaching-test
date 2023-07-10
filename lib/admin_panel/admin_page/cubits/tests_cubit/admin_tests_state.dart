part of 'admin_tests_cubit.dart';

abstract class AdminTestsState {}

class AdminTestsInitial extends AdminTestsState {}

class AdminTestsFetching extends AdminTestsState {}

class AdminTestsFetched extends AdminTestsState {
  AdminTestsFetched({
    required this.test,
    required this.user,
  });

  final CoachingTest test;
  final UserDataModel user;
}

class AdminTestsError extends AdminTestsState {}
