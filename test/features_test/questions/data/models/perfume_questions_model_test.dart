import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/questions/data/models/perfume_questions_model.dart';

void main() {
  group('PerfumeQuestionsModel', () {
    late Map<String, dynamic> json;

    setUp(() {
      json = {
        'code': 200,
        'name': 'Test Perfume',
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
        'sillage': 'واضح ومتوازن',
      };
    });

    test('reads all fields and maps sillage to projection', () {
      final model = PerfumeQuestionsModel.fromJson(json);

      expect(model.code, 200);
      expect(model.name, 'Test Perfume');
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

    test('starts numOfAcceptance at zero', () {
      final model = PerfumeQuestionsModel.fromJson(json);

      expect(model.numOfAcceptance, 0);
    });

    test('rejects a null code', () {
      json['code'] = null;

      expect(
        () => PerfumeQuestionsModel.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });

    test('rejects a missing code', () {
      json.remove('code');

      expect(
        () => PerfumeQuestionsModel.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });

    test('rejects missing sillage', () {
      json.remove('sillage');

      expect(
        () => PerfumeQuestionsModel.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });

    test('writes sillage and the acceptance count to JSON', () {
      final model = PerfumeQuestionsModel.fromJson(json);
      final result = model.toJson();

      expect(result, {...json, 'numOfAcceptance': 0});
      expect(result.containsKey('projection'), isFalse);
    });

    test('protects detail lists from modification', () {
      final model = PerfumeQuestionsModel.fromJson(json);

      for (final values in [
        model.ageGroups,
        model.preferredScents,
        model.avoidedScents,
        model.occasions,
        model.styles,
      ]) {
        expect(() => values.add('New value'), throwsA(isA<UnsupportedError>()));
      }
    });
  });
}
