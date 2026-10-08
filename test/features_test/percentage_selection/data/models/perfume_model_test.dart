import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/core/constants/perfume_percentages_json_keys.dart';
import 'package:ya_perfume/features/percentage_selection/data/models/perfume_model.dart';

void main() {
  group('PerfumeModel.fromJson', () {
    late Map<String, dynamic> detailsJson;

    setUp(() {
      detailsJson = <String, dynamic>{
        PerfumePercentagesJsonKeys.gender: 'رجالي',
        PerfumePercentagesJsonKeys.ageGroups: <String>['20-29', '30-39'],
        PerfumePercentagesJsonKeys.usageTime: 'مساءً وليلاً',
        PerfumePercentagesJsonKeys.season: 'الشتاء',
        PerfumePercentagesJsonKeys.preferredScents: <String>[
          'خشبي',
          'شرقي ودافئ',
        ],
        PerfumePercentagesJsonKeys.avoidedScents: <String>['الزهور القوية'],
        PerfumePercentagesJsonKeys.occasions: <String>['نزهات وزيارات المقاهي'],
        PerfumePercentagesJsonKeys.styles: <String>['أنيق وراقٍ'],
        PerfumePercentagesJsonKeys.projection: 'واضح ومتوازن',
      };
    });

    test('reads code, name, and the four fragrance percentages', () {
      final json = <String, dynamic>{
        PerfumePercentagesJsonKeys.code: 101,
        PerfumePercentagesJsonKeys.name: 'Test Perfume',
        PerfumePercentagesJsonKeys.percentages: <String, dynamic>{
          PerfumePercentagesJsonKeys.sweet: 30.5,
          PerfumePercentagesJsonKeys.fresh: 20.5,
          PerfumePercentagesJsonKeys.floral: 25,
          PerfumePercentagesJsonKeys.woody: 24,
        },
      };

      final model = PerfumeModel.fromJson(json, detailsJson: detailsJson);

      expect(model.code, 101);
      expect(model.name, 'Test Perfume');
      expect(model.percentages.sweet, 30.5);
      expect(model.percentages.fresh, 20.5);
      expect(model.percentages.floral, 25.0);
      expect(model.percentages.woody, 24.0);
    });

    test('uses zero as the default when code is null', () {
      final model = PerfumeModel.fromJson({
        PerfumePercentagesJsonKeys.code: null,
        PerfumePercentagesJsonKeys.name: 'Perfume Without Code',
        PerfumePercentagesJsonKeys.percentages: {
          PerfumePercentagesJsonKeys.sweet: 25,
          PerfumePercentagesJsonKeys.fresh: 25,
          PerfumePercentagesJsonKeys.floral: 25,
          PerfumePercentagesJsonKeys.woody: 25,
        },
      }, detailsJson: detailsJson);

      expect(model.code, 0);
      expect(model.name, 'Perfume Without Code');
    });

    test('converts integer percentages to doubles', () {
      final model = PerfumeModel.fromJson({
        PerfumePercentagesJsonKeys.code: 102,
        PerfumePercentagesJsonKeys.name: 'Integer Percentages',
        PerfumePercentagesJsonKeys.percentages: {
          PerfumePercentagesJsonKeys.sweet: 10,
          PerfumePercentagesJsonKeys.fresh: 20,
          PerfumePercentagesJsonKeys.floral: 30,
          PerfumePercentagesJsonKeys.woody: 40,
        },
      }, detailsJson: detailsJson);

      expect(model.percentages.sweet, isA<double>());
      expect(model.percentages.fresh, isA<double>());
      expect(model.percentages.floral, isA<double>());
      expect(model.percentages.woody, isA<double>());

      expect(model.percentages.sweet, 10.0);
      expect(model.percentages.fresh, 20.0);
      expect(model.percentages.floral, 30.0);
      expect(model.percentages.woody, 40.0);
    });

    test('preserves stored values when their total is below 100', () {
      final model = PerfumeModel.fromJson({
        PerfumePercentagesJsonKeys.code: 103,
        PerfumePercentagesJsonKeys.name: 'Partial Percentages',
        PerfumePercentagesJsonKeys.percentages: {
          PerfumePercentagesJsonKeys.sweet: 15.5,
          PerfumePercentagesJsonKeys.fresh: 12,
          PerfumePercentagesJsonKeys.floral: 10,
          PerfumePercentagesJsonKeys.woody: 8.5,
        },
      }, detailsJson: detailsJson);

      expect(model.percentages.sweet, 15.5);
      expect(model.percentages.fresh, 12.0);
      expect(model.percentages.floral, 10.0);
      expect(model.percentages.woody, 8.5);
      expect(model.percentages.total, 46);
    });

    test('ignores additional fragrance families', () {
      final model = PerfumeModel.fromJson({
        PerfumePercentagesJsonKeys.code: 104,
        PerfumePercentagesJsonKeys.name: 'Additional Families',
        PerfumePercentagesJsonKeys.percentages: {
          PerfumePercentagesJsonKeys.sweet: 10,
          PerfumePercentagesJsonKeys.fresh: 20,
          PerfumePercentagesJsonKeys.floral: 15,
          PerfumePercentagesJsonKeys.woody: 25,
          PerfumePercentagesJsonKeys.fruity: 18,
          PerfumePercentagesJsonKeys.whiteFloralJasmin: 12,
        },
      }, detailsJson: detailsJson);

      expect(model.percentages.sweet, 10.0);
      expect(model.percentages.fresh, 20.0);
      expect(model.percentages.floral, 15.0);
      expect(model.percentages.woody, 25.0);
      expect(model.percentages.total, 70);
    });

    test('reads perfume details from detailsJson', () {
      final model = PerfumeModel.fromJson({
        PerfumePercentagesJsonKeys.code: 105,
        PerfumePercentagesJsonKeys.name: 'Detailed Perfume',
        PerfumePercentagesJsonKeys.percentages: {
          PerfumePercentagesJsonKeys.sweet: 25,
          PerfumePercentagesJsonKeys.fresh: 25,
          PerfumePercentagesJsonKeys.floral: 25,
          PerfumePercentagesJsonKeys.woody: 25,
        },
      }, detailsJson: detailsJson);

      expect(model.gender, 'رجالي');
      expect(model.ageGroups, ['20-29', '30-39']);
      expect(model.usageTime, 'مساءً وليلاً');
      expect(model.season, 'الشتاء');
      expect(model.preferredScents, ['خشبي', 'شرقي ودافئ']);
      expect(model.avoidedScents, ['الزهور القوية']);
      expect(model.occasions, ['نزهات وزيارات المقاهي']);
      expect(model.styles, ['أنيق وراقٍ']);
      expect(model.projection, 'واضح ومتوازن');
    });
  });
}
