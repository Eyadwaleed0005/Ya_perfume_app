import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

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
  });
}
