import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_perfume/core/constants/app_asset_paths.dart';
import 'package:ya_perfume/core/constants/perfume_percentages_json_keys.dart';
import 'package:ya_perfume/features/percentage_selection/data/data_sources/local_percentage_selection_data_source.dart';
import 'package:ya_perfume/features/percentage_selection/data/models/perfume_model.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

Map<String, dynamic> createPercentagesRecord({
  required String name,
  int? code,
  num sweet = 25,
  num fresh = 25,
  num floral = 25,
  num woody = 25,
}) {
  return {
    PerfumePercentagesJsonKeys.code: code,
    PerfumePercentagesJsonKeys.name: name,
    PerfumePercentagesJsonKeys.percentages: {
      PerfumePercentagesJsonKeys.sweet: sweet,
      PerfumePercentagesJsonKeys.fresh: fresh,
      PerfumePercentagesJsonKeys.floral: floral,
      PerfumePercentagesJsonKeys.woody: woody,
    },
  };
}

Map<String, dynamic> createDetailsRecord({
  required String name,
  String season = 'الشتاء',
}) {
  return {
    PerfumePercentagesJsonKeys.code: null,
    PerfumePercentagesJsonKeys.name: name,
    PerfumePercentagesJsonKeys.gender: 'رجالي',
    PerfumePercentagesJsonKeys.ageGroups: ['20-29', '30-39'],
    PerfumePercentagesJsonKeys.usageTime: 'مساءً وليلاً',
    PerfumePercentagesJsonKeys.season: season,
    PerfumePercentagesJsonKeys.preferredScents: ['خشبي'],
    PerfumePercentagesJsonKeys.avoidedScents: ['الزهور القوية'],
    PerfumePercentagesJsonKeys.occasions: ['نزهات وزيارات المقاهي'],
    PerfumePercentagesJsonKeys.styles: ['أنيق وراقٍ'],
    PerfumePercentagesJsonKeys.projection: 'واضح ومتوازن',
  };
}

void main() {
  late MockAssetBundle assetBundle;
  late LocalPercentageSelectionDataSource dataSource;

  setUp(() {
    assetBundle = MockAssetBundle();

    dataSource = LocalPercentageSelectionDataSource(assetBundle: assetBundle);

    when(() => assetBundle.loadString(AppDataPaths.perfumePercentages))
        .thenAnswer((_) async => '[]');

    when(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
        .thenAnswer((_) async => '[]');
  });

  group('LocalPercentageSelectionDataSource', () {
    test('loads both assets and matches details by name', () async {
      final firstRecord = createPercentagesRecord(
        code: 101,
        name: 'First Perfume',
        sweet: 30.5,
        fresh: 20,
        floral: 15,
        woody: 10.5,
      );

      final percentages =
          firstRecord[PerfumePercentagesJsonKeys.percentages]
              as Map<String, dynamic>;

      percentages[PerfumePercentagesJsonKeys.fruity] = 24;

      final percentagesJson = jsonEncode([
        firstRecord,
        createPercentagesRecord(
          name: 'Second Perfume',
          sweet: 10,
          fresh: 40,
          floral: 20,
          woody: 30,
        ),
      ]);

      // Different order verifies that matching uses names, not positions.
      final detailsJson = jsonEncode([
        createDetailsRecord(name: 'Second Perfume', season: 'الصيف'),
        createDetailsRecord(name: 'First Perfume', season: 'الشتاء'),
      ]);

      when(() => assetBundle.loadString(AppDataPaths.perfumePercentages))
          .thenAnswer((_) async => percentagesJson);

      when(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .thenAnswer((_) async => detailsJson);

      final result = await dataSource.getPerfumes();

      expect(result, hasLength(2));
      expect(result, everyElement(isA<PerfumeModel>()));

      final first = result[0];

      expect(first.code, 101);
      expect(first.name, 'First Perfume');
      expect(first.percentages.sweet, 30.5);
      expect(first.percentages.fresh, 20.0);
      expect(first.percentages.floral, 15.0);
      expect(first.percentages.woody, 10.5);
      expect(first.percentages.total, 76);

      expect(first.gender, 'رجالي');
      expect(first.ageGroups, ['20-29', '30-39']);
      expect(first.usageTime, 'مساءً وليلاً');
      expect(first.season, 'الشتاء');
      expect(first.preferredScents, ['خشبي']);
      expect(first.avoidedScents, ['الزهور القوية']);
      expect(first.occasions, ['نزهات وزيارات المقاهي']);
      expect(first.styles, ['أنيق وراقٍ']);
      expect(first.projection, 'واضح ومتوازن');

      final second = result[1];

      expect(second.code, 0);
      expect(second.name, 'Second Perfume');
      expect(second.percentages.sweet, 10.0);
      expect(second.percentages.fresh, 40.0);
      expect(second.percentages.floral, 20.0);
      expect(second.percentages.woody, 30.0);
      expect(second.season, 'الصيف');

      verify(() => assetBundle.loadString(AppDataPaths.perfumePercentages))
          .called(1);

      verify(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .called(1);

      verifyNoMoreInteractions(assetBundle);
    });

    test('returns an empty list for empty JSON arrays', () async {
      final result = await dataSource.getPerfumes();

      expect(result, isEmpty);
    });

    for (final assetPath in [
      AppDataPaths.perfumePercentages,
      AppDataPaths.perfumeQuestions,
    ]) {
      test('propagates an asset loading exception from $assetPath', () async {
        final error = FlutterError('Unable to load asset');

        when(() => assetBundle.loadString(assetPath))
            .thenAnswer((_) async => throw error);

        await expectLater(dataSource.getPerfumes(), throwsA(same(error)));
      });

      test('throws FormatException for malformed JSON in $assetPath', () async {
        when(() => assetBundle.loadString(assetPath))
            .thenAnswer((_) async => 'invalid json');

        await expectLater(
          dataSource.getPerfumes(),
          throwsA(isA<FormatException>()),
        );
      });
    }

    test('throws StateError when perfume details are missing', () async {
      when(() => assetBundle.loadString(AppDataPaths.perfumePercentages))
          .thenAnswer(
            (_) async =>
                jsonEncode([createPercentagesRecord(name: 'Missing Perfume')]),
          );

      await expectLater(
        dataSource.getPerfumes(),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            'Perfume details not found for "Missing Perfume".',
          ),
        ),
      );
    });

    test('throws StateError when detail names are duplicated', () async {
      when(() => assetBundle.loadString(AppDataPaths.perfumeQuestions))
          .thenAnswer(
            (_) async => jsonEncode([
              createDetailsRecord(name: 'Duplicate Perfume'),
              createDetailsRecord(name: 'Duplicate Perfume'),
            ]),
          );

      await expectLater(
        dataSource.getPerfumes(),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            'Duplicate perfume details for "Duplicate Perfume".',
          ),
        ),
      );
    });
  });
}
