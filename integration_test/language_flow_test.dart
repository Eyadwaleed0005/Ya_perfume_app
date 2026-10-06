import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/features/app_startup/presentation/screens/choose_perfume_method_screen.dart';
import 'package:ya_perfume/features/app_startup/presentation/screens/splash_screen.dart';
import 'package:ya_perfume/features/app_startup/presentation/widgets/choose_perfume_method_widgets/choose_perfume_method_back_button.dart';
import 'package:ya_perfume/features/language/presentation/cubit/language_cubit.dart';
import 'package:ya_perfume/features/language/presentation/screens/select_language_screen.dart';
import 'package:ya_perfume/features/language/presentation/widgets/select_language_button.dart';
import 'package:ya_perfume/features/language/presentation/widgets/select_language_content.dart';
import 'package:ya_perfume/main.dart' as app;

Future<void> _waitUntil(
  WidgetTester tester,
  bool Function() condition, {
  required String reason,
}) async {
  for (int attempt = 0; attempt < 100; attempt++) {
    await tester.pump(const Duration(milliseconds: 100));

    if (condition()) return;
  }

  fail(reason);
}

BuildContext _languageContext(WidgetTester tester) {
  return tester.element(
    find.byType(SelectLanguageContent),
  );
}

Finder _languageButton(String languageCode) {
  return find.byWidgetPredicate(
    (widget) =>
        widget is SelectLanguageButton &&
        widget.languageCode == languageCode,
    description: '$languageCode language button',
  );
}

Future<Map<String, dynamic>> _loadTranslations(Locale locale) async {
  final countryCode = locale.countryCode;

  final fileName = countryCode == null || countryCode.isEmpty
      ? locale.languageCode
      : '${locale.languageCode}-$countryCode';

  final content = await rootBundle.loadString(
    'assets/translations/$fileName.json',
  );

  return jsonDecode(content) as Map<String, dynamic>;
}

void _expectLanguageContent(
  WidgetTester tester, {
  required Locale locale,
  required Map<String, dynamic> translations,
}) {
  final context = _languageContext(tester);

  expect(context.locale, locale);

  expect(
    context.read<LanguageCubit>().state.selectedLocale,
    locale,
  );

  final instruction =
      translations['select_language_instruction'] as String;
  final startText = translations['start'] as String;

  expect(
    find.descendant(
      of: find.byType(SelectLanguageContent),
      matching: find.text(instruction),
    ),
    findsOneWidget,
  );

  final startButton = tester.widget<CustomButton>(
    find.descendant(
      of: find.byType(SelectLanguageContent),
      matching: find.byType(CustomButton),
    ),
  );

  expect(startButton.text, startText);

  expect(
    find.text('select_language_instruction'),
    findsNothing,
  );
  expect(find.text('start'), findsNothing);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'splash, language selection, translated content, navigation and back',
    (tester) async {
      const arabic = Locale('ar', 'EG');

      const locales = [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('it', 'IT'),
        Locale('ru', 'RU'),
        arabic,
      ];

      await tester.runAsync(() async {
        await app.main();
      });

      await _waitUntil(
        tester,
        () => find.byType(SplashScreen).evaluate().isNotEmpty,
        reason: 'Splash screen did not open.',
      );

      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.byType(SelectLanguageScreen), findsNothing);

      await _waitUntil(
        tester,
        () => find.byType(SelectLanguageContent).evaluate().isNotEmpty,
        reason: 'Splash did not navigate to language selection.',
      );

      await tester.pumpAndSettle();

      expect(find.byType(SelectLanguageScreen), findsOneWidget);
      expect(find.byType(SplashScreen), findsNothing);
      expect(tester.takeException(), isNull);

      final arabicTranslations = await _loadTranslations(arabic);

      _expectLanguageContent(
        tester,
        locale: arabic,
        translations: arabicTranslations,
      );

      for (final locale in locales) {
        final translations = await _loadTranslations(locale);
        final button = _languageButton(locale.languageCode);

        expect(button, findsOneWidget);

        await tester.ensureVisible(button);
        await tester.tap(button);

        await _waitUntil(
          tester,
          () => _languageContext(tester).locale == locale,
          reason: 'Locale did not change to $locale.',
        );

        await tester.pumpAndSettle();

        _expectLanguageContent(
          tester,
          locale: locale,
          translations: translations,
        );

        expect(tester.takeException(), isNull);
      }

      await tester.tap(_languageButton('ar'));
      await tester.pumpAndSettle();

      _expectLanguageContent(
        tester,
        locale: arabic,
        translations: arabicTranslations,
      );

      final startButton = find.descendant(
        of: find.byType(SelectLanguageContent),
        matching: find.byType(CustomButton),
      );

      expect(startButton, findsOneWidget);

      await tester.ensureVisible(startButton);
      await tester.tap(startButton);
      await tester.pumpAndSettle();

      expect(
        find.byType(ChoosePerfumeMethodScreen),
        findsOneWidget,
      );
      expect(find.byType(SelectLanguageScreen), findsNothing);
      expect(tester.takeException(), isNull);

      final backButton = find.byType(
        ChoosePerfumeMethodBackButton,
      );

      expect(backButton, findsOneWidget);

      await tester.ensureVisible(backButton);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.byType(SelectLanguageScreen), findsOneWidget);
      expect(
        find.byType(ChoosePerfumeMethodScreen),
        findsNothing,
      );
      expect(find.byType(SplashScreen), findsNothing);

      _expectLanguageContent(
        tester,
        locale: arabic,
        translations: arabicTranslations,
      );

      final navigator = Navigator.of(_languageContext(tester));
      expect(navigator.canPop(), false);

      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    },
  );
}