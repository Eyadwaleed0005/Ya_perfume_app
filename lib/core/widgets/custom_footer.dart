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
  final QuestionsState state;
  final Widget? centerWidget;

  const CustomFooter({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.canGoNext,
    required this.numberSelected,
    this.questionId,
    this.onSkip,
    required this.state,
    this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeType themeType = state.selectedThemeType ?? AppThemeType.normal;
    AppThemeColors theme = AppTheme.fromType(themeType);

    return Positioned(
      bottom: 24.h,
      left: 24.w,
      right: 24.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            text: 'previous_question'.tr(),
            onPressed: onPrevious,
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
                            arguments: state.selectedThemeType,
                          );
                          context.read<QuestionsCubit>().next();
                        }
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
