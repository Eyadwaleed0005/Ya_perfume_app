import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_perfume/features/app_activation/domain/use_cases/get_app_activation_use_case.dart';
import 'package:ya_perfume/features/app_activation/presentation/cubit/app_activation_state.dart';

class AppActivationCubit extends Cubit<AppActivationState> {
  final GetAppActivationUseCase getAppActivationUseCase;

  AppActivationCubit({required this.getAppActivationUseCase})
    : super(const AppActivationInitial());

  Future<void> getAppActivation() async {
    if (isClosed || state is AppActivationLoading) {
      return;
    }

    emit(const AppActivationLoading());

    final result = await getAppActivationUseCase();

    if (isClosed) {
      return;
    }

    result.fold(
      (error) => emit(AppActivationFailure(error: error)),
      (isActive) => emit(AppActivationSuccess(isActive: isActive)),
    );
  }
}
