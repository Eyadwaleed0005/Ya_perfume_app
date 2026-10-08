import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/core/theme/app_theme_colors.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

class CustomFooter extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool canGoNext;
  final int numberSelected;
  final String? questionId;
  final VoidCallback? onSkip;
  final QuestionsCubit cubit;
  final Widget? centerWidget;

  const CustomFooter({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.canGoNext,
    required this.numberSelected,
    this.questionId,
    this.onSkip,
    required this.cubit,
    this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeType themeType =
        cubit.state.selectedThemeType ?? AppThemeType.normal;
    AppThemeColors theme = AppTheme.fromType(themeType);

    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomButton(
            text: 'previous_question'.tr(),
            onPressed: cubit.state.currentIndex > 0
                ? onPrevious
                : () => Navigator.pop(context),
            width: 230.w,
            height: 40.h,
            background: theme.background,
            foreground: theme.textPrimary,
            borderColor: theme.borderOff.withValues(alpha: 0.14),
            borderWidth: 0.5.w,
          ),

          if (centerWidget != null) centerWidget!,

          CustomButton(
            text: 'continue'.tr(),
            onPressed: canGoNext
                ? questionId == '4'
                      ? () {
                          Navigator.of(context).pushNamed(
                            RouteNames.beforeTheFamilies,
                            arguments: cubit.state.selectedThemeType,
                          );
                          context.read<QuestionsCubit>().next();
                        }
                      : questionId == '9'
                      ? cubit.getPerfumes
                      : onNext
                : null,
            width: 230.w,
            height: 40.h,
            background: canGoNext
                ? theme.primaryButton
                : theme.primaryButton.withValues(alpha: 0.5),
            foreground: AppColors.textUltraBlack,
          ),
        ],
      ),
    );
  }
}
