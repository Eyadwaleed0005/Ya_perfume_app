import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/language/presentation/cubit/language_cubit.dart';
import 'package:ya_perfume/features/language/presentation/cubit/language_state.dart';

void main() {
  const arabic = Locale('ar', 'EG');
  const english = Locale('en', 'US');
  const french = Locale('fr', 'FR');
  const italian = Locale('it', 'IT');
  const russian = Locale('ru', 'RU');

  const supportedLocales = [english, arabic, french, italian, russian];

  LanguageCubit createCubit({Locale initialLocale = arabic}) {
    return LanguageCubit(
      initialLocale: initialLocale,
      supportedLocales: supportedLocales,
    );
  }

  Matcher hasLocale(Locale locale) {
    return isA<LanguageState>().having(
      (state) => state.selectedLocale,
      'selectedLocale',
      locale,
    );
  }

  group('LanguageCubit', () {
    test('initial state should use Arabic', () async {
      final cubit = createCubit();

      try {
        expect(cubit.state.selectedLocale, arabic);
      } finally {
        await cubit.close();
      }
    });

    test('initial state should use the supplied locale', () async {
      final cubit = createCubit(initialLocale: english);

      try {
        expect(cubit.state.selectedLocale, english);
      } finally {
        await cubit.close();
      }
    });

    for (final locale in [english, french, italian, russian]) {
      blocTest<LanguageCubit, LanguageState>(
        'select ${locale.languageCode} with its correct country code',
        build: createCubit,
        act: (cubit) {
          cubit.selectLanguage(locale.languageCode);
        },
        expect: () => [hasLocale(locale)],
        verify: (cubit) {
          expect(cubit.state.selectedLocale, locale);
        },
      );
    }

    blocTest<LanguageCubit, LanguageState>(
      'select Arabic after starting with English',
      build: () => createCubit(initialLocale: english),
      act: (cubit) {
        cubit.selectLanguage('ar');
      },
      expect: () => [hasLocale(arabic)],
    );

    blocTest<LanguageCubit, LanguageState>(
      'selecting the current language should not emit a new state',
      build: createCubit,
      act: (cubit) {
        cubit.selectLanguage('ar');
      },
      expect: () => <LanguageState>[],
      verify: (cubit) {
        expect(cubit.state.selectedLocale, arabic);
      },
    );

    blocTest<LanguageCubit, LanguageState>(
      'switch between languages and return to Arabic',
      build: createCubit,
      act: (cubit) {
        cubit.selectLanguage('en');
        cubit.selectLanguage('fr');
        cubit.selectLanguage('it');
        cubit.selectLanguage('ru');
        cubit.selectLanguage('ar');
      },
      expect: () => [
        hasLocale(english),
        hasLocale(french),
        hasLocale(italian),
        hasLocale(russian),
        hasLocale(arabic),
      ],
      verify: (cubit) {
        expect(cubit.state.selectedLocale, arabic);
      },
    );

    blocTest<LanguageCubit, LanguageState>(
      'repeated selection should emit only once per language change',
      build: createCubit,
      act: (cubit) {
        cubit.selectLanguage('en');
        cubit.selectLanguage('en');
        cubit.selectLanguage('ar');
        cubit.selectLanguage('ar');
      },
      expect: () => [hasLocale(english), hasLocale(arabic)],
    );
  });
}
