import 'package:flutter/material.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/question_body_widgets/question_image_widgets.dart';

class QuestionImage extends StatelessWidget {
  final String? imagePath;
  final Color borderColor;
  final QuestionsCubit cubit;

  const QuestionImage({
    super.key,
    required this.imagePath,
    required this.borderColor,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final questionId = cubit.currentQuestion.id;
    final imageWidgets = QuestionImageWidgets(cubit: cubit);

    return Expanded(
      flex: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          return switch (questionId) {
            '1' || '2' || '3' => imageWidgets.buildSingleImage(
              w,
              h,
              imagePath,
              borderColor,
            ),
            '4' => imageWidgets.buildQ4(w, h, borderColor),
            '5' || '6' => imageWidgets.buildQ5Q6(
              w,
              h,
              borderColor,
            ),
            '7' => imageWidgets.buildQ7(
              w,
              h,
              imagePath,
              borderColor,
            ),
            '8' => imageWidgets.buildQ8(
              w,
              h,
              imagePath,
              borderColor,
            ),
            '9' => imageWidgets.buildQ9(
              w,
              h,
              imagePath,
              borderColor,
            ),
            _ => imageWidgets.buildSingleImage(
              w,
              h,
              imagePath,
              borderColor,
            ),
          };
        },
      ),
    );
  }
}
