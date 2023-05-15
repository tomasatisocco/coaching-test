import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'localizations_state.dart';

class LocalizationsCubit extends Cubit<LocalizationsState> {
  LocalizationsCubit() : super(const LocalizationsSpanish());

  void switchLanguage() {
    final code = state.locale.languageCode;
    if (code == 'es') return emit(const LocalizationsEnglish());
    return emit(const LocalizationsSpanish());
  }
}
