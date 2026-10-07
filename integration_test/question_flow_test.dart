import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ya_perfume/app/di/service_locator.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/screens/percentage_selection_loading_screen.dart';
import 'package:ya_perfume/features/questions/presentation/screens/before_the_families_screen.dart';
import 'package:ya_perfume/features/questions/presentation/screens/questions_screen.dart';
import 'package:ya_perfume/main.dart';

Widget _app() {
  return EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
    path: 'assets/translations',
    fallbackLocale: const Locale('ar', 'EG'),
    startLocale: const Locale('ar', 'EG'),
    saveLocale: false,
    child: const YaPerfumeApp(),
  );
}

Future<void> _tapOption(WidgetTester tester, String textKey) async {
  final finder = find.text(textKey.tr());

  expect(finder, findsOneWidget);

  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _tapOptionWithSnow(WidgetTester tester, String textKey) async {
  final finder = find.text(textKey.tr());

  expect(finder, findsOneWidget);

  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
}

Future<void> _tapContinue(WidgetTester tester) async {
  final finder = find.text('continue'.tr());

  expect(finder, findsOneWidget);

  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _tapContinueWithSnow(WidgetTester tester) async {
  final finder = find.text('continue'.tr());

  expect(finder, findsOneWidget);

  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void _expectQuestion(int number) {
  expect(
    find.text('question_progress'.tr(args: ['$number', '9'])),
    findsOneWidget,
  );

  expect(find.text('question_${number}_text'.tr()), findsOneWidget);
}

void _expectSelectedFamilies(int count) {
  expect(
    find.text('selected_families_count'.tr(args: ['$count', '2'])),
    findsOneWidget,
  );
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await EasyLocalization.ensureInitialized();
    setupServiceLocator();
  });

  testWidgets('Questions feature - complete user flow', (tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    final navigator = tester.state<NavigatorState>(
      find.byType(Navigator).first,
    );

    navigator.pushNamed(RouteNames.questions);

    await tester.pumpAndSettle();

    expect(find.byType(QuestionsScreen), findsOneWidget);

    // Q1 - Gender
    _expectQuestion(1);

    await _tapOption(tester, 'question_1_option_1');
    await _tapContinue(tester);

    // Q2 - Age
    _expectQuestion(2);

    await _tapOption(tester, 'question_2_option_2');
    await _tapContinue(tester);

    // Q3 - Usage time
    _expectQuestion(3);

    await _tapOption(tester, 'question_3_option_2');
    await _tapContinue(tester);

    // Q4 - Season
    _expectQuestion(4);

    await _tapOptionWithSnow(tester, 'question_4_option_2');
    await _tapContinueWithSnow(tester);

    expect(find.byType(BeforeTheFamiliesScreen), findsOneWidget);

    expect(find.text('discover_your_preferred_scents'.tr()), findsOneWidget);

    final chooseScentsFinder = find.text('choose_preferred_scents'.tr());

    expect(chooseScentsFinder, findsOneWidget);

    await tester.ensureVisible(chooseScentsFinder);
    await tester.tap(chooseScentsFinder);
    await tester.pumpAndSettle();

    // Q5 - Preferred scents
    expect(find.byType(BeforeTheFamiliesScreen), findsNothing);

    _expectQuestion(5);
    _expectSelectedFamilies(0);

    await _tapOption(tester, 'question_5_option_1');
    _expectSelectedFamilies(1);

    await _tapOption(tester, 'question_5_option_2');
    _expectSelectedFamilies(2);

    await _tapOption(tester, 'question_5_option_3');

    _expectSelectedFamilies(2);

    expect(
      find.text('selected_families_count'.tr(args: ['3', '2'])),
      findsNothing,
    );

    expect(find.text('maximum_two_families_message'.tr()), findsOneWidget);

    await _tapContinue(tester);

    // Q6 - Avoided scents
    _expectQuestion(6);

    final skipFinder = find.text('skip_question'.tr());

    expect(skipFinder, findsOneWidget);

    await tester.ensureVisible(skipFinder);
    await tester.tap(skipFinder);
    await tester.pumpAndSettle();

    // Q7 - Occasion
    expect(find.text('question_6_text'.tr()), findsNothing);

    _expectQuestion(7);

    await _tapOption(tester, 'question_7_option_1');
    await _tapContinue(tester);

    // Q8 - Personal style
    _expectQuestion(8);

    await _tapOption(tester, 'question_8_option_1');
    await _tapContinue(tester);

    // Q9 - Sillage
    _expectQuestion(9);

    await _tapOption(tester, 'question_9_option_1');
    await _tapContinueWithSnow(tester);

    expect(find.byType(PercentageSelectionLoadingScreen), findsOneWidget);

    expect(
      find.text('percentage_selection_loading_title'.tr()),
      findsOneWidget,
    );
  });
}
