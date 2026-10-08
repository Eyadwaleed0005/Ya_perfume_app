import 'package:flutter/material.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/features/results/domain/entities/perfume_result_entity.dart';
import 'package:ya_perfume/features/results/presentation/widgets/result_screen_widgets/result_perfume_card.dart';


class ResultPerfumeCards extends StatelessWidget {
  final List<PerfumeResultEntity> perfumes;
  final ValueChanged<PerfumeResultEntity> onPerfumeTap;

  const ResultPerfumeCards({
    super.key,
    required this.perfumes,
    required this.onPerfumeTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayedPerfumes = perfumes.take(4).toList(growable: false);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < displayedPerfumes.length; index++) ...[
          if (index > 0) horizontalSpace(20),
          Expanded(
            child: ResultPerfumeCard(
              onTap: () => onPerfumeTap(displayedPerfumes[index]),
            ),
          ),
        ],
      ],
    );
  }
}