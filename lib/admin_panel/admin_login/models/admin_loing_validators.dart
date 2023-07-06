import 'package:coaching/l10n/l10n.dart';

class AdminLoginValidators {
  static String? validateEmail(String? email, AppLocalizations l10n) {
    if (email == null || email.isEmpty) return l10n.emailError;
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email)) return l10n.emailError;
    return null;
  }

  static String? validatePassword(String? password, AppLocalizations l10n) {
    if (password == null || password.isEmpty) return l10n.passwordError;
    return null;
  }
}
