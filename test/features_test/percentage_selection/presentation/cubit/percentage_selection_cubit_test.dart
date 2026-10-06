import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/fragrance_percentages.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/perfume_entity.dart';
import 'package:ya_perfume/features/percentage_selection/domain/use_cases/get_closest_perfumes_use_case.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/cubit/percentage_selection_cubit.dart';
import 'package:ya_perfume/features/percentage_selection/presentation/cubit/percentage_selection_state.dart';

class MockGetClosestPerfumesUseCase extends Mock
    implements GetClosestPerfumesUseCase {}

void main() {
  late MockGetClosestPerfumesUseCase useCase;

  const selection = FragrancePercentages(
    sweet: 25,
    fresh: 25,
    floral: 25,
    woody: 25,
  );

  const validState = PercentageSelectionState(percentages: selection);

  final perfumes = List<PerfumeEntity>.generate(
    4,
    (index) => PerfumeEntity(
      code: index + 1,
      name: 'Perfume ${index + 1}',
      percentages: selection,
    ),
  );

  PercentageSelectionCubit createCubit() {
    return PercentageSelectionCubit(getClosestPerfumesUseCase: useCase);
  }

  Matcher hasStatus(PercentageSelectionStatus status) {
    return isA<PercentageSelectionState>().having(
      (state) => state.status,
      'status',
      status,
    );
  }

  setUpAll(() {
    registerFallbackValue(selection);
  });

  setUp(() {
    useCase = MockGetClosestPerfumesUseCase();

    when(() => useCase(any())).thenAnswer((_) async => perfumes);
  });

  group('PercentageSelectionCubit', () {
    test('starts with zero percentages and no results', () async {
      final cubit = createCubit();
      addTearDown(cubit.close);

      expect(cubit.state.status, PercentageSelectionStatus.initial);
      expect(cubit.state.percentages.sweet, 0);
      expect(cubit.state.percentages.fresh, 0);
      expect(cubit.state.percentages.floral, 0);
      expect(cubit.state.percentages.woody, 0);
      expect(cubit.state.total, 0);
      expect(cubit.state.canSubmit, isFalse);
      expect(cubit.state.perfumes, isEmpty);
    });

    group('updatePercentages', () {
      blocTest<PercentageSelectionCubit, PercentageSelectionState>(
        'updates all four families and enables submission at 100',
        build: createCubit,
        act: (cubit) => cubit.updatePercentages(
          sweet: 10,
          fresh: 20,
          floral: 30,
          woody: 40,
        ),
        expect: () => [
          isA<PercentageSelectionState>()
              .having((s) => s.percentages.sweet, 'sweet', 10)
              .having((s) => s.percentages.fresh, 'fresh', 20)
              .having((s) => s.percentages.floral, 'floral', 30)
              .having((s) => s.percentages.woody, 'woody', 40)
              .having((s) => s.canSubmit, 'canSubmit', isTrue),
        ],
      );

      blocTest<PercentageSelectionCubit, PercentageSelectionState>(
        'preserves families that were not updated',
        build: createCubit,
        seed: () => validState,
        act: (cubit) => cubit.updatePercentages(sweet: 35),
        expect: () => [
          isA<PercentageSelectionState>()
              .having((s) => s.percentages.sweet, 'sweet', 35)
              .having((s) => s.percentages.fresh, 'fresh', 25)
              .having((s) => s.percentages.floral, 'floral', 25)
              .having((s) => s.percentages.woody, 'woody', 25)
              .having((s) => s.total, 'total', 110)
              .having((s) => s.canSubmit, 'canSubmit', isFalse),
        ],
      );

      blocTest<PercentageSelectionCubit, PercentageSelectionState>(
        'accepts zero and 100 as valid family values',
        build: createCubit,
        act: (cubit) =>
            cubit.updatePercentages(sweet: 100, fresh: 0, floral: 0, woody: 0),
        expect: () => [
          isA<PercentageSelectionState>()
              .having((s) => s.percentages.sweet, 'sweet', 100)
              .having((s) => s.canSubmit, 'canSubmit', isTrue),
        ],
      );

      final familyNames = ['sweet', 'fresh', 'floral', 'woody'];
      final invalidValues = [
        -1.0,
        101.0,
        double.nan,
        double.infinity,
        double.negativeInfinity,
      ];

      for (var index = 0; index < familyNames.length; index++) {
        for (final invalidValue in invalidValues) {
          blocTest<PercentageSelectionCubit, PercentageSelectionState>(
            'rejects $invalidValue for ${familyNames[index]}',
            build: createCubit,
            seed: () => validState,
            act: (cubit) {
              final values = [25.0, 25.0, 25.0, 25.0];
              values[index] = invalidValue;

              cubit.updatePercentages(
                sweet: values[0],
                fresh: values[1],
                floral: values[2],
                woody: values[3],
              );
            },
            expect: () => <PercentageSelectionState>[],
            verify: (cubit) {
              expect(cubit.state.percentages, same(selection));
            },
          );
        }
      }

      blocTest<PercentageSelectionCubit, PercentageSelectionState>(
        'ignores updates while loading',
        build: createCubit,
        seed: () => const PercentageSelectionState(
          percentages: selection,
          status: PercentageSelectionStatus.loading,
        ),
        act: (cubit) => cubit.updatePercentages(sweet: 50),
        expect: () => <PercentageSelectionState>[],
        verify: (cubit) {
          expect(cubit.state.percentages, same(selection));
        },
      );

      blocTest<PercentageSelectionCubit, PercentageSelectionState>(
        'clears old results and resets status after an update',
        build: createCubit,
        seed: () => PercentageSelectionState(
          percentages: selection,
          status: PercentageSelectionStatus.success,
          perfumes: perfumes,
        ),
        act: (cubit) => cubit.updatePercentages(sweet: 30),
        expect: () => [
          isA<PercentageSelectionState>()
              .having(
                (s) => s.status,
                'status',
                PercentageSelectionStatus.initial,
              )
              .having((s) => s.perfumes, 'perfumes', isEmpty)
              .having((s) => s.percentages.sweet, 'sweet', 30),
        ],
      );
    });

    group('findClosestPerfumes', () {
      for (final total in [0.0, 80.0, 120.0]) {
        blocTest<PercentageSelectionCubit, PercentageSelectionState>(
          'does not search when the total is $total',
          build: createCubit,
          seed: () => PercentageSelectionState(
            percentages: FragrancePercentages(
              sweet: total / 4,
              fresh: total / 4,
              floral: total / 4,
              woody: total / 4,
            ),
          ),
          act: (cubit) => cubit.findClosestPerfumes(),
          expect: () => <PercentageSelectionState>[],
          verify: (_) {
            verifyNever(() => useCase(any()));
          },
        );
      }

      blocTest<PercentageSelectionCubit, PercentageSelectionState>(
        'emits loading then success after at least 12 seconds',
        build: createCubit,
        seed: () => validState,
        act: (cubit) {
          fakeAsync((async) {
            unawaited(cubit.findClosestPerfumes());
            async.flushMicrotasks();

            expect(cubit.state.status, PercentageSelectionStatus.loading);
            expect(cubit.state.canSubmit, isFalse);
            expect(cubit.state.perfumes, isEmpty);

            async.elapse(const Duration(seconds: 11, milliseconds: 999));

            expect(cubit.state.status, PercentageSelectionStatus.loading);

            async.elapse(const Duration(milliseconds: 1));
            async.flushMicrotasks();

            expect(cubit.state.status, PercentageSelectionStatus.success);
          });
        },
        expect: () => [
          hasStatus(PercentageSelectionStatus.loading),
          isA<PercentageSelectionState>()
              .having(
                (state) => state.status,
                'status',
                PercentageSelectionStatus.success,
              )
              .having(
                (state) => state.perfumes,
                'perfumes',
                orderedEquals(perfumes),
              ),
        ],
        verify: (cubit) {
          verify(() => useCase(selection)).called(1);
          expect(cubit.state.percentages, same(selection));
          expect(cubit.state.canSubmit, isTrue);
        },
      );

      blocTest<PercentageSelectionCubit, PercentageSelectionState>(
        'waits for the search when it takes longer than 12 seconds',
        build: createCubit,
        seed: () => validState,
        act: (cubit) {
          fakeAsync((async) {
            final completer = Completer<List<PerfumeEntity>>();

            when(() => useCase(any())).thenAnswer((_) => completer.future);

            unawaited(cubit.findClosestPerfumes());
            async.flushMicrotasks();

            async.elapse(const Duration(seconds: 12));

            expect(cubit.state.status, PercentageSelectionStatus.loading);

            async.elapse(const Duration(seconds: 3));
            completer.complete(perfumes);
            async.flushMicrotasks();

            expect(cubit.state.status, PercentageSelectionStatus.success);
            expect(async.pendingTimers, isEmpty);
          });
        },
        expect: () => [
          hasStatus(PercentageSelectionStatus.loading),
          hasStatus(PercentageSelectionStatus.success),
        ],
        verify: (_) {
          verify(() => useCase(selection)).called(1);
        },
      );

      blocTest<PercentageSelectionCubit, PercentageSelectionState>(
        'ignores a second submission while loading',
        build: createCubit,
        seed: () => validState,
        act: (cubit) {
          fakeAsync((async) {
            unawaited(cubit.findClosestPerfumes());
            unawaited(cubit.findClosestPerfumes());

            async.flushMicrotasks();
            async.elapse(const Duration(seconds: 12));
            async.flushMicrotasks();
          });
        },
        expect: () => [
          hasStatus(PercentageSelectionStatus.loading),
          hasStatus(PercentageSelectionStatus.success),
        ],
        verify: (_) {
          verify(() => useCase(selection)).called(1);
        },
      );

      blocTest<PercentageSelectionCubit, PercentageSelectionState>(
        'clears previous results when a new search begins',
        build: createCubit,
        seed: () => PercentageSelectionState(
          percentages: selection,
          status: PercentageSelectionStatus.success,
          perfumes: perfumes,
        ),
        act: (cubit) {
          fakeAsync((async) {
            unawaited(cubit.findClosestPerfumes());

            expect(cubit.state.perfumes, isEmpty);

            async.flushMicrotasks();
            async.elapse(const Duration(seconds: 12));
            async.flushMicrotasks();
          });
        },
        expect: () => [
          isA<PercentageSelectionState>()
              .having(
                (s) => s.status,
                'status',
                PercentageSelectionStatus.loading,
              )
              .having((s) => s.perfumes, 'perfumes', isEmpty),
          hasStatus(PercentageSelectionStatus.success),
        ],
      );

      test('does not emit success after the cubit is closed', () {
        fakeAsync((async) {
          final cubit = createCubit();

          cubit.updatePercentages(sweet: 25, fresh: 25, floral: 25, woody: 25);

          var completed = false;

          unawaited(
            cubit.findClosestPerfumes().then((_) {
              completed = true;
            }),
          );

          async.flushMicrotasks();

          unawaited(cubit.close());
          async.flushMicrotasks();

          async.elapse(const Duration(seconds: 12));
          async.flushMicrotasks();

          expect(cubit.isClosed, isTrue);
          expect(completed, isTrue);
          expect(cubit.state.status, PercentageSelectionStatus.loading);
        });
      });
    });
  });
}
