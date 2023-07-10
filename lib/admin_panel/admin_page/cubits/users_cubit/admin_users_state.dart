part of 'admin_users_cubit.dart';

abstract class AdminUsersState {}

class AdminInitial extends AdminUsersState {}

class AdminFetchingUsers extends AdminUsersState {}

class AdminUsersFetched extends AdminUsersState {
  AdminUsersFetched({required this.users});

  final List<UserDataModel> users;
}

class AdminUsersError extends AdminUsersState {}
