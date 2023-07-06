part of 'admin_login_cubit.dart';

abstract class AdminLoginState {}

class AdminLoginInitial extends AdminLoginState {}

class AdminLoginLoading extends AdminLoginState {}

class AdminLoginSuccess extends AdminLoginState {}

class AdminLoginFailure extends AdminLoginState {}

class AdminNotAuthorized extends AdminLoginState {}

class UserLogOutSuccess extends AdminLoginState {}
