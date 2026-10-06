import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({
    required Locale initialLocale,
    required List<Locale> supportedLocales,
  }) : _supportedLocales = List.unmodifiable(supportedLocales),
       super(LanguageState(selectedLocale: initialLocale));

  final List<Locale> _supportedLocales;

  void selectLanguage(String languageCode) {
    final locale = _supportedLocales.firstWhere(
      (locale) => locale.languageCode == languageCode,
    );

    if (state.selectedLocale == locale) {
      return;
    }

    emit(LanguageState(selectedLocale: locale));
  }
}
