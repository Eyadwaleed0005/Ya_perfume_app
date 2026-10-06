import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/app_startup/presentation/cubit/splash_cubit.dart';
import 'package:ya_perfume/features/app_startup/presentation/cubit/splash_state.dart';

void main() {
  group('SplashCubit', () {
    test('initial state should be SplashInitial', () async {
      final cubit = SplashCubit();

      try {
        expect(cubit.state, isA<SplashInitial>());
      } finally {
        await cubit.close();
      }
    });

    blocTest<SplashCubit, SplashState>(
      'completeLoading should emit SplashCompleted',
      build: SplashCubit.new,
      act: (cubit) {
        cubit.completeLoading();
      },
      expect: () => [
        isA<SplashCompleted>(),
      ],
    );

    blocTest<SplashCubit, SplashState>(
      'repeated completion should emit SplashCompleted only once',
      build: SplashCubit.new,
      act: (cubit) {
        cubit.completeLoading();
        cubit.completeLoading();
        cubit.completeLoading();
      },
      expect: () => [
        isA<SplashCompleted>(),
      ],
    );

    test('completion after closing should not throw', () async {
      final cubit = SplashCubit();

      await cubit.close();

      expect(
        () => cubit.completeLoading(),
        returnsNormally,
      );
    });
  });
}