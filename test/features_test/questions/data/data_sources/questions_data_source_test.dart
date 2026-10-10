import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_perfume/core/constants/app_asset_paths.dart';
import 'package:ya_perfume/features/questions/data/data_sources/local_questions_data_source.dart';
import 'package:ya_perfume/features/questions/data/models/perfume_questions_model.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  late MockAssetBundle assetBundle;
  late LocalQuestionsDataSource dataSource;

  setUp(() {
    assetBundle = MockAssetBundle();
    dataSource = LocalQuestionsDataSource(assetBundle: assetBundle);
  });

  group('LocalQuestionsDataSource', () {
    test('loads the configured asset and converts its records', () async {
      final records = <Map<String, dynamic>>[
        {
          'code': 200,
          'name': 'First Perfume',
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
        },
        {
          'code': 201,
          'name': 'Second Perfume',
          'gender': 'نسائي',
          'ageGroups': ['أقل من 20', '20-29'],
          'usageTime': 'صباحاً ونهارًا',
          'season': 'الصيف',
          'preferredScents': ['زهري', 'فاكهي'],
          'avoidedScents': ['الزهور القوية', 'الفانيليا والحلاوة القوية'],
          'occasions': [
            'استخدام يومي للعمل أو الدراسة',
            'نزهات وزيارات المقاهي',
            'موعد رومانسي أو عشاء هادئ',
          ],
          'styles': ['جرئ ومختلف', 'أنيق وراقٍ'],
          'sillage': 'قوي ولافت',
        },
      ];

      when(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .thenAnswer((_) async => jsonEncode(records));

      final result = await dataSource.fetchPerfumes();

      expect(result, hasLength(2));
      expect(result, everyElement(isA<PerfumeQuestionsModel>()));

      for (var i = 0; i < records.length; i++) {
        final expected = records[i];
        final model = result[i];

        expect(model.code, expected['code']);
        expect(model.name, expected['name']);
        expect(model.gender, expected['gender']);
        expect(model.ageGroups, expected['ageGroups']);
        expect(model.usageTime, expected['usageTime']);
        expect(model.season, expected['season']);
        expect(model.preferredScents, expected['preferredScents']);
        expect(model.avoidedScents, expected['avoidedScents']);
        expect(model.occasions, expected['occasions']);
        expect(model.styles, expected['styles']);
        expect(model.projection, expected['sillage']);
        expect(model.numOfAcceptance, 0);
      }

      verify(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .called(1);
      verifyNoMoreInteractions(assetBundle);
    });

    test('returns an empty list for an empty JSON array', () async {
      when(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .thenAnswer((_) async => '[]');

      final result = await dataSource.fetchPerfumes();

      expect(result, isEmpty);
    });

    test('propagates the original asset loading exception', () async {
      final error = Exception('Unable to load asset');

      when(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .thenAnswer((_) async => throw error);

      await expectLater(dataSource.fetchPerfumes(), throwsA(same(error)));
    });

    test('throws FormatException for malformed JSON', () async {
      when(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .thenAnswer((_) async => 'invalid json');

      await expectLater(
        dataSource.fetchPerfumes(),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
