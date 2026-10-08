import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/widgets/percentage_selection_background.dart';
import 'package:ya_perfume/features/results/domain/entities/perfume_result_entity.dart';

import 'perfume_closest_families.dart';
import 'perfume_details_actions.dart';
import 'perfume_match_details.dart';
import 'perfume_product_code.dart';
import 'perfume_tags.dart';

class PerfumeDetailsScreenContent extends StatelessWidget {
  final PerfumeResultEntity perfume;

  const PerfumeDetailsScreenContent({super.key, required this.perfume});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const PercentageSelectionBackground(),
        SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
            child: Column(
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
                Row(
                  textDirection: ui.TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(top: 60.h),
                        child: Center(
                          child: SvgPicture.asset(
                            AppImage().perfumeSignature,
                            width: 350.w,
                            height: 430.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace(32),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PerfumeProductCode(code: perfume.code),
                          verticalSpace(20),
                          PerfumeTags(
                            tags: [
                              perfume.usageTime,
                              perfume.season,
                              ...perfume.styles,
                            ],
                          ),
                          verticalSpace(32),
                          PerfumeMatchDetails(perfume: perfume),
                          verticalSpace(32),
                          PerfumeClosestFamilies(
                            families: perfume.preferredScents,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(60),
                PerfumeDetailsActions(
                  onAllPerfumes: () {
                    Navigator.of(context).pop();
                  },
                  onStartNewJourney: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteNames.selectLanguage,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
