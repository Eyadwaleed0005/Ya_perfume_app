import 'package:ya_perfume/core/theme/app_theme_colors.dart';

import '../style/app_color.dart';

enum AppThemeType { light, dark, normal }

class AppTheme {
  // النمط الفاتح (Light Mode - الأبيض الكلاسيكي الواضح)
  static const AppThemeColors light = AppThemeColors(
    background: AppColors.lightBackground,
    surfaceOn: AppColors.bgAccent,
    surfaceOff: AppColors.lightCardBackground,
    primary: AppColors.goldAccent,
    secondary: AppColors.goldAccent,
    title: AppColors.textDarkAutumnBrown,
    textPrimary: AppColors.darkBrown,
    textSecondary: AppColors.veryDarkGrayishBlue,
    borderOn: AppColors.borderRedOchre,
    borderOff: AppColors.borderDark,
    primaryButton: AppColors.goldAccent,
  );

  // النمط الداكن (Dark Mode - الأسود مع الأجواء الليلية)
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
    primaryButton: AppColors.goldAccent,
  );

  // النمط العادي (Normal Mode - الكريمي الفاتح المستوحى من الثيم الأساسي)
  static const AppThemeColors normal = AppThemeColors(
    background: AppColors.normalBackground,
    surfaceOn: AppColors.bgAccent,
    primary: AppColors.goldAccent,
    surfaceOff: AppColors.bgSurface,
    secondary: AppColors.goldAccent,
    title: AppColors.textAccent,
    textPrimary: AppColors.pureWhite,
    textSecondary: AppColors.offWhite,
    borderOn: AppColors.borderAccent,
    borderOff: AppColors.borderDefault,
    primaryButton: AppColors.goldAccent,
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
