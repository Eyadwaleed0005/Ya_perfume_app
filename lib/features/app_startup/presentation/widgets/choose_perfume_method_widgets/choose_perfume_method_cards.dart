import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/helper/spacer.dart';

import 'choose_perfume_method_card.dart';

class ChoosePerfumeMethodCards extends StatelessWidget {
  const ChoosePerfumeMethodCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChoosePerfumeMethodCard(
          imagePath: AppImage().perfumeQuestionsCard,
          title: 'perfume_questions_title'.tr(),
          description: 'perfume_questions_description'.tr(),
          footer: 'perfume_questions_footer'.tr(),
          onTap: () {
            Navigator.of(context).pushNamed(RouteNames.questions);
          },
        ),
        horizontalSpace(24),
        ChoosePerfumeMethodCard(
          imagePath: AppImage().perfumeRatiosCard,
          title: 'perfume_ratios_title'.tr(),
          description: 'perfume_ratios_description'.tr(),
          footer: 'perfume_ratios_footer'.tr(),
          onTap: () {
            // هنضيف هنا مسار اسكرين النسب لما نجهّزها.
          },
        ),
      ],
    );
  }
}
