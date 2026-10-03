import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

class QuestionImageWidgets {
  final QuestionsCubit cubit;

  final Map<String, String?> acc;
  QuestionImageWidgets({required this.cubit})
    : acc = cubit.state.accumulatedImages;

  Widget buildSingleImage(
    double w,
    double h,
    String? imagePath,
    Color borderColor,
  ) {
    if (imagePath == null) return const SizedBox();

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: -w * 0.1,
          width: w * 1.1,
          height: h * 0.85,
          child: QuestionImageWidgets.animatedSvg(
            imagePath,
            borderColor: borderColor,
          ),
        ),
      ],
    );
  }

  Widget buildQ4(double w, double h, Color borderColor) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ...baseElements(
          w: w,
          h: h,
          q3Image: acc['3'],
          q4Bottle: acc['4_bottle'],
          q4Season: acc['4_season'],
          borderColor: borderColor,
        ),
      ],
    );
  }

  Widget buildQ5Q6(double w, double h, Color borderColor) {
    final questionId = cubit.currentQuestion.id;
    final currImages = questionId == '5'
        ? getImagesForQuestion('5')
        : [...getImagesForQuestion('5'), ...getImagesForQuestion('6')];

    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ...baseElements(
          w: w,
          h: h,
          q3Image: acc['3'],
          q4Bottle: acc['4_bottle'],
          q4Season: acc['4_season'],
          borderColor: borderColor,
        ),
        ...currImages.asMap().entries.map((entry) {
          return Positioned(
            top: entry.key == 0 ? h * 0.15 : h * 0.45,
            right: w * 0.01,
            width: w * 0.35,
            height: h * 0.28,
            child: QuestionImageWidgets.animatedSvg(
              entry.value,
              borderColor: borderColor,
            ),
          );
        }),
      ],
    );
  }

  Widget buildQ7(double w, double h, String? imagePath, Color borderColor) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ...baseElements(
          w: w,
          h: h,
          q3Image: acc['3'],
          q4Bottle: acc['4_bottle'],
          q4Season: acc['4_season'],
          borderColor: borderColor,
        ),
        ...q5q6Elements(w, h, borderColor),
        if (imagePath != null)
          Positioned(
            bottom: h * 0.1,
            right: w * 0.05,
            width: w * 0.4,
            height: h * 0.3,
            child: QuestionImageWidgets.animatedSvg(
              imagePath,
              borderColor: borderColor,
            ),
          ),
      ],
    );
  }

  Widget buildQ8(double w, double h, String? imagePath, Color borderColor) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ...baseElements(
          w: w,
          h: h,
          q3Image: acc['3'],
          q4Bottle: acc['4_bottle'],
          q4Season: acc['4_season'],
          borderColor: borderColor,
        ),
        ...q5q6Elements(w, h, borderColor),
        if (acc['7'] != null)
          Positioned(
            bottom: h * 0.1,
            right: w * 0.05,
            width: w * 0.4,
            height: h * 0.3,
            child: QuestionImageWidgets.animatedSvg(
              acc['7']!,
              borderColor: borderColor,
            ),
          ),
        if (imagePath != null)
          Positioned(
            top: h * 0.20,
            left: 0,
            width: w * 0.30,
            height: h * 0.28,
            child: QuestionImageWidgets.animatedSvg(
              imagePath,
              borderColor: borderColor,
            ),
          ),
      ],
    );
  }

  Widget buildQ9(double w, double h, String? imagePath, Color borderColor) {
    final circleData = switch (imagePath) {
      _ when imagePath == AppImage().smallCircleQ9 => (
        top: h * 0.35,
        left: w * 0.36,
        size: Size(w * 0.25, h * 0.15),
      ),
      _ when imagePath == AppImage().mediumCircleQ9 => (
        top: h * 0.32,
        left: w * 0.33,
        size: Size(w * 0.32, h * 0.19),
      ),
      _ => (top: h * 0.28, left: w * 0.30, size: Size(w * 0.38, h * 0.28)),
    };

    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ...baseElements(
          w: w,
          h: h,
          q3Image: acc['3'],
          q4Bottle: acc['4_bottle'],
          q4Season: acc['4_season'],
          borderColor: borderColor,
        ),
        ...q5q6Elements(w, h, borderColor),
        if (acc['7'] != null)
          Positioned(
            bottom: h * 0.1,
            right: w * 0.05,
            width: w * 0.4,
            height: h * 0.3,
            child: QuestionImageWidgets.animatedSvg(
              acc['7']!,
              borderColor: borderColor,
            ),
          ),
        if (acc['8'] != null)
          Positioned(
            top: h * 0.20,
            left: 0,
            width: w * 0.30,
            height: h * 0.28,
            child: QuestionImageWidgets.animatedSvg(
              acc['8']!,
              borderColor: borderColor,
            ),
          ),
        if (imagePath != null)
          Positioned(
            top: circleData.top,
            left: circleData.left,
            width: circleData.size.width,
            height: circleData.size.height,
            child: QuestionImageWidgets.animatedSvg(
              imagePath,
              borderColor: borderColor,
              opacity: 0.35,
            ),
          ),
      ],
    );
  }

  List<Widget> baseElements({
    required double w,
    required double h,
    required String? q3Image,
    required String? q4Bottle,
    required String? q4Season,
    required Color borderColor,
  }) {
    return [
      if (q3Image != null)
        Positioned(
          top: 0,
          left: -w * 0.1,
          width: w * 1.1,
          height: h * 0.85,
          child: QuestionImageWidgets.animatedSvg(
            q3Image,
            borderColor: borderColor,
          ),
        ),
      if (q4Bottle != null)
        Positioned(
          top: h * 0.05,
          left: 0,
          right: 0,
          bottom: h * 0.15,
          child: Center(
            child: QuestionImageWidgets.animatedSvg(
              q4Bottle,
              borderColor: borderColor,
            ),
          ),
        ),
      if (q4Season != null)
        Positioned(
          bottom: h * 0.2,
          left: 0,
          width: w * 0.35,
          height: h * 0.25,
          child: QuestionImageWidgets.animatedSvg(
            q4Season,
            borderColor: borderColor,
          ),
        ),
    ];
  }

  List<Widget> q5q6Elements(double w, double h, Color borderColor) {
    final q5Images = getImagesForQuestion('5');
    final q6Images = getImagesForQuestion('6');
    return [...q5Images, ...q6Images].asMap().entries.map((entry) {
      return Positioned(
        top: entry.key == 0 ? h * 0.15 : h * 0.45,
        right: w * 0.01,
        width: w * 0.35,
        height: h * 0.28,
        child: QuestionImageWidgets.animatedSvg(
          entry.value,
          borderColor: borderColor,
        ),
      );
    }).toList();
  }

  static Widget svg(
    String path, {
    double opacity = 1.0,
    double? width,
    double? height,
    required Color borderColor,
  }) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        borderColor.withValues(alpha: opacity),
        BlendMode.srcIn,
      ),
    );
  }

  static Widget animatedSvg(
    String path, {
    double opacity = 1.0,
    double? width,
    double? height,
    required Color borderColor,
  }) {
    return AppAnimation.animatedImageSwitcher(
      child: SizedBox(
        key: ValueKey(path),
        width: width,
        height: height,
        child: svg(path, opacity: opacity, borderColor: borderColor),
      ),
    );
  }

  List<String> getImagesForQuestion(String questionId) {
    final answers = cubit.state.allAnswers[questionId] ?? {};
    final options = cubit.state.questions
        .firstWhere((q) => q.id == questionId)
        .options;
    return options
        .where((o) => answers.contains(o.id) && o.image != null)
        .map((o) => o.image!)
        .toList();
  }
}
