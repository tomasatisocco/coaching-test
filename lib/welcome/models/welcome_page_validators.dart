import 'package:coaching/l10n/l10n.dart';

class WelcomePageValidators {
  static String? validateName(String? name, AppLocalizations l10n) {
    if (name == null || name.isEmpty) return l10n.nameError;
    return null;
  }

  static String? validateEmail(String? email, AppLocalizations l10n) {
    if (email == null || email.isEmpty) return l10n.emailError;
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email)) return l10n.emailError;
    return null;
  }

  static String? validateBirthDate(String? birthDate, AppLocalizations l10n) {
    if (birthDate == null || birthDate.isEmpty) return l10n.birthDateError;
    return null;
  }

  static String? validateNational(String? national, AppLocalizations l10n) {
    if (national == null || national.isEmpty) return l10n.nationalityError;
    return null;
  }

  static String? validateResidence(String? residence, AppLocalizations l10n) {
    if (residence == null || residence.isEmpty) return l10n.residenceError;
    return null;
  }

  static String? validateCertificate(String? certDate, AppLocalizations l10n) {
    if (certDate == null || certDate.isEmpty) return l10n.certificateError;
    return null;
  }
}
