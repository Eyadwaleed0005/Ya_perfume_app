import 'package:ya_perfume/core/theme/app_theme_colors.dart';

import '../style/app_color.dart';

enum AppThemeType { light, dark, normal }

class AppTheme {
  static const AppThemeColors light = AppThemeColors(
    background: AppColors.lightBackground,
    surfaceOn: AppColors.bgAccent,
    surfaceOff: AppColors.lightCardBackground,
    primary: AppColors.bgAccent,
    secondary: AppColors.bgAccent,
    title: AppColors.textDarkAutumnBrown,
    textPrimary: AppColors.darkBrown,
    textSecondary: AppColors.veryDarkGrayishBlue,
    borderOn: AppColors.borderRedOchre,
    borderOff: AppColors.borderDark,
    primaryButton: AppColors.bgAccent,
  );

  static const AppThemeColors dark = AppThemeColors(
    background: AppColors.darkBackground,
    surfaceOn: AppColors.bgAccent,
    surfaceOff: AppColors.bgSurface,
    primary: AppColors.darkBlue,
    secondary: AppColors.darkBlue,
    title: AppColors.textAccent,
    textPrimary: AppColors.pureWhite,
    textSecondary: AppColors.offWhite,
    borderOn: AppColors.borderAccent,
    borderOff: AppColors.borderDefault,
    primaryButton: AppColors.bgAccent,
  );

  static const AppThemeColors normal = AppThemeColors(
    background: AppColors.normalBackground,
    surfaceOn: AppColors.bgAccent,
    primary: AppColors.bgAccent,
    surfaceOff: AppColors.bgSurface,
    secondary: AppColors.bgAccent,
    title: AppColors.textAccent,
    textPrimary: AppColors.pureWhite,
    textSecondary: AppColors.offWhite,
    borderOn: AppColors.borderAccent,
    borderOff: AppColors.borderDefault,
    primaryButton: AppColors.bgAccent,
  );

  static AppThemeColors fromType(AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return light;
      case AppThemeType.dark:
        return dark;
      case AppThemeType.normal:
        return normal;
    }
  }
}
