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
  const AdminUsersFetched({required this.users, this.user});

  final List<UserDataModel> users;
  final UserDataModel? user;

  AdminUsersFetched copyWith({
    List<UserDataModel>? users,
    UserDataModel? user,
  }) {
    return AdminUsersFetched(
      users: users ?? this.users,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [users, user ?? ''];
}

class AdminUsersError extends AdminUsersState {
  const AdminUsersError();
}
