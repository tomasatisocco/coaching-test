part of 'login_cubit.dart';

abstract class LoginState {
  const LoginState();
}

/// The initial state of the [LoginCubit].
class LoginInitial extends LoginState {
  const LoginInitial() : super();
}

/// The state of the [LoginCubit] when a login attempt is in progress.
class LoginLoading extends LoginState {
  const LoginLoading() : super();
}

/// The state of the [LoginCubit] when a login attempt has succeeded.
class LoginSuccess extends LoginState {
  const LoginSuccess(this.userDataModel) : super();

  final UserDataModel userDataModel;
}

/// The state of the [LoginCubit] when a login attempt has failed.
class LoginFailure extends LoginState {
  const LoginFailure() : super();
}
