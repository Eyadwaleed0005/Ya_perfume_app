import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';

class FamilyCard extends StatelessWidget {
  final FragranceFamily family;

  const FamilyCard({super.key, required this.family});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            family.number,
            style: AppTextStyle.font16textAccentMediumNoto(),
            textDirection: TextDirection.rtl,
          ),
          verticalSpace(8),
          Text(
            family.title,
            style: AppTextStyle.font18textPrimarySemiBoldNoto(),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          verticalSpace(12),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              family.description,
              style: AppTextStyle.font16textMutedRegularNoto(),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
