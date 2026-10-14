import 'package:ya_perfume/core/error/error_model.dart';

sealed class AppActivationState {
  const AppActivationState();
}

final class AppActivationInitial extends AppActivationState {
  const AppActivationInitial();
}

final class AppActivationLoading extends AppActivationState {
  const AppActivationLoading();
}

final class AppActivationSuccess extends AppActivationState {
  final bool isActive;

  const AppActivationSuccess({
    required this.isActive,
  });
}

final class AppActivationFailure extends AppActivationState {
  final ErrorModel error;

  const AppActivationFailure({
    required this.error,
  });
}