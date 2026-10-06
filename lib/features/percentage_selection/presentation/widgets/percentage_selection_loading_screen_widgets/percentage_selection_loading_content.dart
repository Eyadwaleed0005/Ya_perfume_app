import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/widgets/percentage_selection_background.dart';

import 'percentage_selection_loading_butterfly.dart';
import 'percentage_selection_loading_intro.dart';

class PercentageSelectionLoadingContent extends StatelessWidget {
  const PercentageSelectionLoadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const PercentageSelectionBackground(),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
            child: Transform.translate(
              offset: Offset(0, 60.h),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: 1100.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PercentageSelectionLoadingButterfly(),
                      verticalSpace(70),
                      const PercentageSelectionLoadingIntro(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'app_name'.tr(),
                textDirection: ui.TextDirection.ltr,
                style: AppTextStyle.font18TextAccentMediumNoto(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
