import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/percentage_selection/data/models/perfume_model.dart';

void main() {
  group('PerfumeModel.fromJson', () {
    test('reads code, name, and the four fragrance percentages', () {
      final json = <String, dynamic>{
        'code': 101,
        'name': 'Test Perfume',
        'percentages': <String, dynamic>{
          'Sweet': 30.5,
          'Fresh': 20.5,
          'Floral': 25,
          'Woody': 24,
        },
      };

      final model = PerfumeModel.fromJson(json);

      expect(model.code, 101);
      expect(model.name, 'Test Perfume');
      expect(model.percentages.sweet, 30.5);
      expect(model.percentages.fresh, 20.5);
      expect(model.percentages.floral, 25.0);
      expect(model.percentages.woody, 24.0);
    });

    test('accepts a null code', () {
      final model = PerfumeModel.fromJson({
        'code': null,
        'name': 'Perfume Without Code',
        'percentages': {
          'Sweet': 25,
          'Fresh': 25,
          'Floral': 25,
          'Woody': 25,
        },
      });

      expect(model.code, isNull);
      expect(model.name, 'Perfume Without Code');
    });

    test('converts integer percentages to doubles', () {
      final model = PerfumeModel.fromJson({
        'code': 102,
        'name': 'Integer Percentages',
        'percentages': {
          'Sweet': 10,
          'Fresh': 20,
          'Floral': 30,
          'Woody': 40,
        },
      });

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
        'code': 103,
        'name': 'Partial Percentages',
        'percentages': {
          'Sweet': 15.5,
          'Fresh': 12,
          'Floral': 10,
          'Woody': 8.5,
        },
      });

      expect(model.percentages.sweet, 15.5);
      expect(model.percentages.fresh, 12.0);
      expect(model.percentages.floral, 10.0);
      expect(model.percentages.woody, 8.5);
      expect(model.percentages.total, 46);
    });

    test('ignores additional fragrance families', () {
      final model = PerfumeModel.fromJson({
        'code': 104,
        'name': 'Additional Families',
        'percentages': {
          'Sweet': 10,
          'Fresh': 20,
          'Floral': 15,
          'Woody': 25,
          'Fruity': 18,
          'White Floral/Jasmin': 12,
        },
      });

      expect(model.percentages.sweet, 10.0);
      expect(model.percentages.fresh, 20.0);
      expect(model.percentages.floral, 15.0);
      expect(model.percentages.woody, 25.0);
      expect(model.percentages.total, 70);
    });
  });
}