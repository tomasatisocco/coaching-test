part of 'admin_users_cubit.dart';

abstract class AdminUsersState extends Equatable {
  const AdminUsersState({this.subscriptions});

  final List<Subscription>? subscriptions;

  @override
  List<Object?> get props => [subscriptions];
}

class AdminInitial extends AdminUsersState {
  const AdminInitial({super.subscriptions});
}

class AdminFetchingUsers extends AdminUsersState {
  const AdminFetchingUsers({super.subscriptions});
}

class AdminUsersFetched extends AdminUsersState {
  const AdminUsersFetched({
    required this.users,
    this.user,
    this.isUpdating = false,
    super.subscriptions,
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
      subscriptions: subscriptions,
    );
  }

  @override
  List<Object?> get props => [users, user ?? '', isUpdating, subscriptions];
}

class AdminUsersError extends AdminUsersState {
  const AdminUsersError();
}
