import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';

import 'choose_perfume_method_card.dart';

class ChoosePerfumeMethodCards extends StatelessWidget {
  const ChoosePerfumeMethodCards({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppAnimation.appStartupEntrance(
            delay: const Duration(milliseconds: 120),
            child: ChoosePerfumeMethodCard(
              imagePath: AppImage().perfumeQuestionsCard,
              title: 'perfume_questions_title'.tr(context: context),
              description: 'perfume_questions_description'.tr(context: context),
              footer: 'perfume_questions_footer'.tr(context: context),
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.questions);
              },
            ),
          ),
          horizontalSpace(24),
          AppAnimation.appStartupEntrance(
            delay: const Duration(milliseconds: 160),
            child: ChoosePerfumeMethodCard(
              imagePath: AppImage().perfumeRatiosCard,
              title: 'perfume_ratios_title'.tr(context: context),
              description: 'perfume_ratios_description'.tr(context: context),
              footer: 'perfume_ratios_footer'.tr(context: context),
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.percentageSelection);
              },
            ),
          ),
        ],
      ),
    );
  }
}
