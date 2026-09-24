import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/data/models/question_model.dart';

class QuestionOptions extends StatelessWidget {
  final List<QuestionOption> options;
  final Set<String> selectedOptions;
  final QuestionModel questionData;

  const QuestionOptions({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.questionData,
  });

  @override
  Widget build(BuildContext context) {
    if (questionData.id == '4') {
      return _buildQuestionFour(context);
    }

    return _buildDefaultOptions(context);
  }

  Widget _buildQuestionFour(BuildContext context) {
    if (options.length < 3) {
      return _buildDefaultOptions(context);
    }

    final firstOption = options[0];
    final secondOption = options[1];
    final thirdOption = options[2];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 55.h,
                  child: _buildOption(context: context, option: firstOption),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: SizedBox(
                  height: 55.h,
                  child: _buildOption(context: context, option: secondOption),
                ),
              ),
            ],
          ),

          verticalSpace(12),

          SizedBox(
            width: double.infinity,
            height: 55.h,
            child: _buildOption(context: context, option: thirdOption),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultOptions(BuildContext context) {
    final crossAxisCount = options.length >= 4 ? 2 : 1;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: GridView.count(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        mainAxisExtent: 55.h,
        //childAspectRatio: crossAxisCount == 1 ? 660 / 84 : 325 / 84,
        children: options.map((option) {
          return _buildOption(context: context, option: option);
        }).toList(),
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required QuestionOption option,
  }) {
    final isSelected = selectedOptions.contains(option.id);

    return InkWell(
          onTap: () {
            context.read<QuestionsCubit>().toggleOption(option.id);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? AppColors.bgAccent
                    : AppColors.borderDefault.withValues(alpha: 0.24),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(12.r),
              color: isSelected
                  ? AppColors.bgAccent.withValues(alpha: 0.12)
                  : AppColors.bgSurface,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSelectionIndicator(isSelected),
                horizontalSpace(8),
                Expanded(
                  child: Text(
                    option.text,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: AppTextStyle.font18textPrimaryMediumNoto(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 350.ms)
        .slideY(begin: 0.08, end: 0, duration: 400.ms);
  }

  Widget _buildSelectionIndicator(bool isSelected) {
    if (isSelected) {
      return Icon(Icons.circle, color: AppColors.goldAccent, size: 20.r);
    }

    return Container(
      width: 20.r,
      height: 20.r,
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        border: Border.all(
          color: AppColors.borderDefault.withValues(alpha: 0.24),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: Icon(
        Icons.circle_outlined,
        color: AppColors.bgSurface,
        size: 20.r,
      ),
    );
  }
}
