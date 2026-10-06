import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/app_color.dart';

class ChoosePerfumeMethodBackButton extends StatelessWidget {
  const ChoosePerfumeMethodBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.w,
      height: 48.h,
      child: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        tooltip: 'رجوع',
        style: IconButton.styleFrom(
          padding: EdgeInsets.all(8.w),
          backgroundColor: AppColors.goldAccent,
          foregroundColor: AppColors.pureWhite,
          shape: const CircleBorder(),
        ),
        icon: Icon(
          Icons.west_rounded,
          size: 32.w,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}