import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

import 'choose_perfume_method_card.dart';

class ChoosePerfumeMethodCards extends StatelessWidget {
  const ChoosePerfumeMethodCards({super.key});

  double _textHeight({
    required BuildContext context,
    required String text,
    required TextStyle style,
    required double width,
    required TextDirection direction,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: DefaultTextStyle.of(context).style.merge(style),
      ),
      textDirection: direction,
      textAlign: TextAlign.center,
      textScaler: MediaQuery.textScalerOf(context),
      locale: context.locale,
    )..layout(maxWidth: width);

    final height = painter.height;
    painter.dispose();
    return height;
  }

  double _cardHeight({
    required BuildContext context,
    required double cardWidth,
    required String title,
    required String description,
    required String footer,
    required TextDirection direction,
  }) {
    final contentWidth = math.max(1.0, cardWidth - 24.w);
    final footerWidth = math.max(1.0, contentWidth - 10.w - 8.w);

    final titleHeight = _textHeight(
      context: context,
      text: title,
      style: AppTextStyle.font18textPrimarySemiBoldNoto(),
      width: contentWidth,
      direction: direction,
    );

    final descriptionHeight = _textHeight(
      context: context,
      text: description,
      style: AppTextStyle.font15textMutedRegularNoto(),
      width: contentWidth,
      direction: direction,
    );

    final footerHeight = _textHeight(
      context: context,
      text: footer,
      style: AppTextStyle.font15textMutedRegularNoto(),
      width: footerWidth,
      direction: direction,
    );

    return (24.h +
            contentWidth * 220 / 460 +
            12.h +
            titleHeight +
            8.h +
            descriptionHeight +
            12.h +
            math.max(10.w, footerHeight))
        .ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    final direction = context.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    final questionsTitle = 'perfume_questions_title'.tr(context: context);
    final questionsDescription = 'perfume_questions_description'.tr(
      context: context,
    );
    final questionsFooter = 'perfume_questions_footer'.tr(context: context);

    final ratiosTitle = 'perfume_ratios_title'.tr(context: context);
    final ratiosDescription = 'perfume_ratios_description'.tr(context: context);
    final ratiosFooter = 'perfume_ratios_footer'.tr(context: context);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 864.w),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 600;
            final cardWidth = stacked
                ? constraints.maxWidth
                : (constraints.maxWidth - 24.w) / 2;

            final commonHeight = math.max(
              _cardHeight(
                context: context,
                cardWidth: cardWidth,
                title: questionsTitle,
                description: questionsDescription,
                footer: questionsFooter,
                direction: direction,
              ),
              _cardHeight(
                context: context,
                cardWidth: cardWidth,
                title: ratiosTitle,
                description: ratiosDescription,
                footer: ratiosFooter,
                direction: direction,
              ),
            );

            final questionsCard = AppAnimation.appStartupEntrance(
              delay: const Duration(milliseconds: 120),
              child: ChoosePerfumeMethodCard(
                height: commonHeight,
                imagePath: AppImage().perfumeQuestionsCard,
                title: questionsTitle,
                description: questionsDescription,
                footer: questionsFooter,
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.questions);
                },
              ),
            );

            final percentagesCard = AppAnimation.appStartupEntrance(
              delay: const Duration(milliseconds: 160),
              child: ChoosePerfumeMethodCard(
                height: commonHeight,
                imagePath: AppImage().perfumeRatiosCard,
                title: ratiosTitle,
                description: ratiosDescription,
                footer: ratiosFooter,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RouteNames.percentageSelection);
                },
              ),
            );

            if (stacked) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [questionsCard, verticalSpace(24), percentagesCard],
              );
            }

            return Row(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: questionsCard),
                horizontalSpace(24),
                Expanded(child: percentagesCard),
              ],
            );
          },
        ),
      ),
    );
  }
}
