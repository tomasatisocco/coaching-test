part of 'welcome_cubit.dart';

abstract class WelcomeState {}

class WelcomeInitial extends WelcomeState {}

class WelcomeLoading extends WelcomeState {}

class WelcomeLoaded extends WelcomeState {}

class WelcomeError extends WelcomeState {}
