import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

class QuestionFooter extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool canGoNext;
  final int numberSelected;
  final String? questionId;
  final VoidCallback? onSkip;

  const QuestionFooter({
    super.key,
    required this.onNext,
    required this.onPrevious,
    required this.canGoNext,
    required this.numberSelected,
    this.questionId,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 24.w,
      right: 24.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            text: 'السؤال السابق',
            onPressed: onPrevious,
            width: 230.w,
            height: 40.h,
            background: AppColors.bgCanvas,
            foreground: AppColors.textPrimary,
            borderColor: AppColors.borderDefault.withValues(alpha: 0.14),
            borderWidth: 0.5,
          ),

          if (questionId == '5')
            Text(
              'العائلات المختارة: $numberSelected من 2',
              style: AppTextStyle.font15textMutedMediumNoto(),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),

          if (questionId == '6')
            InkWell(
              onTap: onSkip,
              child: Text(
                'تخطَّ هذا السؤال',
                style: AppTextStyle.font17textAccentUnderLineMediumNoto(),
                textAlign: TextAlign.right,
              ),
            ),

          CustomButton(
            text: 'متابعة',
            onPressed: canGoNext
                ? questionId == '4'
                      ? () {
                          Navigator.of(context)
                              .pushNamed(RouteNames.beforeTheFamilies);
                          context.read<QuestionsCubit>().next();
                        }
                      : onNext
                : null,
            width: 230.w,
            height: 40.h,
            background: canGoNext
                ? AppColors.bgAccent
                : AppColors.bgAccent.withValues(alpha: 0.5),
            foreground: AppColors.textUltraBlack,
          ),
        ],
      ),
    );
  }
}
