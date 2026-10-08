import 'package:ya_perfume/features/questions/data/models/perfume_questions_model.dart';
import 'package:ya_perfume/features/questions/domain/entities/perfume_questions_entity.dart';
import 'package:ya_perfume/features/questions/presentation/cubit/questions_cubit.dart';

/*
I used the Adapter Design Pattern to solve a data-structure compatibility problem.
The questionnaire stores answers as question IDs and selected option IDs,
while the GetPerfumesUseCase expects a PerfumeQuestionsEntity.
The PerfumeQuestionsAdapter collects the required data from the questionnaire state,
maps the selected options to their dataset values, and builds the required entity.
This keeps the conversion logic separated from the Cubit and prevents the UseCase
from depending on the questionnaire's internal structure.
*/
class PerfumeQuestionsAdapter {
  PerfumeQuestionsEntity adapt(QuestionsState state) {
    return PerfumeQuestionsModel(
      code: null, // filled in use case
      name: 'User Preferences', // filled in use case
      numOfAcceptance: 0, // filled in use case
      gender: _getSelectedOptionText(state, '1'),
      ageGroups: _getSelectedOptionTexts(state, '2'),
      usageTime: _getSelectedOptionText(state, '3'),
      season: _getSelectedOptionText(state, '4'),
      preferredScents: _getSelectedOptionTexts(state, '5'),
      avoidedScents: _getSelectedOptionTexts(
        state,
        '6',
        defaultValue: ['تم التخطي'],
      ),
      occasions: _getSelectedOptionTexts(state, '7'),
      styles: _getSelectedOptionTexts(state, '8'),
      projection: _getSelectedOptionText(state, '9'),
    );
  }

  List<String> _getSelectedOptionTexts(
    QuestionsState state,
    String questionId, {
    List<String> defaultValue = const ['none'],
  }) {
    final selectedOptionIds = state.allAnswers[questionId];
    if (selectedOptionIds == null || selectedOptionIds.isEmpty) {
      return defaultValue;
    }

    final question = state.questions
        .where((q) => q.id == questionId)
        .firstOrNull;
    if (question == null) return defaultValue;

    return question.options
        .where((opt) => selectedOptionIds.contains(opt.id))
        .map((opt) => _optionToDatasetValue[opt.text] ?? opt.text)
        .toList();
  }

  String _getSelectedOptionText(
    QuestionsState state,
    String questionId, {
    String defaultValue = '',
  }) {
    final texts = _getSelectedOptionTexts(state, questionId);
    return texts.isNotEmpty ? texts.first : defaultValue;
  }

  static const Map<String, String> _optionToDatasetValue = {
    // Q1: Gender
    'question_1_option_1': 'رجالي',
    'question_1_option_2': 'نسائي',
    'question_1_option_3': 'للجنسين',
    // Q2: Age Groups
    'question_2_option_1': 'أقل من 20',
    'question_2_option_2': '20-29',
    'question_2_option_3': '30-39',
    'question_2_option_4': '40-49',
    'question_2_option_5': '+50',
    // Q3: Usage Time
    'question_3_option_1': "صباحاً ونهارًا",
    'question_3_option_2': "مساءً وليلاً",
    'question_3_option_3': 'في كلا الوقتين',
    // Q4: Season
    'question_4_option_1': 'الصيف',
    'question_4_option_2': 'الشتاء',
    'question_4_option_3': "طول العام",
    // Q5: Preferred Scents
    'question_5_option_1': 'منعش وحمضي',
    'question_5_option_2': 'نظيف ومسكي وبروائح البودرة',
    'question_5_option_3': 'زهري',
    'question_5_option_4': 'فاكهي',
    'question_5_option_5': 'حلو ومستوحى من الحلوى',
    'question_5_option_6': 'خشبي',
    'question_5_option_7': 'شرقي ودافئ',
    'question_5_option_8': 'عود ودخان وجلد',
    // Q6: Avoided Scents
    'question_6_option_1': 'الفانيليا والحلاوة القوية',
    'question_6_option_2': 'الحمضيات',
    'question_6_option_3': 'الزهور القوية',
    'question_6_option_4': 'المسك وروائح البودرة',
    'question_6_option_5': 'العود والبخور',
    'question_6_option_6': 'التوابل',
    'question_6_option_7': 'التبغ والجلد والدخان',
    // Q7: Occasions
    'question_7_option_1': 'استخدام يومي للعمل أو الدراسة',
    'question_7_option_2': 'نزهات وزيارات المقاهي',
    'question_7_option_3': 'رياضة وأنشطة خارجية',
    'question_7_option_4': 'موعد رومانسي أو عشاء هادئ',
    'question_7_option_5': 'حفل زفاف أو مناسبة رسمية',
    'question_7_option_6': 'حفلة أو سهرة ليلية',
    // Q8: Personal Style
    'question_8_option_1': 'رياضي وحيوي',
    'question_8_option_2': 'عملي ومريح',
    'question_8_option_3': 'كلاسيكي ورسمي',
    'question_8_option_4': 'أنيق وراقٍ',
    'question_8_option_5': "جرئ ومختلف",
    'question_8_option_6': 'ناعم ورومانسي',
    // Q9: Projection
    'question_9_option_1': 'هادئ وقريب منك',
    'question_9_option_2': 'واضح ومتوازن',
    'question_9_option_3': 'قوي ولافت',
  };
}
