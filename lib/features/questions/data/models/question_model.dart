import 'dart:ui';

import 'package:ya_perfume/core/style/app_color.dart';

enum QuestionSelectionType { single, multiple }

class QuestionOption {
  final String id;
  final String text;
  final String? image;
  final Color? backGroundColor;
  final Color? primaryColor;
  final Color? secondaryColor;

  const QuestionOption({
    required this.id,
    required this.text,
    this.image,
    this.backGroundColor,
    this.primaryColor,
    this.secondaryColor,
  });
}

class QuestionModel {
  final String id;
  final String title;
  final String questionText;
  final String note;
  final String? initailImage;
  final List<QuestionOption> options;
  final QuestionSelectionType selectionType;
  final int minSelections;
  final int maxSelections;
  final bool isSkippable;
  final Color? initailBackGroundColor;
  final Color? initailPrimaryColor;
  final Color? initailSecondaryColor;

  const QuestionModel({
    required this.id,
    required this.title,
    required this.questionText,
    required this.note,
    this.initailImage = '',
    required this.options,
    this.selectionType = QuestionSelectionType.single,
    this.minSelections = 1,
    this.maxSelections = 1,
    this.isSkippable = false,
    this.initailBackGroundColor = AppColors.bgCanvas,
    this.initailPrimaryColor = AppColors.goldAccent,
    this.initailSecondaryColor = AppColors.goldAccentLight,
  });
}
