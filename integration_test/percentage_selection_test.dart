import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ya_perfume/app/di/service_locator.dart';
import 'package:ya_perfume/app/routes/app_routes.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/features/percentage_selection/domain/repositories/percentage_selection_repository.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/cubit/percentage_selection_cubit.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/cubit/percentage_selection_state.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/screens/percentage_selection_screen.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/widgets/percentage_selection_screen_widgets/percentage_selection_actions.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/widgets/percentage_selection_screen_widgets/percentage_selection_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'select percentages, open loading, and calculate four real suggestions',
    (tester) async {
      await getIt.reset();
      setupServiceLocator();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);

      await ScreenUtil.ensureScreenSize();
      await EasyLocalization.ensureInitialized();

      await tester.pumpWidget(
        EasyLocalization(
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
          child: const _PercentageSelectionTestApp(),
        ),
      );

      await tester.pumpAndSettle();

      final cards = find.byType(PercentageSelectionCard);
      expect(cards, findsNWidgets(4));

      final actions = find.byType(PercentageSelectionActions);

      final cubit = tester
          .element(actions)
          .read<PercentageSelectionCubit>();

      Finder suggestionsButton() {
        return find
            .descendant(
              of: actions,
              matching: find.byType(ElevatedButton),
            )
            .last;
      }

      Finder cardButton(int index, IconData icon) {
        return find.descendant(
          of: cards.at(index),
          matching: find.widgetWithIcon(IconButton, icon),
        );
      }

      void expectSubmitEnabled(bool enabled) {
        final button = tester.widget<ElevatedButton>(
          suggestionsButton(),
        );

        expect(
          button.onPressed,
          enabled ? isNotNull : isNull,
        );
      }

      expect(cubit.state.total, 0);
      expectSubmitEnabled(false);

      for (var index = 0; index < 4; index++) {
        final decrease = tester.widget<IconButton>(
          cardButton(index, Icons.remove),
        );

        expect(decrease.onPressed, isNull);
      }

      for (var index = 0; index < 4; index++) {
        var taps = 0;

        while (
          tester.widget<PercentageSelectionCard>(
            cards.at(index),
          ).percentage < 25
        ) {
          expect(taps, lessThan(25));

          await tester.tap(cardButton(index, Icons.add));
          await tester.pumpAndSettle();

          taps++;
        }

        expect(
          tester.widget<PercentageSelectionCard>(
            cards.at(index),
          ).percentage,
          25,
        );
      }

      expect(cubit.state.total, 100);
      expect(cubit.state.canSubmit, isTrue);
      expectSubmitEnabled(true);

      await tester.tap(cardButton(0, Icons.add));
      await tester.pumpAndSettle();

      expect(cubit.state.total, greaterThan(100));
      expectSubmitEnabled(false);

      await tester.tap(cardButton(0, Icons.remove));
      await tester.pumpAndSettle();

      expect(cubit.state.total, 100);
      expectSubmitEnabled(true);

      await tester.tap(suggestionsButton());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      final loadingTitle = find.text(
        'percentage_selection_loading_title'.tr(),
      );

      expect(loadingTitle, findsOneWidget);

      expect(
        ModalRoute.of(tester.element(loadingTitle))?.settings.name,
        RouteNames.percentageSelectionLoading,
      );

      expect(
        cubit.state.status,
        PercentageSelectionStatus.loading,
      );

      await tester.pump(const Duration(seconds: 12));

      for (
        var attempt = 0;
        attempt < 30 &&
            cubit.state.status != PercentageSelectionStatus.success;
        attempt++
      ) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      expect(
        cubit.state.status,
        PercentageSelectionStatus.success,
      );

      expect(cubit.state.perfumes, hasLength(4));

      final storedPerfumes = await getIt<
          PercentageSelectionRepository>().getPerfumes();

      expect(storedPerfumes, isNotEmpty);

      for (final perfume in cubit.state.perfumes) {
        expect(
          storedPerfumes.any(
            (stored) =>
                stored.code == perfume.code &&
                stored.name == perfume.name &&
                stored.percentages.differenceFrom(
                      perfume.percentages,
                    ) ==
                    0,
          ),
          isTrue,
        );
      }
      final results = cubit.state.perfumes;
      final selection = cubit.state.percentages;

      for (var index = 1; index < results.length; index++) {
        final previous = results[index - 1];
        final current = results[index];

        final previousDifference = selection.differenceFrom(
          previous.percentages,
        );

        final currentDifference = selection.differenceFrom(
          current.percentages,
        );

        expect(
          previousDifference,
          lessThanOrEqualTo(currentDifference),
        );

        if (previousDifference == currentDifference) {
          expect(
            previous.name.compareTo(current.name),
            lessThanOrEqualTo(0),
          );
        }
      }

      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await getIt.reset();
    },
  );
}

class _PercentageSelectionTestApp extends StatelessWidget {
  const _PercentageSelectionTestApp();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1194, 834),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.generateRoute,
          home: const PercentageSelectionScreen(),
          builder: (context, child) {
            return Directionality(
              textDirection: ui.TextDirection.ltr,
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}