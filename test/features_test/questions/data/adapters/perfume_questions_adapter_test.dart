import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/questions/data/adapters/perfume_questions_adapter.dart';
import 'package:ya_perfume/features/questions/data/models/question_model.dart';
import 'package:ya_perfume/features/questions/domain/entities/perfume_questions_entity.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

void main() {
  late PerfumeQuestionsAdapter adapter;
  late List<QuestionModel> mockQuestions;

  setUp(() {
    adapter = PerfumeQuestionsAdapter();

    mockQuestions = [
      QuestionModel(
        id: '1',
        title: '',
        questionText: '',
        note: '',
        options: [
          QuestionOption(id: '1', text: 'question_1_option_1'),
          QuestionOption(id: '2', text: 'question_1_option_2'),
          QuestionOption(id: '3', text: 'question_1_option_3'),
        ],
      ),
      QuestionModel(
        id: '2',
        title: '',
        questionText: '',
        note: '',
        options: [
          QuestionOption(id: '1', text: 'question_2_option_1'),
          QuestionOption(id: '2', text: 'question_2_option_2'),
          QuestionOption(id: '3', text: 'question_2_option_3'),
          QuestionOption(id: '4', text: 'question_2_option_4'),
          QuestionOption(id: '5', text: 'question_2_option_5'),
        ],
      ),
      QuestionModel(
        id: '3',
        title: '',
        questionText: '',
        note: '',
        options: [
          QuestionOption(id: '1', text: 'question_3_option_1'),
          QuestionOption(id: '2', text: 'question_3_option_2'),
          QuestionOption(id: '3', text: 'question_3_option_3'),
        ],
      ),
      QuestionModel(
        id: '4',
        title: '',
        questionText: '',
        note: '',
        options: [
          QuestionOption(id: '1', text: 'question_4_option_1'),
          QuestionOption(id: '2', text: 'question_4_option_2'),
          QuestionOption(id: '3', text: 'question_4_option_3'),
        ],
      ),
      QuestionModel(
        id: '5',
        title: '',
        questionText: '',
        note: '',
        options: [
          QuestionOption(id: '1', text: 'question_5_option_1'),
          QuestionOption(id: '2', text: 'question_5_option_2'),
          QuestionOption(id: '3', text: 'question_5_option_3'),
          QuestionOption(id: '4', text: 'question_5_option_4'),
          QuestionOption(id: '5', text: 'question_5_option_5'),
          QuestionOption(id: '6', text: 'question_5_option_6'),
          QuestionOption(id: '7', text: 'question_5_option_7'),
          QuestionOption(id: '8', text: 'question_5_option_8'),
        ],
      ),
      QuestionModel(
        id: '6',
        title: '',
        questionText: '',
        note: '',
        options: [
          QuestionOption(id: '1', text: 'question_6_option_1'),
          QuestionOption(id: '2', text: 'question_6_option_2'),
          QuestionOption(id: '3', text: 'question_6_option_3'),
          QuestionOption(id: '4', text: 'question_6_option_4'),
          QuestionOption(id: '5', text: 'question_6_option_5'),
          QuestionOption(id: '6', text: 'question_6_option_6'),
          QuestionOption(id: '7', text: 'question_6_option_7'),
        ],
      ),
      QuestionModel(
        id: '7',
        title: '',
        questionText: '',
        note: '',
        options: [
          QuestionOption(id: '1', text: 'question_7_option_1'),
          QuestionOption(id: '2', text: 'question_7_option_2'),
          QuestionOption(id: '3', text: 'question_7_option_3'),
          QuestionOption(id: '4', text: 'question_7_option_4'),
          QuestionOption(id: '5', text: 'question_7_option_5'),
          QuestionOption(id: '6', text: 'question_7_option_6'),
        ],
      ),
      QuestionModel(
        id: '8',
        title: '',
        questionText: '',
        note: '',
        options: [
          QuestionOption(id: '1', text: 'question_8_option_1'),
          QuestionOption(id: '2', text: 'question_8_option_2'),
          QuestionOption(id: '3', text: 'question_8_option_3'),
          QuestionOption(id: '4', text: 'question_8_option_4'),
          QuestionOption(id: '5', text: 'question_8_option_5'),
          QuestionOption(id: '6', text: 'question_8_option_6'),
        ],
      ),
      QuestionModel(
        id: '9',
        title: '',
        questionText: '',
        note: '',
        options: [
          QuestionOption(id: '1', text: 'question_9_option_1'),
          QuestionOption(id: '2', text: 'question_9_option_2'),
          QuestionOption(id: '3', text: 'question_9_option_3'),
        ],
      ),
    ];
  });

  QuestionsState buildState(Map<String, Set<String>> answers) {
    return QuestionsState(questions: mockQuestions, allAnswers: answers);
  }

  group('perfumeQuestionsAdapter', () {
    test(
      'should return a PerfumeQuestionsEntity when all questions are answered',
      () {
        final state = buildState({
          '1': {'1'},
          '2': {'2'},
          '3': {'1'},
          '4': {'1'},
          '5': {'1', '3'},
          '6': {'2'},
          '7': {'1'},
          '8': {'1'},
          '9': {'2'},
        });
        final perfumeQuestions = adapter.adapt(state);
        expect(perfumeQuestions, isA<PerfumeQuestionsEntity>());
        expect(perfumeQuestions.gender, 'رجالي');
        expect(perfumeQuestions.ageGroups, ['20-29']);
        expect(perfumeQuestions.usageTime, 'صباحاً ونهارًا');
        expect(perfumeQuestions.season, 'الصيف');
        expect(perfumeQuestions.preferredScents, ['منعش وحمضي', 'زهري']);
        expect(perfumeQuestions.avoidedScents, ['الحمضيات']);
        expect(perfumeQuestions.occasions, ['استخدام يومي للعمل أو الدراسة']);
        expect(perfumeQuestions.styles, ['رياضي وحيوي']);
        expect(perfumeQuestions.projection, 'واضح ومتوازن');
      },
    );

    test(
      'should return a PerfumeQuestionsEntity when Answers of user is empty',
      () {
        final state = buildState({});
        final perfumeQuestions = adapter.adapt(state);
        expect(perfumeQuestions, isA<PerfumeQuestionsEntity>());
      },
    );

    test('should return correct options for questions when answered', () {
      final state = buildState({
        '1': {'1'},
        '2': {'2'},
        '3': {'1'},
        '4': {'1'},
        '5': {'1', '3'},
        '6': {'2'},
        '7': {'1'},
        '8': {'1'},
        '9': {'2'},
      });
      final perfumeQuestions = adapter.adapt(state);
      expect(perfumeQuestions.gender, 'رجالي');
      expect(perfumeQuestions.ageGroups, ['20-29']);
      expect(perfumeQuestions.usageTime, 'صباحاً ونهارًا');
      expect(perfumeQuestions.season, 'الصيف');
      expect(perfumeQuestions.preferredScents, ['منعش وحمضي', 'زهري']);
      expect(perfumeQuestions.avoidedScents, ['الحمضيات']);
      expect(perfumeQuestions.occasions, ['استخدام يومي للعمل أو الدراسة']);
      expect(perfumeQuestions.styles, ['رياضي وحيوي']);
      expect(perfumeQuestions.projection, 'واضح ومتوازن');
    });
  });
}
