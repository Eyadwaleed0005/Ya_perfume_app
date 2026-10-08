import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/questions/data/models/perfume_questions_model.dart';

void main() {
  group('PerfumeQuestionsModel', () {
    test('reads and converts json file correctly', () {
      final json = <String, dynamic>{
        'code': 1,
        'name': 'sexy boy',
        'gender': 'نسائي',
        'ageGroups': ['20-29', '30-39'],
        'usageTime': 'صباحاً ونهارًا',
        'season': 'طول العام',
        'preferredScents': ['زهري', 'نظيف ومسكي وبروائح البودرة'],
        'avoidedScents': ['الزهور القوية', 'المسك وروائح البودرة'],
        'occasions': [
          'استخدام يومي للعمل أو الدراسة',
          'موعد رومانسي أو عشاء هادئ',
        ],
        'styles': ['أنيق وراقٍ', 'ناعم ورومانسي'],
        'projection': 'واضح ومتوازن',
      };

      final model = PerfumeQuestionsModel.fromJson(json);

      expect(model.code, 1);
      expect(model.name, 'sexy boy');
      expect(model.gender, 'نسائي');
      expect(model.ageGroups, ['20-29', '30-39']);
      expect(model.usageTime, 'صباحاً ونهارًا');
      expect(model.season, 'طول العام');
      expect(model.preferredScents, ['زهري', 'نظيف ومسكي وبروائح البودرة']);
      expect(model.avoidedScents, ['الزهور القوية', 'المسك وروائح البودرة']);
      expect(model.occasions, [
        'استخدام يومي للعمل أو الدراسة',
        'موعد رومانسي أو عشاء هادئ',
      ]);
      expect(model.styles, ['أنيق وراقٍ', 'ناعم ورومانسي']);
      expect(model.projection, 'واضح ومتوازن');
    });

    test('uses zero as the default when code is null', () {
      final model = PerfumeQuestionsModel.fromJson({
        'code': null,
        'name': 'sexy boy',
        'gender': 'نسائي',
        'ageGroups': ['20-29', '30-39'],
        'usageTime': 'صباحاً ونهارًا',
        'season': 'طول العام',
        'preferredScents': ['زهري', 'نظيف ومسكي وبروائح البودرة'],
        'avoidedScents': ['الزهور القوية', 'المسك وروائح البودرة'],
        'occasions': [
          'استخدام يومي للعمل أو الدراسة',
          'موعد رومانسي أو عشاء هادئ',
        ],
        'styles': ['أنيق وراقٍ', 'ناعم ورومانسي'],
        'projection': 'واضح ومتوازن',
      });

      expect(model.code, 0);
    });
  });

  test('check numOfAcceptance is zero initially', () {
    final model = PerfumeQuestionsModel.fromJson({
      'code': null,
      'name': 'sexy boy',
      'numOfAcceptance': 0,
      'gender': 'نسائي',
      'ageGroups': ['20-29', '30-39'],
      'usageTime': 'صباحاً ونهارًا',
      'season': 'طول العام',
      'preferredScents': ['زهري', 'نظيف ومسكي وبروائح البودرة'],
      'avoidedScents': ['الزهور القوية', 'المسك وروائح البودرة'],
      'occasions': [
        'استخدام يومي للعمل أو الدراسة',
        'موعد رومانسي أو عشاء هادئ',
      ],
      'styles': ['أنيق وراقٍ', 'ناعم ورومانسي'],
      'projection': 'واضح ومتوازن',
    });

    expect(model.numOfAcceptance, 0);
  });
}