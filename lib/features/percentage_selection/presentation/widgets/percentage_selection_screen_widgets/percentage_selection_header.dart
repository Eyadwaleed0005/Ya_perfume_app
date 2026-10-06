import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class PercentageSelectionHeader extends StatelessWidget {
  const PercentageSelectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'app_name'.tr(),
            textDirection: ui.TextDirection.ltr,
            style: AppTextStyle.font18TextAccentMediumNoto(),
          ),
        ),
        verticalSpace(40),
        Text(
          'perfume_ratios_title'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyle.font36textPrimarySemiBoldNoto(),
        ),
        verticalSpace(12),
        Text(
          'percentage_selection_description'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyle.font19textPrimaryRegularNoto(),
        ),
      ],
    );
  }
}