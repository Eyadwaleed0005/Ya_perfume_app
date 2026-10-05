import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/questions/presentation/screens/before_the_families_screen.dart';
import 'package:ya_perfume/features/questions/presentation/screens/questions_screen.dart';
import 'package:ya_perfume/main.dart';

Widget _app() {
  return EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en', 'US'),
    startLocale: const Locale('ar', 'EG'),
    child: const YaPerfumeApp(),
  );
}

Future<void> _tapOption(WidgetTester tester, String textKey) async {
  await tester.tap(find.text(textKey.tr()));
  await tester.pumpAndSettle();
}

Future<void> _tapOptionWithSnow(WidgetTester tester, String textKey) async {
  await tester.tap(find.text(textKey.tr()));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

Future<void> _tapContinue(WidgetTester tester) async {
  await tester.tap(find.text('continue'.tr()));
  await tester.pumpAndSettle();
}

Future<void> _tapContinueWithSnow(WidgetTester tester) async {
  await tester.tap(find.text('continue'.tr()));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  setUp(() async {
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('Questions feature - complete user flow', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    // Questions screen opens
    expect(find.byType(QuestionsScreen), findsOneWidget);
    await Future.delayed(const Duration(seconds: 5));

    // Q1 - Gender
    expect(find.text('question_progress'.tr(args: ['1', '9'])), findsOneWidget);
    expect(find.text('question_1_text'.tr()), findsOneWidget);
    await _tapOption(tester, 'question_1_option_1');
    await _tapContinue(tester);

    //  Q2 - Age
    expect(find.text('question_progress'.tr(args: ['2', '9'])), findsOneWidget);
    expect(find.text('question_2_text'.tr()), findsOneWidget);
    await _tapOption(tester, 'question_2_option_2');
    await _tapContinue(tester);

    //  Q3 - Usage time
    expect(find.text('question_progress'.tr(args: ['3', '9'])), findsOneWidget);
    expect(find.text('question_3_text'.tr()), findsOneWidget);
    await _tapOption(tester, 'question_3_option_2');
    await _tapContinue(tester);

    //  Q4 - Season
    expect(find.text('question_progress'.tr(args: ['4', '9'])), findsOneWidget);
    expect(find.text('question_4_text'.tr()), findsOneWidget);
    await _tapOptionWithSnow(tester, 'question_4_option_2');
    await _tapContinueWithSnow(tester);

    expect(find.byType(BeforeTheFamiliesScreen), findsOneWidget);
    expect(find.text('discover_your_preferred_scents'.tr()), findsOneWidget);

    await tester.tap(find.text('choose_preferred_scents'.tr()));
    await tester.pumpAndSettle();

    //  Q5 - Preferred scents - max selections = 2
    expect(find.byType(BeforeTheFamiliesScreen), findsNothing);
    expect(find.text('question_progress'.tr(args: ['5', '9'])), findsOneWidget);
    expect(find.text('question_5_text'.tr()), findsOneWidget);

    expect(
      find.text('selected_families_count'.tr(args: ['0'])),
      findsOneWidget,
    );

    await _tapOption(tester, 'question_5_option_1');
    expect(
      find.text('selected_families_count'.tr(args: ['1'])),
      findsOneWidget,
    );

    await _tapOption(tester, 'question_5_option_2');
    expect(
      find.text('selected_families_count'.tr(args: ['2'])),
      findsOneWidget,
    );

    // cannot add a third selection
    await _tapOption(tester, 'question_5_option_3');
    expect(
      find.text('selected_families_count'.tr(args: ['2'])),
      findsOneWidget,
    );
    expect(find.text('selected_families_count'.tr(args: ['3'])), findsNothing);

    // Info message appear when max is reached
    expect(find.text('maximum_two_families_message'.tr()), findsOneWidget);

    await _tapContinue(tester);

    //  Q6 - Avoided scents with skip option
    expect(find.text('question_progress'.tr(args: ['6', '9'])), findsOneWidget);
    expect(find.text('question_6_text'.tr()), findsOneWidget);

    final skipFinder = find.text('skip_question'.tr());
    expect(skipFinder, findsOneWidget);

    await tester.tap(skipFinder);
    await tester.pumpAndSettle();

    //  Q7 - Occasion
    expect(find.text('question_6_text'.tr()), findsNothing);
    expect(find.text('question_progress'.tr(args: ['7', '9'])), findsOneWidget);
    expect(find.text('question_7_text'.tr()), findsOneWidget);
    await _tapOption(tester, 'question_7_option_1');
    await _tapContinue(tester);

    //  Q8 - Personal style
    expect(find.text('question_progress'.tr(args: ['8', '9'])), findsOneWidget);
    expect(find.text('question_8_text'.tr()), findsOneWidget);
    await _tapOption(tester, 'question_8_option_1');
    await _tapContinue(tester);

    //  Q9 - Sillage
    expect(find.text('question_progress'.tr(args: ['9', '9'])), findsOneWidget);
    expect(find.text('question_9_text'.tr()), findsOneWidget);
    await _tapOption(tester, 'question_9_option_1');

    // no next question exists so must stay on Q9 after tapping continue.
    await _tapContinue(tester);
    expect(find.text('question_progress'.tr(args: ['9', '9'])), findsOneWidget);
  });
}
