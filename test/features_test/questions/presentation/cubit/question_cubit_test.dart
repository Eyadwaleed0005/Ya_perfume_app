import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/features/questions/data/adapters/perfume_questions_adapter.dart';
import 'package:ya_perfume/features/questions/data/models/question_model.dart';
import 'package:ya_perfume/features/questions/domain/entities/perfume_questions_entity.dart';
import 'package:ya_perfume/features/questions/domain/use_cases/get_perfumes_use_case.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

class MockGetPerfumesUseCase extends Mock implements GetPerfumesUseCase {}

class FakePerfumeQuestionsEntity extends Mock
    implements PerfumeQuestionsEntity {}

class MockPerfumeQuestionsAdapter extends Mock
    implements PerfumeQuestionsAdapter {}

QuestionsCubit _loadedCubit() {
  final mock = MockGetPerfumesUseCase();
  when(() => mock.call(any())).thenAnswer((_) async => []);
  final cubit = QuestionsCubit(
    getPerfumesUseCase: mock,
    perfumeQuestionsAdapter: MockPerfumeQuestionsAdapter(),
  );
  cubit.getQuestions();
  return cubit;
}

QuestionsCubit _cubitAtQuestion(int index) {
  final cubit = _loadedCubit();

  for (int i = 0; i < index; i++) {
    cubit.toggleOption('1');
    cubit.next();
  }

  expect(cubit.state.currentIndex, index);

  return cubit;
}

Matcher _hasSelectedOptions(Set<String> options) {
  return isA<QuestionsState>().having(
    (state) => state.selectedOptions,
    'selectedOptions',
    options,
  );
}

void main() {
  late MockGetPerfumesUseCase usecase;
  late MockPerfumeQuestionsAdapter adapter;
  late PerfumeQuestionsEntity perfumeQuestionsEntity;
  registerFallbackValue(FakePerfumeQuestionsEntity());
  registerFallbackValue(const QuestionsState());

  setUp(() {
    usecase = MockGetPerfumesUseCase();
    adapter = MockPerfumeQuestionsAdapter();
    perfumeQuestionsEntity = PerfumeQuestionsEntity(
      code: 000,
      name: 'sayed',
      numOfAcceptance: 0,
      gender: "نسائي",
      ageGroups: ["20-29", "30-39"],
      usageTime: "صباحاً ونهارًا",
      season: "طول العام",
      preferredScents: ["زهري", "نظيف ومسكي وبروائح البودرة"],
      avoidedScents: ["الزهور القوية", "المسك وروائح البودرة"],
      occasions: ["استخدام يومي للعمل أو الدراسة", "موعد رومانسي أو عشاء هادئ"],
      styles: ["أنيق وراقٍ", "ناعم ورومانسي"],
      projection: "واضح ومتوازن",
    );
  });
  group('QuestionsCubit', () {
    test('initial state should be empty', () async {
      final cubit = QuestionsCubit(
        getPerfumesUseCase: usecase,
        perfumeQuestionsAdapter: adapter,
      );

      try {
        expect(cubit.state.currentIndex, 0);
        expect(cubit.state.questions, isEmpty);
        expect(cubit.state.families, isEmpty);
        expect(cubit.state.allAnswers, isEmpty);
        expect(cubit.state.showInfo, false);
        expect(cubit.state.selectedThemeType, isNull);
        expect(cubit.state.accumulatedImages, isEmpty);
      } finally {
        await cubit.close();
      }
    });

    blocTest<QuestionsCubit, QuestionsState>(
      'getQuestions should load 9 questions',
      build: () => QuestionsCubit(
        getPerfumesUseCase: usecase,
        perfumeQuestionsAdapter: adapter,
      ),
      act: (cubit) {
        cubit.getQuestions();
      },
      expect: () => [
        isA<QuestionsState>().having(
          (state) => state.questions.length,
          'questions length',
          9,
        ),
      ],
    );

    test('question 5 should allow one or two selections', () async {
      final cubit = _loadedCubit();

      try {
        final question = cubit.state.questions[4];

        expect(question.selectionType, QuestionSelectionType.multiple);
        expect(question.minSelections, 1);
        expect(question.maxSelections, 2);
      } finally {
        await cubit.close();
      }
    });

    test('question 6 should allow multiple selections or skip', () async {
      final cubit = _loadedCubit();

      try {
        final question = cubit.state.questions[5];

        expect(question.selectionType, QuestionSelectionType.multiple);
        expect(question.isSkippable, true);
        expect(question.minSelections, 1);
        expect(question.maxSelections, 2);
      } finally {
        await cubit.close();
      }
    });

    blocTest<QuestionsCubit, QuestionsState>(
      'single-selection question should select one option',
      build: _loadedCubit,
      act: (cubit) {
        cubit.toggleOption('1');
      },
      expect: () => [
        _hasSelectedOptions({'1'}),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'single selection should replace the previous option',
      build: () {
        final cubit = _loadedCubit();
        cubit.toggleOption('1');
        return cubit;
      },
      act: (cubit) {
        cubit.toggleOption('2');
      },
      expect: () => [
        _hasSelectedOptions({'2'}),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'selecting the same option again should deselect it',
      build: () {
        final cubit = _loadedCubit();
        cubit.toggleOption('1');
        return cubit;
      },
      act: (cubit) {
        cubit.toggleOption('1');
      },
      expect: () => [_hasSelectedOptions(<String>{})],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'question 5 should allow two selections',
      build: () => _cubitAtQuestion(4),
      act: (cubit) {
        cubit.toggleOption('1');

        expect(cubit.state.currentIndex, 4);
        expect(cubit.state.selectedOptions, {'1'});

        cubit.toggleOption('2');
      },
      verify: (cubit) {
        expect(cubit.state.currentIndex, 4);
        expect(cubit.state.selectedOptions, {'1', '2'});
      },
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'question 5 should reject a third selection and show info',
      build: () {
        final cubit = _cubitAtQuestion(4);
        cubit.toggleOption('1');
        cubit.toggleOption('2');
        return cubit;
      },
      act: (cubit) {
        cubit.toggleOption('3');
      },
      expect: () => [
        isA<QuestionsState>()
            .having((state) => state.currentIndex, 'currentIndex', 4)
            .having((state) => state.selectedOptions, 'selectedOptions', {
              '1',
              '2',
            })
            .having((state) => state.showInfo, 'showInfo', true),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'question 5 should allow deselecting one of two options',
      build: () => _cubitAtQuestion(4),
      act: (cubit) {
        cubit.toggleOption('1');
        cubit.toggleOption('2');

        expect(cubit.state.selectedOptions, {'1', '2'});

        cubit.toggleOption('1');
      },
      verify: (cubit) {
        expect(cubit.state.currentIndex, 4);
        expect(cubit.state.selectedOptions, {'2'});
      },
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'next should not move without a valid selection',
      build: _loadedCubit,
      act: (cubit) {
        cubit.next();
      },
      verify: (cubit) {
        expect(cubit.state.currentIndex, 0);
        expect(cubit.state.selectedOptions, isEmpty);
      },
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'next should move after a valid selection',
      build: () {
        final cubit = _loadedCubit();
        cubit.toggleOption('1');
        return cubit;
      },
      act: (cubit) {
        cubit.next();
      },
      expect: () => [
        isA<QuestionsState>().having(
          (state) => state.currentIndex,
          'currentIndex',
          1,
        ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'previous should return to the previous question',
      build: () => _cubitAtQuestion(1),
      act: (cubit) {
        cubit.previous();
      },
      expect: () => [
        isA<QuestionsState>().having(
          (state) => state.currentIndex,
          'currentIndex',
          0,
        ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'previous should restore the previous answer',
      build: () => _cubitAtQuestion(1),
      act: (cubit) {
        cubit.previous();
      },
      verify: (cubit) {
        expect(cubit.state.currentIndex, 0);
        expect(cubit.state.selectedOptions, {'1'});
      },
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'skip should move past question 6 without selecting an option',
      build: () => _cubitAtQuestion(5),
      act: (cubit) {
        cubit.skip();
      },
      expect: () => [
        isA<QuestionsState>().having(
          (state) => state.currentIndex,
          'currentIndex',
          6,
        ),
      ],
    );

    final question3Themes = <String, AppThemeType>{
      '1': AppThemeType.light,
      '2': AppThemeType.dark,
      '3': AppThemeType.normal,
    };

    for (final entry in question3Themes.entries) {
      blocTest<QuestionsCubit, QuestionsState>(
        'question 3 option ${entry.key} should select ${entry.value.name} theme',
        build: () => _cubitAtQuestion(2),
        act: (cubit) {
          cubit.toggleOption(entry.key);
        },
        expect: () => [
          isA<QuestionsState>()
              .having((state) => state.currentIndex, 'currentIndex', 2)
              .having((state) => state.selectedOptions, 'selectedOptions', {
                entry.key,
              })
              .having(
                (state) => state.selectedThemeType,
                'selectedThemeType',
                entry.value,
              ),
        ],
      );
    }

    for (final index in [0, 1]) {
      blocTest<QuestionsCubit, QuestionsState>(
        'question ${index + 1} should not accumulate images',
        build: () => _cubitAtQuestion(index),
        act: (cubit) {
          cubit.toggleOption('1');
        },
        expect: () => [
          isA<QuestionsState>()
              .having((state) => state.selectedOptions, 'selectedOptions', {
                '1',
              })
              .having(
                (state) => state.accumulatedImages,
                'accumulatedImages',
                isEmpty,
              ),
        ],
      );
    }

    blocTest<QuestionsCubit, QuestionsState>(
      'question 3 selection should accumulate an image',
      build: () => _cubitAtQuestion(2),
      act: (cubit) {
        cubit.toggleOption('1');
      },
      expect: () => [
        isA<QuestionsState>()
            .having((state) => state.selectedOptions, 'selectedOptions', {'1'})
            .having(
              (state) => state.accumulatedImages,
              'accumulatedImages',
              isNotEmpty,
            ),
      ],
    );

    blocTest(
      'get perfumes should return perfumes',
      build: () {
        when(() => adapter.adapt(any()))
            .thenAnswer((_) => perfumeQuestionsEntity);
        when(() => usecase.call(perfumeQuestionsEntity))
            .thenAnswer((_) async => [perfumeQuestionsEntity]);

        return QuestionsCubit(
          getPerfumesUseCase: usecase,
          perfumeQuestionsAdapter: adapter,
        );
      },
      act: (cubit) => cubit.getPerfumes(),
      expect: () => [
        isA<QuestionsState>().having(
          (s) => s.status,
          'status',
          QuestionsStatus.loading,
        ),
        isA<QuestionsState>()
            .having((s) => s.status, 'status', QuestionsStatus.loaded)
            .having((s) => s.perfumes, 'perfumes', [perfumeQuestionsEntity]),
      ],
      verify: (_) {
        verify(() => adapter.adapt(any())).called(1);
        verify(() => usecase.call(perfumeQuestionsEntity)).called(1);
      },
    );
  });
}
