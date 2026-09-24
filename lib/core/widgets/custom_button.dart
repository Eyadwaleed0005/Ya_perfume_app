import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.foreground,
    this.background,
    this.borderColor,
    this.borderWidth,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? foreground;
  final Color? background;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final Color buttonBackground = background ?? AppColors.bgAccent;

    final Color buttonForeground = foreground ?? AppColors.bgSurface;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBackground,
          foregroundColor: buttonForeground,
          disabledBackgroundColor: buttonBackground,
          disabledForegroundColor: buttonForeground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(35.r),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth ?? 1.5.w)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyle.font18textPrimarySemiBoldNoto().copyWith(
                color: buttonForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
