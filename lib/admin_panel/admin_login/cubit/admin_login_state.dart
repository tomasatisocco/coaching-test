part of 'admin_login_cubit.dart';

abstract class AdminLoginState {
  const AdminLoginState(this.email);

  final String? email;
}

class AdminLoginInitial extends AdminLoginState {
  const AdminLoginInitial([super.email]);
}

class AdminLoginLoading extends AdminLoginState {
  const AdminLoginLoading([super.email]);
}

class AdminLoginSuccess extends AdminLoginState {
  const AdminLoginSuccess([super.email]);
}

class AdminLoginFailure extends AdminLoginState {
  const AdminLoginFailure([super.email]);
}

class AdminNotAuthorized extends AdminLoginState {
  const AdminNotAuthorized([super.email]);
}

class UserLogOutSuccess extends AdminLoginState {
  const UserLogOutSuccess([super.email]);
}
