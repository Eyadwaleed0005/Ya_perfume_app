import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/features/language/presentation/cubit/language_cubit.dart';
import 'package:ya_perfume/features/language/presentation/cubit/language_state.dart';
import 'package:ya_perfume/features/language/presentation/widgets/select_language_content.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LanguageCubit(
        initialLocale: context.locale,
        supportedLocales: context.supportedLocales,
      ),
      child: BlocListener<LanguageCubit, LanguageState>(
        listener: (context, state) async {
          await context.setLocale(state.selectedLocale);
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppSystemUi.dark(),
          child: const Scaffold(
            backgroundColor: AppColors.bgCanvas,
            body: SelectLanguageContent(),
          ),
        ),
      ),
    );
  }
}
