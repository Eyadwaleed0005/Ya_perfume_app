import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/app/di/service_locator.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/features/questions/data/adapters/perfume_questions_adapter.dart';
import 'package:ya_perfume/features/questions/domain/use_cases/get_perfumes_use_case.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:ya_perfume/features/questions/presentation/widgets/questions_widgets/questions_screen_content.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          QuestionsCubit(
              getPerfumesUseCase: getIt<GetPerfumesUseCase>(),
              perfumeQuestionsAdapter: getIt<PerfumeQuestionsAdapter>(),
            )
            ..getQuestions()
            ..getFamilies(),
      child: BlocListener<QuestionsCubit, QuestionsState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == QuestionsStatus.loading) {
            Navigator.of(context)
                .pushNamed(RouteNames.percentageSelectionLoading);
          }
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppSystemUi.dark(),
          child: Scaffold(body: QuestionsScreenContent()),
        ),
      ),
    );
  }
}
