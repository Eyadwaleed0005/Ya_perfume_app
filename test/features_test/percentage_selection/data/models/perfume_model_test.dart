import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/percentage_selection/data/models/perfume_model.dart';

void main() {
  group('PerfumeModel.fromJson', () {
    late Map<String, dynamic> detailsJson;
    late Map<String, dynamic> percentagesJson;

    setUp(() {
      detailsJson = {
        'code': 101,
        'name': 'Test Perfume',
        'gender': 'رجالي',
        'ageGroups': ['20-29', '30-39'],
        'usageTime': 'مساءً وليلاً',
        'season': 'الشتاء',
        'preferredScents': ['خشبي', 'شرقي ودافئ'],
        'avoidedScents': ['الزهور القوية'],
        'occasions': ['نزهات وزيارات المقاهي'],
        'styles': ['أنيق وراقٍ'],
        'sillage': 'واضح ومتوازن',
      };

      percentagesJson = {
        'code': 101,
        'name': 'Test Perfume',
        'sweet': 20.5,
        'fresh': 15.5,
        'floral': 20,
        'woody': 24,
        'fruity': 12,
        'whiteFloralJasmin': 8,
      };
    });

    test('reads the flat JSON structure used by the assets', () {
      final model = PerfumeModel.fromJson(
        percentagesJson,
        detailsJson: detailsJson,
      );

      expect(model.code, 101);
      expect(model.name, 'Test Perfume');
      expect(model.percentages.sweet, 20.5);
      expect(model.percentages.fresh, 15.5);
      expect(model.percentages.floral, 20.0);
      expect(model.percentages.woody, 24.0);
      expect(model.percentages.fruity, 12.0);
      expect(model.percentages.whiteFloralJasmin, 8.0);
      expect(model.percentages.total, 100.0);
    });

    test('also supports nested percentages', () {
      final nestedJson = {
        'code': percentagesJson['code'],
        'name': percentagesJson['name'],
        'percentages': {
          for (final entry in percentagesJson.entries)
            if (entry.key != 'code' && entry.key != 'name')
              entry.key: entry.value,
        },
      };

      final model = PerfumeModel.fromJson(nestedJson, detailsJson: detailsJson);

      expect(model.percentages.sweet, 20.5);
      expect(model.percentages.fresh, 15.5);
      expect(model.percentages.floral, 20.0);
      expect(model.percentages.woody, 24.0);
      expect(model.percentages.fruity, 12.0);
      expect(model.percentages.whiteFloralJasmin, 8.0);
    });

    test('rejects null or missing codes', () {
      final nullCodeJson = {...percentagesJson, 'code': null};
      final missingCodeJson = {...percentagesJson}..remove('code');

      for (final json in [nullCodeJson, missingCodeJson]) {
        expect(
          () => PerfumeModel.fromJson(json, detailsJson: detailsJson),
          throwsA(isA<TypeError>()),
        );
      }
    });

    test('converts all integer percentages to doubles', () {
      percentagesJson.addAll({
        'sweet': 10,
        'fresh': 20,
        'floral': 15,
        'woody': 25,
        'fruity': 18,
        'whiteFloralJasmin': 12,
      });

      final model = PerfumeModel.fromJson(
        percentagesJson,
        detailsJson: detailsJson,
      );

      expect([
        model.percentages.sweet,
        model.percentages.fresh,
        model.percentages.floral,
        model.percentages.woody,
        model.percentages.fruity,
        model.percentages.whiteFloralJasmin,
      ], everyElement(isA<double>()));
      expect(model.percentages.total, 100.0);
    });

    test('preserves percentages whose total is below 100', () {
      percentagesJson.addAll({
        'sweet': 15.5,
        'fresh': 12,
        'floral': 10,
        'woody': 8.5,
        'fruity': 4,
        'whiteFloralJasmin': 2,
      });

      final model = PerfumeModel.fromJson(
        percentagesJson,
        detailsJson: detailsJson,
      );

      expect(model.percentages.sweet, 15.5);
      expect(model.percentages.fresh, 12.0);
      expect(model.percentages.floral, 10.0);
      expect(model.percentages.woody, 8.5);
      expect(model.percentages.fruity, 4.0);
      expect(model.percentages.whiteFloralJasmin, 2.0);
      expect(model.percentages.total, 52.0);
    });

    test('reads details and maps sillage to projection', () {
      final model = PerfumeModel.fromJson(
        percentagesJson,
        detailsJson: detailsJson,
      );

      expect(model.gender, 'رجالي');
      expect(model.ageGroups, ['20-29', '30-39']);
      expect(model.usageTime, 'مساءً وليلاً');
      expect(model.season, 'الشتاء');
      expect(model.preferredScents, ['خشبي', 'شرقي ودافئ']);
      expect(model.avoidedScents, ['الزهور القوية']);
      expect(model.occasions, ['نزهات وزيارات المقاهي']);
      expect(model.styles, ['أنيق وراقٍ']);
      expect(model.projection, 'واضح ومتوازن');
      expect(model.toResultEntity().projection, 'واضح ومتوازن');
    });

    test('does not silently replace a missing percentage with zero', () {
      percentagesJson.remove('fruity');

      expect(
        () => PerfumeModel.fromJson(percentagesJson, detailsJson: detailsJson),
        throwsA(isA<TypeError>()),
      );
    });

    test('does not silently replace missing sillage', () {
      detailsJson.remove('sillage');

      expect(
        () => PerfumeModel.fromJson(percentagesJson, detailsJson: detailsJson),
        throwsA(isA<TypeError>()),
      );
    });

    test('protects detail lists from modification', () {
      final model = PerfumeModel.fromJson(
        percentagesJson,
        detailsJson: detailsJson,
      );

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
