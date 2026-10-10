import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class ChoosePerfumeMethodCard extends StatefulWidget {
  const ChoosePerfumeMethodCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.footer,
    required this.onTap,
    this.height,
  });

  final String imagePath;
  final String title;
  final String description;
  final String footer;
  final VoidCallback onTap;
  final double? height;

  @override
  State<ChoosePerfumeMethodCard> createState() =>
      _ChoosePerfumeMethodCardState();
}

class _ChoosePerfumeMethodCardState extends State<ChoosePerfumeMethodCard> {
  bool _isPressed = false;

  void _onHighlightChanged(bool isPressed) {
    if (_isPressed == isPressed) return;

    setState(() {
      _isPressed = isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(22.r);
    final textDirection = context.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return AnimatedScale(
      scale: _isPressed ? 0.98 : 1,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: SizedBox(
        height: widget.height,
        child: Material(
          color: AppColors.bgCanvas,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(color: AppColors.goldAccent, width: 1.5.w),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            onHighlightChanged: _onHighlightChanged,
            borderRadius: borderRadius,
            splashFactory: NoSplash.splashFactory,
            highlightColor: AppColors.goldAccent.withValues(alpha: 0.08),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RepaintBoundary(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: AspectRatio(
                        aspectRatio: 460 / 220,
                        child: SvgPicture.asset(
                          widget.imagePath,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(12),
                  Text(
                    widget.title,
                    textDirection: textDirection,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.font18textPrimarySemiBoldNoto(),
                  ),
                  verticalSpace(8),
                  Text(
                    widget.description,
                    textDirection: textDirection,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.font15textMutedRegularNoto(),
                  ),

                  // المساحة الزايدة فوق الـfooter لتثبيته تحت.
                  if (widget.height != null) const Spacer(),

                  verticalSpace(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: [
                      Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.goldAccentLight,
                          border: Border.all(
                            color: AppColors.goldAccent,
                            width: 1.5.w,
                          ),
                        ),
                      ),
                      horizontalSpace(8),
                      Flexible(
                        child: Text(
                          widget.footer,
                          textDirection: textDirection,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.font15textMutedRegularNoto(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
