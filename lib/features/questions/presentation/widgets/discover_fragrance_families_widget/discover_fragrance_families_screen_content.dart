import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/before_the_families_widgets/circular_butter_fly.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/discover_fragrance_families_widget/family_card.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_background.dart';

class DiscoverFragranceFamiliesScreenContent extends StatelessWidget {
  final List<FragranceFamily> families;
  const DiscoverFragranceFamiliesScreenContent({
    super.key,
    required this.families,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          QuestionBackground(
            backGroundColor: AppColors.ultraBlack,
            primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
            secondaryColor: AppColors.goldAccent,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 64.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'YA  PERFUME',
                    style: AppTextStyle.font18TextAccentMediumNoto(),
                  ),
                ),
                verticalSpace(16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircularButterFly(width: 80.w, height: 80.h),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'تعرّف على العائلات العطرية',
                          style: AppTextStyle.font34textPrimarySemiBoldNoto(),
                          textDirection: TextDirection.rtl,
                        ),
                        verticalSpace(8),
                        Text(
                          'أمثلة بسيطة تساعدك على تصوّر كل طابع واختيار ما يناسب ذوقك.',
                          style: AppTextStyle.font18textMutedRegularNoto(),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ],
                ),

                verticalSpace(20),

                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 250 / 180,
                      children: families.map((entry) {
                        return FamilyCard(family: entry);
                      }).toList(),
                    ),
                  ),
                ),

                verticalSpace(24),

                // الزرار
                CustomButton(
                  text: 'العودة إلى الاختيارات',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  width: 260.w,
                  height: 40.h,
                  background: AppColors.goldAccent,
                  foreground: AppColors.textDark,
                ),

                verticalSpace(24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
