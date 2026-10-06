import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/app/di/service_locator.dart';
import 'package:ya_perfume/app/routes/route_names.dart';
import 'package:ya_perfume/core/helper/app_system_ui.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/widgets/percentage_selection_screen_widgets/percentage_selection_content.dart';

import '../cubit/percentage_selection_cubit.dart';
import '../cubit/percentage_selection_state.dart';

class PercentageSelectionScreen extends StatelessWidget {
  const PercentageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: BlocProvider(
        create: (_) => getIt<PercentageSelectionCubit>(),
        child: BlocListener<PercentageSelectionCubit, PercentageSelectionState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == PercentageSelectionStatus.loading) {
              Navigator.of(context)
                  .pushNamed(RouteNames.percentageSelectionLoading);
            }
          },
          child: const Scaffold(body: PercentageSelectionContent()),
        ),
      ),
    );
  }
}
