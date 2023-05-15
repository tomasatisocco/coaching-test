part of 'localizations_cubit.dart';

abstract class LocalizationsState {
  const LocalizationsState(this.locale);
  final Locale locale;
}

class LocalizationsSpanish extends LocalizationsState {
  const LocalizationsSpanish() : super(const Locale('es'));
}

class LocalizationsEnglish extends LocalizationsState {
  const LocalizationsEnglish() : super(const Locale('en'));
}
