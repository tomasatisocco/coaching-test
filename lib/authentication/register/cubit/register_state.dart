part of 'register_cubit.dart';

abstract class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess(this.userDataModel);

  final UserDataModel userDataModel;
}

class RegisterFailure extends RegisterState {
  const RegisterFailure(this.message);

  final String message;

  String getMessage(AppLocalizations l10n) {
    switch (message) {
      case 'email-already-in-use':
        return l10n.emailAlreadyRegistered;
      case 'passwords-not-match':
        return l10n.passwordsNotMatch;
      default:
        return l10n.registerError;
    }
  }
}
