import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_perfume/core/constants/app_asset_paths.dart';
import 'package:ya_perfume/features/percentage_selection/data/data_sources/local_percentage_selection_data_source.dart';
import 'package:ya_perfume/features/percentage_selection/data/models/perfume_model.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  late MockAssetBundle assetBundle;
  late LocalPercentageSelectionDataSource dataSource;

  setUp(() {
    assetBundle = MockAssetBundle();

    dataSource = LocalPercentageSelectionDataSource(
      assetBundle: assetBundle,
    );
  });

  group('LocalPercentageSelectionDataSource', () {
    test('loads the configured asset and converts its records', () async {
      final jsonString = jsonEncode([
        {
          'code': 101,
          'name': 'First Perfume',
          'percentages': {
            'Sweet': 30.5,
            'Fresh': 20,
            'Floral': 15,
            'Woody': 10.5,
            'Fruity': 24,
          },
        },
        {
          'code': null,
          'name': 'Second Perfume',
          'percentages': {
            'Sweet': 10,
            'Fresh': 40,
            'Floral': 20,
            'Woody': 30,
          },
        },
      ]);

      when(
        () => assetBundle.loadString(AppDataPaths.perfumePercentages),
      ).thenAnswer((_) async => jsonString);

      final result = await dataSource.getPerfumes();

      expect(result, hasLength(2));
      expect(result, everyElement(isA<PerfumeModel>()));

      expect(result[0].code, 101);
      expect(result[0].name, 'First Perfume');
      expect(result[0].percentages.sweet, 30.5);
      expect(result[0].percentages.fresh, 20.0);
      expect(result[0].percentages.floral, 15.0);
      expect(result[0].percentages.woody, 10.5);
      expect(result[0].percentages.total, 76);

      expect(result[1].code, isNull);
      expect(result[1].name, 'Second Perfume');
      expect(result[1].percentages.sweet, 10.0);
      expect(result[1].percentages.fresh, 40.0);
      expect(result[1].percentages.floral, 20.0);
      expect(result[1].percentages.woody, 30.0);

      verify(
        () => assetBundle.loadString(AppDataPaths.perfumePercentages),
      ).called(1);
      verifyNoMoreInteractions(assetBundle);
    });

    test('returns an empty list for an empty JSON array', () async {
      when(
        () => assetBundle.loadString(AppDataPaths.perfumePercentages),
      ).thenAnswer((_) async => '[]');

      final result = await dataSource.getPerfumes();

      expect(result, isEmpty);
    });

    test('propagates an asset loading exception', () async {
      final error = FlutterError('Unable to load asset');

      when(
        () => assetBundle.loadString(AppDataPaths.perfumePercentages),
      ).thenAnswer((_) async => throw error);

      await expectLater(
        dataSource.getPerfumes(),
        throwsA(same(error)),
      );
    });

    test('throws FormatException for malformed JSON', () async {
      when(
        () => assetBundle.loadString(AppDataPaths.perfumePercentages),
      ).thenAnswer((_) async => 'invalid json');

      await expectLater(
        dataSource.getPerfumes(),
        throwsA(isA<FormatException>()),
      );
    });
  });
}