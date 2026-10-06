import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ya_perfume/core/animation/app_animation.dart';
import 'package:ya_perfume/features/language/presentation/cubit/language_cubit.dart';
import 'package:ya_perfume/features/language/presentation/cubit/language_state.dart';

class SelectLanguageButton extends StatelessWidget {
  const SelectLanguageButton({
    super.key,
    required this.imagePath,
    required this.languageCode,
  });

  final String imagePath;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final isSelected = state.selectedLocale.languageCode == languageCode;

        return SizedBox(
          width: 160.w,
          height: 110.h,
          child: AppAnimation.languageSelection(
            isSelected: isSelected,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(14.r),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  context.read<LanguageCubit>().selectLanguage(languageCode);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 16.h,
                  ),
                  child: SvgPicture.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
