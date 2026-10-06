import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';
import 'package:ya_perfume/core/widgets/circular_butter_fly.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/discover_fragrance_families_widget/family_card.dart';
import 'package:ya_perfume/core/widgets/custom_background.dart';

class DiscoverFragranceFamiliesScreenContent extends StatelessWidget {
  final List<FragranceFamily> families;
  final AppThemeType? themeType;

  const DiscoverFragranceFamiliesScreenContent({
    super.key,
    required this.families,
    this.themeType,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeType effectiveThemeType = themeType ?? AppThemeType.normal;
    AppThemeColors theme = AppTheme.fromType(effectiveThemeType);

    return Stack(
      children: [
        CustomBackground(
          backGroundColor: theme.background,
          primaryColor: theme.primary.withValues(alpha: 0.14),
          secondaryColor: theme.secondary,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 64.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'app_name'.tr(),
                  style: AppTextStyle.font18TextAccentMediumNoto().copyWith(
                    color: theme.textSecondary,
                  ),
                ),
              ),
              verticalSpace(16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircularButterFly(
                    width: 80.r,
                    height: 80.r,
                    background: theme.background,
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'discover_fragrance_families'.tr(),
                        style: AppTextStyle.font34textPrimarySemiBoldNoto()
                            .copyWith(color: theme.textPrimary),
                      ),
                      verticalSpace(8),
                      Text(
                        'fragrance_families_description'.tr(),
                        style: AppTextStyle.font18textMutedRegularNoto()
                            .copyWith(color: theme.textSecondary),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ],
              ),

              verticalSpace(20),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    const crossAxisCount = 4;
                    const crossAxisSpacing = 16.0;
                    final totalSpacing =
                        crossAxisSpacing * (crossAxisCount - 1);
                    final cardWidth =
                        (constraints.maxWidth - totalSpacing) / crossAxisCount;
                    final cardHeight = constraints.maxHeight * 0.55;
                    final childAspectRatio = cardWidth / cardHeight;

                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: childAspectRatio,
                      children: families.map((entry) {
                        return FamilyCard(family: entry, themeType: themeType);
                      }).toList(),
                    );
                  },
                ),
              ),

              verticalSpace(24),

              CustomButton(
                text: 'back_to_choices'.tr(),
                onPressed: () {
                  Navigator.pop(context);
                },
                width: 260.w,
                height: 40.h,
                background: theme.primaryButton,
                foreground: AppColors.textUltraBlack,
              ),

              verticalSpace(24),
            ],
          ),
        ),
      ],
    );
  }
}
