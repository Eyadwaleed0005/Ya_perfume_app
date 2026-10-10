import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_perfume/core/constants/app_asset_paths.dart';
import 'package:ya_perfume/features/percentage_selection/data/data_sources/local_percentage_selection_data_source.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

Map<String, dynamic> createPercentagesRecord({
  required int code,
  required String name,
  num sweet = 20,
  num fresh = 20,
  num floral = 15,
  num woody = 15,
  num fruity = 20,
  num whiteFloralJasmin = 10,
}) {
  return {
    'code': code,
    'name': name,
    'sweet': sweet,
    'fresh': fresh,
    'floral': floral,
    'woody': woody,
    'fruity': fruity,
    'whiteFloralJasmin': whiteFloralJasmin,
  };
}

Map<String, dynamic> createDetailsRecord({
  required int code,
  required String name,
  String season = 'الشتاء',
}) {
  return {
    'code': code,
    'name': name,
    'gender': 'رجالي',
    'ageGroups': ['20-29', '30-39'],
    'usageTime': 'مساءً وليلاً',
    'season': season,
    'preferredScents': ['خشبي'],
    'avoidedScents': ['الزهور القوية'],
    'occasions': ['نزهات وزيارات المقاهي'],
    'styles': ['أنيق وراقٍ'],
    'sillage': 'واضح ومتوازن',
  };
}

void main() {
  late MockAssetBundle assetBundle;
  late LocalPercentageSelectionDataSource dataSource;

  void stubAssets({
    List<Map<String, dynamic>> percentages = const [],
    List<Map<String, dynamic>> details = const [],
  }) {
    when(() => assetBundle.loadString(AppDataPaths.perfumePercentages))
        .thenAnswer((_) async => jsonEncode(percentages));

    when(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
        .thenAnswer((_) async => jsonEncode(details));
  }

  Matcher stateErrorWithMessage(String message) {
    return throwsA(
      isA<StateError>().having((error) => error.message, 'message', message),
    );
  }

  setUp(() {
    assetBundle = MockAssetBundle();
    dataSource = LocalPercentageSelectionDataSource(assetBundle: assetBundle);
    stubAssets();
  });

  group('LocalPercentageSelectionDataSource', () {
    test('matches by code despite different names and order', () async {
      stubAssets(
        percentages: [
          createPercentagesRecord(
            code: 101,
            name: 'First Perfume',
            sweet: 30.5,
            woody: 10.5,
            fruity: 14,
          ),
          createPercentagesRecord(code: 102, name: 'Second Perfume'),
        ],
        details: [
          createDetailsRecord(
            code: 102,
            name: 'Different Second Name',
            season: 'الصيف',
          ),
          createDetailsRecord(code: 101, name: 'Different First Name'),
        ],
      );

      final result = await dataSource.getPerfumes();

      expect(result, hasLength(2));

      final first = result[0];
      expect(first.code, 101);
      expect(first.name, 'First Perfume');
      expect(first.percentages.sweet, 30.5);
      expect(first.percentages.fresh, 20.0);
      expect(first.percentages.floral, 15.0);
      expect(first.percentages.woody, 10.5);
      expect(first.percentages.fruity, 14.0);
      expect(first.percentages.whiteFloralJasmin, 10.0);
      expect(first.percentages.total, 100.0);
      expect(first.gender, 'رجالي');
      expect(first.ageGroups, ['20-29', '30-39']);
      expect(first.usageTime, 'مساءً وليلاً');
      expect(first.season, 'الشتاء');
      expect(first.preferredScents, ['خشبي']);
      expect(first.avoidedScents, ['الزهور القوية']);
      expect(first.occasions, ['نزهات وزيارات المقاهي']);
      expect(first.styles, ['أنيق وراقٍ']);
      expect(first.projection, 'واضح ومتوازن');

      expect(result[1].code, 102);
      expect(result[1].name, 'Second Perfume');
      expect(result[1].season, 'الصيف');

      verify(() => assetBundle.loadString(AppDataPaths.perfumePercentages))
          .called(1);
      verify(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .called(1);
      verifyNoMoreInteractions(assetBundle);
    });

    test('returns an empty list for empty assets', () async {
      expect(await dataSource.getPerfumes(), isEmpty);
    });

    for (final assetPath in [
      AppDataPaths.perfumePercentages,
      AppDataPaths.perfumeQuestions,
    ]) {
      test('propagates loading errors from $assetPath', () async {
        final error = FlutterError('Unable to load asset');

        when(() => assetBundle.loadString(assetPath))
            .thenAnswer((_) async => throw error);

        await expectLater(dataSource.getPerfumes(), throwsA(same(error)));
      });

      test('rejects malformed JSON in $assetPath', () async {
        when(() => assetBundle.loadString(assetPath))
            .thenAnswer((_) async => 'invalid json');

        await expectLater(
          dataSource.getPerfumes(),
          throwsA(isA<FormatException>()),
        );
      });
    }

    test('rejects missing details even when the name matches', () async {
      stubAssets(
        percentages: [createPercentagesRecord(code: 101, name: 'Same Name')],
        details: [createDetailsRecord(code: 102, name: 'Same Name')],
      );

      await expectLater(
        dataSource.getPerfumes(),
        stateErrorWithMessage('Perfume details not found for code 101.'),
      );
    });

    test('rejects duplicate detail codes', () async {
      stubAssets(
        details: [
          createDetailsRecord(code: 101, name: 'First'),
          createDetailsRecord(code: 101, name: 'Second'),
        ],
      );

      await expectLater(
        dataSource.getPerfumes(),
        stateErrorWithMessage('Duplicate perfume details for code 101.'),
      );
    });

    test('rejects duplicate percentage codes', () async {
      stubAssets(
        percentages: [
          createPercentagesRecord(code: 101, name: 'First'),
          createPercentagesRecord(code: 101, name: 'Second'),
        ],
        details: [createDetailsRecord(code: 101, name: 'First')],
      );

      await expectLater(
        dataSource.getPerfumes(),
        stateErrorWithMessage('Duplicate perfume percentages for code 101.'),
      );
    });

    test('rejects details without matching percentages', () async {
      stubAssets(
        details: [createDetailsRecord(code: 101, name: 'Missing Percentages')],
      );

      await expectLater(
        dataSource.getPerfumes(),
        stateErrorWithMessage('Perfume percentages not found for codes: 101.'),
      );
    });

    test('allows duplicate names when codes are different', () async {
      stubAssets(
        percentages: [
          createPercentagesRecord(code: 101, name: 'Same Name'),
          createPercentagesRecord(code: 102, name: 'Same Name'),
        ],
        details: [
          createDetailsRecord(code: 101, name: 'Same Name'),
          createDetailsRecord(code: 102, name: 'Same Name', season: 'الصيف'),
        ],
      );

      final result = await dataSource.getPerfumes();

      expect(result.map((perfume) => perfume.code), [101, 102]);
      expect(result[0].season, 'الشتاء');
      expect(result[1].season, 'الصيف');
    });
  });
}
