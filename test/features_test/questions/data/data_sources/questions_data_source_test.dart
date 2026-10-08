import 'dart:convert';

import 'package:flutter/material.dart';
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
      final jsonString = jsonEncode([
        {
          'code': 1,
          'name': 'sexy boy',
          "gender": "نسائي",
          "ageGroups": ["20-29", "30-39"],
          "usageTime": "صباحاً ونهارًا",
          "season": "طول العام",
          "preferredScents": ["زهري", "نظيف ومسكي وبروائح البودرة"],
          "avoidedScents": ["الزهور القوية", "المسك وروائح البودرة"],
          "occasions": [
            "استخدام يومي للعمل أو الدراسة",
            "موعد رومانسي أو عشاء هادئ",
          ],
          "styles": ["أنيق وراقٍ", "ناعم ورومانسي"],
          "projection": "واضح ومتوازن",
        },
        {
          'code': 2,
          'name': 'sweet girl',
          "gender": "نسائي",
          "ageGroups": ["أقل من 20", "20-29"],
          "usageTime": "صباحاً ونهارًا",
          "season": "الصيف",
          "preferredScents": ["زهري", "فاكهي"],
          "avoidedScents": ["الزهور القوية", "الفانيليا والحلاوة القوية"],
          "occasions": [
            "استخدام يومي للعمل أو الدراسة",
            "نزهات وزيارات المقاهي",
            "موعد رومانسي أو عشاء هادئ",
          ],
          "styles": ["جرئ ومختلف", "أنيق وراقٍ"],
          "projection": "قوي ولافت",
        },
      ]);

      when(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .thenAnswer((_) async => jsonString);

      final result = await dataSource.fetchPerfumes();

      expect(result, hasLength(2));
      expect(result, everyElement(isA<PerfumeQuestionsModel>()));

      expect(result[0].code, 1);
      expect(result[0].name, 'sexy boy');
      expect(result[0].gender, 'نسائي');
      expect(result[0].ageGroups, ['20-29', '30-39']);
      expect(result[0].usageTime, 'صباحاً ونهارًا');
      expect(result[0].season, 'طول العام');
      expect(result[0].preferredScents, ['زهري', 'نظيف ومسكي وبروائح البودرة']);
      expect(result[0].avoidedScents, [
        'الزهور القوية',
        'المسك وروائح البودرة',
      ]);
      expect(result[0].occasions, [
        'استخدام يومي للعمل أو الدراسة',
        'موعد رومانسي أو عشاء هادئ',
      ]);
      expect(result[0].styles, ['أنيق وراقٍ', 'ناعم ورومانسي']);
      expect(result[0].projection, 'واضح ومتوازن');

      expect(result[1].code, 2);
      expect(result[1].name, 'sweet girl');
      expect(result[1].gender, 'نسائي');
      expect(result[1].ageGroups, ['أقل من 20', '20-29']);
      expect(result[1].usageTime, 'صباحاً ونهارًا');
      expect(result[1].season, 'الصيف');
      expect(result[1].preferredScents, ['زهري', 'فاكهي']);
      expect(result[1].avoidedScents, [
        'الزهور القوية',
        'الفانيليا والحلاوة القوية',
      ]);
      expect(result[1].occasions, [
        'استخدام يومي للعمل أو الدراسة',
        'نزهات وزيارات المقاهي',
        'موعد رومانسي أو عشاء هادئ',
      ]);
      expect(result[1].styles, ['جرئ ومختلف', 'أنيق وراقٍ']);
      expect(result[1].projection, 'قوي ولافت');

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

    test('propagates an asset loading exception', () async {
      final error = Exception('Unable to load asset');

      when(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .thenAnswer((_) async => throw error);

      await expectLater(dataSource.fetchPerfumes(), throwsA(isA<Exception>()));
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
