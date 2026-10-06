import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  void completeLoading() {
    if (isClosed || state is SplashCompleted) return;

    emit(const SplashCompleted());
  }
}