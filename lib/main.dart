import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/app/di/service_locator.dart';
import 'package:ya_perfume/app/routes/app_routes.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/services/device_preview_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);

  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();

  DevicePreviewService.run(
    child: EasyLocalization(
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
      child: const YaPerfumeApp(),
    ),
  );
}

class YaPerfumeApp extends StatelessWidget {
  const YaPerfumeApp({super.key});

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
          onGenerateTitle: (context) {
            return 'app_name'.tr(context: context);
          },
          builder: (context, child) {
            return DevicePreviewService.appBuilder(
              context,
              Directionality(
                textDirection: ui.TextDirection.ltr,
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
