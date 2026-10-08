import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/widgets/percentage_selection_background.dart';
import 'package:ya_perfume/features/results/domain/entities/perfume_result_entity.dart';
import 'package:ya_perfume/features/results/presentation/widgets/result_screen_widgets/result_actions.dart';
import 'package:ya_perfume/features/results/presentation/widgets/result_screen_widgets/result_perfume_cards.dart';
import 'package:ya_perfume/features/results/presentation/widgets/result_screen_widgets/result_screen_header.dart';

class ResultScreenContent extends StatelessWidget {
  final List<PerfumeResultEntity> perfumes;

  const ResultScreenContent({super.key, required this.perfumes});

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ResultScreenHeader(),
                verticalSpace(60),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: ResultPerfumeCards(
                    perfumes: perfumes,
                    onPerfumeTap: (perfume) {
                      Navigator.of(context).pushNamed(
                        RouteNames.perfumeDetails,
                        arguments: perfume,
                      );
                    },
                  ),
                ),
                verticalSpace(80),
                ResultActions(
                  onStartAgain: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteNames.selectLanguage,
                      (route) => false,
                    );
                  },
                  onReviewSelections: () {
                    Navigator.of(context).maybePop();
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
