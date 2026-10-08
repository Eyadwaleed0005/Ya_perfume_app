import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ya_perfume/app/di/service_locator.dart';
import 'package:ya_perfume/app/routes/app_routes.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/features/language/presentation/screens/select_language_screen.dart';
import 'package:ya_perfume/features/results/domain/entities/perfume_result_entity.dart';
import 'package:ya_perfume/features/results/presentation/screens/perfume_details_screen.dart';
import 'package:ya_perfume/features/results/presentation/screens/result_screen.dart';
import 'package:ya_perfume/features/results/presentation/widgets/perfume_details_screen_widgets/perfume_details_actions.dart';
import 'package:ya_perfume/features/results/presentation/widgets/result_screen_widgets/result_perfume_card.dart';

final testPerfumes = <PerfumeResultEntity>[
  PerfumeResultEntity(
    code: 4,
    name: 'First Perfume',
    usageTime: 'مساءً وليلاً',
    season: 'الشتاء',
    preferredScents: const ['خشبي'],
    occasions: const ['نزهات وزيارات المقاهي'],
    projection: 'واضح ومتوازن',
    styles: const ['أنيق وراقٍ'],
  ),
  PerfumeResultEntity(
    code: null,
    name: 'Second Perfume',
    usageTime: 'صباحاً ونهارًا',
    season: 'الصيف',
    preferredScents: const ['فاكهي'],
    occasions: const ['استخدام يومي للعمل أو الدراسة'],
    projection: 'هادئ وقريب منك',
    styles: const ['عملي ومريح'],
  ),
  PerfumeResultEntity(
    code: 0,
    name: 'Third Perfume',
    usageTime: 'في كلا الوقتين',
    season: 'طول العام',
    preferredScents: const ['زهري'],
    occasions: const ['حفل زفاف أو مناسبة رسمية'],
    projection: 'قوي ولافت',
    styles: const ['كلاسيكي ورسمي'],
  ),
  PerfumeResultEntity(
    code: 27,
    name: 'Fourth Perfume',
    usageTime: 'مساءً وليلاً',
    season: 'الشتاء',
    preferredScents: const ['خشبي', 'فاكهي'],
    occasions: const ['حفلة أو سهرة ليلية'],
    projection: 'واضح ومتوازن',
    styles: const ['جرئ ومختلف'],
  ),
];

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await EasyLocalization.ensureInitialized();

    setupServiceLocator();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  });

  Future<void> openResults(
    WidgetTester tester, {
    required GlobalKey<NavigatorState> navigatorKey,
  }) async {
    await tester.pumpWidget(
      EasyLocalization(
        key: UniqueKey(),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
          Locale('fr', 'FR'),
          Locale('it', 'IT'),
          Locale('ru', 'RU'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar', 'EG'),
        startLocale: const Locale('ar', 'EG'),
        saveLocale: false,
        child: _ResultsTestApp(
          navigatorKey: navigatorKey,
          perfumes: testPerfumes,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ResultScreen), findsOneWidget);
    expect(find.byType(ResultPerfumeCard), findsNWidgets(4));
    expect(tester.takeException(), isNull);
  }

  Future<void> openPerfume(WidgetTester tester, int index) async {
    final card = find.byType(ResultPerfumeCard).at(index);

    await tester.ensureVisible(card);
    await tester.pumpAndSettle();

    await tester.tap(card);
    await tester.pumpAndSettle();

    expect(find.byType(PerfumeDetailsScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  }

  Finder detailsAction(int index) {
    return find
        .descendant(
          of: find.byType(PerfumeDetailsActions),
          matching: find.byType(CustomButton),
        )
        .at(index);
  }

  Future<void> tapDetailsAction(WidgetTester tester, int index) async {
    final button = detailsAction(index);

    await tester.ensureVisible(button);
    await tester.pumpAndSettle();

    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  group('Results feature integration', () {
    testWidgets('displays the four supplied perfumes', (tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();

      await openResults(tester, navigatorKey: navigatorKey);

      final screen = tester.widget<ResultScreen>(find.byType(ResultScreen));

      expect(screen.perfumes, orderedEquals(testPerfumes));
      expect(find.byType(PerfumeDetailsScreen), findsNothing);
    });

    testWidgets('opens each selected perfume and returns to all results', (
      tester,
    ) async {
      final navigatorKey = GlobalKey<NavigatorState>();

      await openResults(tester, navigatorKey: navigatorKey);

      for (var index = 0; index < testPerfumes.length; index++) {
        await openPerfume(tester, index);

        final screen = tester.widget<PerfumeDetailsScreen>(
          find.byType(PerfumeDetailsScreen),
        );

        final selectedPerfume = testPerfumes[index];

        // شاشة التفاصيل تستقبل نفس العطر المختار.
        expect(screen.perfume, same(selectedPerfume));

        expect(find.text(selectedPerfume.usageTime), findsWidgets);
        expect(find.text(selectedPerfume.season), findsWidgets);
        expect(find.text(selectedPerfume.projection), findsOneWidget);

        // أول زر: الرجوع لكل العطور.
        await tapDetailsAction(tester, 0);

        expect(find.byType(ResultScreen), findsOneWidget);
        expect(find.byType(PerfumeDetailsScreen), findsNothing);
        expect(find.byType(ResultPerfumeCard), findsNWidgets(4));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('shows real codes without padding and missing codes as 0000', (
      tester,
    ) async {
      final navigatorKey = GlobalKey<NavigatorState>();

      await openResults(tester, navigatorKey: navigatorKey);

      const expectedCodes = ['YA-4', 'YA-0000', 'YA-0000', 'YA-27'];

      for (var index = 0; index < expectedCodes.length; index++) {
        await openPerfume(tester, index);

        expect(find.text(expectedCodes[index]), findsOneWidget);

        if (index == 0) {
          expect(find.text('YA-0004'), findsNothing);
        }

        await tapDetailsAction(tester, 0);
      }

      expect(find.byType(ResultScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('starts a new journey and removes the previous routes', (
      tester,
    ) async {
      final navigatorKey = GlobalKey<NavigatorState>();

      await openResults(tester, navigatorKey: navigatorKey);

      await openPerfume(tester, 0);

      // ثاني زر: بدء رحلة جديدة.
      await tapDetailsAction(tester, 1);

      expect(find.byType(ResultScreen), findsNothing);
      expect(find.byType(PerfumeDetailsScreen), findsNothing);
      expect(find.byType(SelectLanguageScreen), findsOneWidget);

      // مينفعش الرجوع للنتائج بعد بدء رحلة جديدة.
      expect(navigatorKey.currentState!.canPop(), isFalse);

      final languageScreenContext = tester.element(
        find.byType(SelectLanguageScreen),
      );

      expect(
        ModalRoute.of(languageScreenContext)?.settings.name,
        RouteNames.selectLanguage,
      );

      expect(tester.takeException(), isNull);
    });
  });
}

class _ResultsTestApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final List<PerfumeResultEntity> perfumes;

  const _ResultsTestApp({required this.navigatorKey, required this.perfumes});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1194, 834),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: (context, child) {
            return Directionality(
              textDirection: ui.TextDirection.ltr,
              child: child ?? const SizedBox.shrink(),
            );
          },
          initialRoute: RouteNames.result,
          onGenerateInitialRoutes: (_) {
            final route = AppRoutes.generateRoute(
              RouteSettings(name: RouteNames.result, arguments: perfumes),
            );

            if (route == null) {
              throw StateError('The result route is not configured.');
            }

            return <Route<dynamic>>[route];
          },
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
