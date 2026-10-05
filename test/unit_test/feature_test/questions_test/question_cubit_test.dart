import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/features/questions/data/models/question_model.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

void _skipTo(QuestionsCubit cubit, int index) {
  for (int i = 0; i < index; i++) {
    cubit.toggleOption('1');
    cubit.next();
  }
}

void main() {
  group('QuestionsCubit', () {
    late QuestionsCubit cubit;
    setUp(() {
      cubit = QuestionsCubit();
    });
    tearDown(() {
      cubit.close();
    });

    test('initial state of QuestionCubit', () async {
      expect(cubit.state.currentIndex, 0);
      expect(cubit.state.questions, isEmpty);
      expect(cubit.state.families, isEmpty);
      expect(cubit.state.allAnswers, isEmpty);
      expect(cubit.state.showInfo, false);
      expect(cubit.state.selectedThemeType, isNull);
      expect(cubit.state.accumulatedImages, isEmpty);
    });

    blocTest<QuestionsCubit, QuestionsState>(
      'getQuestions should load 9 questions',
      build: () => QuestionsCubit(),
      act: (cubit) => cubit.getQuestions(),
      expect: () => [
        isA<QuestionsState>().having(
          (p0) => p0.questions.length,
          'questions length',
          9,
        ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'question 5 should allow multiple selections',
      build: QuestionsCubit.new,
      act: (cubit) {
        cubit.getQuestions();
      },
      expect: () => [
        isA<QuestionsState>()
            .having(
              (state) => state.questions[4].selectionType,
              'selection type',
              QuestionSelectionType.multiple,
            )
            .having(
              (state) => state.questions[4].minSelections,
              'min selections',
              1,
            )
            .having(
              (state) => state.questions[4].maxSelections,
              'max selections',
              2,
            ),
      ],
    );
    blocTest<QuestionsCubit, QuestionsState>(
      'question 6 should allow multiple selections or skip',
      build: QuestionsCubit.new,
      act: (cubit) {
        cubit.getQuestions();
      },
      expect: () => [
        isA<QuestionsState>()
            .having(
              (state) => state.questions[5].selectionType,
              'selection type',
              QuestionSelectionType.multiple,
            )
            .having(
              (state) => state.questions[5].isSkippable,
              'is skippable',
              true,
            )
            .having(
              (state) => state.questions[5].minSelections,
              'min selections',
              1,
            )
            .having(
              (state) => state.questions[5].maxSelections,
              'max selections',
              2,
            ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'toggleOption should select one option for single-selection question',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        cubit.toggleOption('1');
      },
      skip: 1,
      expect: () => [
        isA<QuestionsState>().having(
          (p0) => p0.selectedOptions,
          'selectedOptions[1]',
          {'1'},
        ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'single selection should replace previous option',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        cubit.toggleOption('1');
        cubit.toggleOption('2');
      },
      skip: 2,
      expect: () => [
        isA<QuestionsState>().having(
          (p0) => p0.selectedOptions,
          'selectedOptions[2]',
          {'2'},
        ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'deselect option if already selected',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        cubit.toggleOption('1');
        cubit.toggleOption('1');
      },
      skip: 2,
      expect: () => [
        isA<QuestionsState>().having(
          (p0) => p0.selectedOptions,
          'selectedOptions[1]',
          isEmpty,
        ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'question num 5 should allow up to two selections',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        _skipTo(cubit, 4);

        // Q5
        cubit.toggleOption('1');
        cubit.toggleOption('2');
      },
      skip: 12,

      expect: () {
        return [
          isA<QuestionsState>()
              .having((state) => state.currentIndex, 'current index', 4)
              .having((state) => state.selectedOptions, 'two selections', {
                '1',
                '2',
              }),
        ];
      },
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'question num 5 should show info when max selections is reached',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();

        _skipTo(cubit, 4);

        cubit.toggleOption('1');
        cubit.toggleOption('2');
        cubit.toggleOption('3');
      },
      skip: 12,
      expect: () => [
        isA<QuestionsState>().having(
          (state) => state.currentIndex,
          'current index',
          4,
        ),
        isA<QuestionsState>()
            .having((state) => state.selectedOptions, 'selected options', {
              '1',
              '2',
            })
            .having((state) => state.showInfo, 'show info', true),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'next should not move when current question cannot continue',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        cubit.next();
      },
      expect: () => [isA<QuestionsState>()],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'next should move to next question after valid selection',
      build: QuestionsCubit.new,
      act: (cubit) {
        cubit.getQuestions();
        cubit.toggleOption('1');
        cubit.next();
      },
      expect: () => [
        isA<QuestionsState>(),
        isA<QuestionsState>().having(
          (state) => state.selectedOptions,
          'selected options',
          {'1'},
        ),
        isA<QuestionsState>().having(
          (state) => state.currentIndex,
          'current index',
          1,
        ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'previous should go back one question',
      build: QuestionsCubit.new,
      act: (cubit) {
        cubit.getQuestions();
        cubit.toggleOption('1');
        cubit.next();
        cubit.previous();
      },
      expect: () => [
        isA<QuestionsState>(),
        isA<QuestionsState>().having(
          (state) => state.selectedOptions,
          'selected options',
          {'1'},
        ),
        isA<QuestionsState>().having(
          (state) => state.currentIndex,
          'current index after next',
          1,
        ),
        isA<QuestionsState>().having(
          (state) => state.currentIndex,
          'current index after previous',
          0,
        ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'skip should move to next question when question is skippable',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        _skipTo(cubit, 5);
        cubit.skip();
      },
      skip: 12,
      expect: () => [
        isA<QuestionsState>().having(
          (state) => state.currentIndex,
          'current index after skip',
          6,
        ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'question 3 option 1 should select light theme',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        _skipTo(cubit, 2);
        cubit.toggleOption('1');
      },
      skip: 5,
      expect: () => [
        isA<QuestionsState>()
            .having((state) => state.currentIndex, 'current index', 2)
            .having((state) => state.selectedOptions, 'selected options', {'1'})
            .having(
              (state) => state.selectedThemeType,
              'theme',
              AppThemeType.light,
            ),
      ],
    );
    blocTest<QuestionsCubit, QuestionsState>(
      'question 3 option 2 should select dark theme',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        _skipTo(cubit, 2);
        cubit.toggleOption('2');
      },
      skip: 5,
      expect: () => [
        isA<QuestionsState>()
            .having((state) => state.currentIndex, 'current index', 2)
            .having((state) => state.selectedOptions, 'selected options', {'2'})
            .having(
              (state) => state.selectedThemeType,
              'theme',
              AppThemeType.dark,
            ),
      ],
    );
    blocTest<QuestionsCubit, QuestionsState>(
      'question 3 option 3 should select normal theme',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        _skipTo(cubit, 2);
        cubit.toggleOption('3');
      },
      skip: 5,
      expect: () => [
        isA<QuestionsState>()
            .having((state) => state.currentIndex, 'current index', 2)
            .having((state) => state.selectedOptions, 'selected options', {'3'})
            .having(
              (state) => state.selectedThemeType,
              'theme',
              AppThemeType.normal,
            ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'save image should be empty in qeustion 1 & 2',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        cubit.toggleOption('1');
        cubit.next();
        cubit.toggleOption('1');
      },
      skip: 3,
      expect: () => [
        isA<QuestionsState>().having(
          (state) => state.accumulatedImages,
          'images is empty',
          isEmpty,
        ),
      ],
    );

    blocTest<QuestionsCubit, QuestionsState>(
      'save image should be not empty in qeustion 3 or above',
      build: () => QuestionsCubit(),
      act: (cubit) {
        cubit.getQuestions();
        _skipTo(cubit, 2);
        cubit.toggleOption('1');
      },
      skip: 5,
      expect: () => [
        isA<QuestionsState>().having(
          (state) => state.accumulatedImages,
          'images is not empty',
          isNotEmpty,
        ),
      ],
    );
  });
}
