part of 'admin_users_cubit.dart';

abstract class AdminUsersState extends Equatable {
  const AdminUsersState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminUsersState {
  const AdminInitial();
}

class AdminFetchingUsers extends AdminUsersState {
  const AdminFetchingUsers();
}

class AdminUsersFetched extends AdminUsersState {
  const AdminUsersFetched({
    required this.users,
    this.user,
    this.isUpdating = false,
  });

  final List<UserDataModel> users;
  final UserDataModel? user;
  final bool isUpdating;

  AdminUsersFetched copyWith({
    List<UserDataModel>? users,
    UserDataModel? user,
    bool isUpdating = false,
  }) {
    return AdminUsersFetched(
      users: users ?? this.users,
      user: user,
      isUpdating: isUpdating,
    );
  }

  @override
  List<Object> get props => [users, user ?? '', isUpdating];
}

class AdminUsersError extends AdminUsersState {
  const AdminUsersError();
}
