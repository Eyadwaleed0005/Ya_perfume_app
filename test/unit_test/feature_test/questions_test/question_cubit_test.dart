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
    test('getQuestions', () {
      cubit.getQuestions();
      expect(cubit.state.questions.length, 9);
    });
  });
}
