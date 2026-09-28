import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

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
    final acc = cubit.state.accumulatedImages;

    final q3Image = acc['3'];
    final q4Bottle = acc['4_bottle'];
    final q4Season = acc['4_season'];
    final q7Image = acc['7'];
    final q8Image = acc['8'];

    return Expanded(
      flex: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          return switch (questionId) {
            '1' || '2' || '3' => _buildSingleImage(w, h),
            '4' => _buildQ4(w, h),
            '5' || '6' => _buildQ5Q6(w, h, q3Image, q4Bottle, q4Season),
            '7' => _buildQ7(w, h, q3Image, q4Bottle, q4Season),
            '8' => _buildQ8(w, h, q3Image, q4Bottle, q4Season, q7Image),
            '9' => _buildQ9(
              w,
              h,
              q3Image,
              q4Bottle,
              q4Season,
              q7Image,
              q8Image,
            ),
            _ => _buildSingleImage(w, h),
          };
        },
      ),
    );
  }

  Widget _buildSingleImage(double w, double h) {
    if (imagePath == null) return const SizedBox();
    final questionId = cubit.currentQuestion.id;
    final isLarge = questionId == '1' || questionId == '2';
    return Stack(
      children: [
        Positioned(
          top: isLarge ? h * 0.0 : h * 0.05,
          left: isLarge ? -w * 0.1 : 0, // يطلع شوية للشمال
          width: isLarge ? w * 1.1 : w * 0.80,
          height: isLarge ? h * 0.85 : h * 0.60,
          child: _animatedSvg(imagePath!),
        ),
      ],
    );
  }

  Widget _buildQ4(double w, double h) {
    final acc = cubit.state.accumulatedImages;
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ..._baseElements(
          w: w,
          h: h,
          q3Image: acc['3'],
          q4Bottle: acc['4_bottle'],
          q4Season: acc['4_season'],
        ),
      ],
    );
  }

  Widget _buildQ5Q6(
    double w,
    double h,
    String? q3Image,
    String? q4Bottle,
    String? q4Season,
  ) {
    final questionId = cubit.currentQuestion.id;
    final currImages = questionId == '5'
        ? _getImagesForQuestion('5')
        : [..._getImagesForQuestion('5'), ..._getImagesForQuestion('6')];

    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ..._baseElements(
          w: w,
          h: h,
          q3Image: q3Image,
          q4Bottle: q4Bottle,
          q4Season: q4Season,
        ),
        ...currImages.asMap().entries.map((entry) {
          return Positioned(
            top: entry.key == 0 ? h * 0.15 : h * 0.45,
            right: w * 0.01,
            width: w * 0.35,
            height: h * 0.28,
            child: _animatedSvg(entry.value),
          );
        }),
      ],
    );
  }

  Widget _buildQ7(
    double w,
    double h,
    String? q3Image,
    String? q4Bottle,
    String? q4Season,
  ) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ..._baseElements(
          w: w,
          h: h,
          q3Image: q3Image,
          q4Bottle: q4Bottle,
          q4Season: q4Season,
        ),
        ..._q5q6Elements(w, h),
        if (imagePath != null)
          Positioned(
            bottom: h * 0.1,
            right: w * 0.05,
            width: w * 0.4,
            height: h * 0.3,
            child: _animatedSvg(imagePath!),
          ),
      ],
    );
  }

  Widget _buildQ8(
    double w,
    double h,
    String? q3Image,
    String? q4Bottle,
    String? q4Season,
    String? q7Image,
  ) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        ..._baseElements(
          w: w,
          h: h,
          q3Image: q3Image,
          q4Bottle: q4Bottle,
          q4Season: q4Season,
        ),
        ..._q5q6Elements(w, h),
        if (q7Image != null)
          Positioned(
            bottom: h * 0.1,
            right: w * 0.05,
            width: w * 0.4,
            height: h * 0.3,
            child: _svg(q7Image),
          ),
        if (imagePath != null)
          Positioned(
            top: h * 0.20,
            left: 0,
            width: w * 0.30,
            height: h * 0.28,
            child: _animatedSvg(imagePath!),
          ),
      ],
    );
  }

  Widget _buildQ9(
    double w,
    double h,
    String? q3Image,
    String? q4Bottle,
    String? q4Season,
    String? q7Image,
    String? q8Image,
  ) {
    // حجم الدايرة حسب الاختيار
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
        ..._baseElements(
          w: w,
          h: h,
          q3Image: q3Image,
          q4Bottle: q4Bottle,
          q4Season: q4Season,
        ),
        ..._q5q6Elements(w, h),
        if (q7Image != null)
          Positioned(
            bottom: h * 0.1,
            right: w * 0.05,
            width: w * 0.4,
            height: h * 0.3,
            child: _svg(q7Image),
          ),
        if (q8Image != null)
          Positioned(
            top: h * 0.20,
            left: 0,
            width: w * 0.30,
            height: h * 0.28,
            child: _svg(q8Image),
          ),
        if (imagePath != null)
          Positioned(
            top: circleData.top,
            left: circleData.left,
            width: circleData.size.width,
            height: circleData.size.height,
            child: _animatedSvg(imagePath!, opacity: 0.35),
          ),
      ],
    );
  }

  List<Widget> _baseElements({
    required double w,
    required double h,
    required String? q3Image,
    required String? q4Bottle,
    required String? q4Season,
  }) {
    return [
      if (q3Image != null)
        Positioned(
          top: h * 0.05,
          left: 0,
          width: w * 0.80,
          height: h * 0.60,
          child: _svg(q3Image),
        ),
      if (q4Bottle != null)
        Positioned(
          top: h * 0.05,
          left: 0,
          right: 0,
          bottom: h * 0.15,
          child: Center(child: _svg(q4Bottle)),
        ),
      if (q4Season != null)
        Positioned(
          bottom: h * 0.2,
          left: 0,
          width: w * 0.35,
          height: h * 0.25,
          child: _svg(q4Season),
        ),
    ];
  }

  List<Widget> _q5q6Elements(double w, double h) {
    final q5Images = _getImagesForQuestion('5');
    final q6Images = _getImagesForQuestion('6');
    return [...q5Images, ...q6Images].asMap().entries.map((entry) {
      return Positioned(
        top: entry.key == 0 ? h * 0.15 : h * 0.45,
        right: w * 0.01,
        width: w * 0.35,
        height: h * 0.28,
        child: _svg(entry.value),
      );
    }).toList();
  }

  List<String> _getImagesForQuestion(String questionId) {
    final answers = cubit.state.allAnswers[questionId] ?? {};
    final options = cubit.state.questions
        .firstWhere((q) => q.id == questionId)
        .options;
    return options
        .where((o) => answers.contains(o.id) && o.image != null)
        .map((o) => o.image!)
        .toList();
  }

  Widget _svg(
    String path, {
    double opacity = 1.0,
    double? width,
    double? height,
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

  Widget _animatedSvg(
    String path, {
    double opacity = 1.0,
    double? width,
    double? height,
  }) {
    return AppAnimation.animatedImageSwitcher(
      child: SizedBox(
        key: ValueKey(path),
        width: width,
        height: height,
        child: _svg(path, opacity: opacity),
      ),
    );
  }
}
