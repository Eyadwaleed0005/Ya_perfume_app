import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/fragrance_percentages.dart';

void main() {
  group('FragrancePercentages', () {
    group('total', () {
      test('adds the four percentages', () {
        const percentages = FragrancePercentages(
          sweet: 10,
          fresh: 20,
          floral: 30,
          woody: 15,
        );

        expect(percentages.total, 75);
      });
    });

    group('isValidSelection', () {
      test('accepts percentages totaling 100', () {
        const percentages = FragrancePercentages(
          sweet: 25,
          fresh: 25,
          floral: 25,
          woody: 25,
        );

        expect(percentages.isValidSelection, isTrue);
      });

      test('accepts one family at 100 and the others at zero', () {
        const percentages = FragrancePercentages(
          sweet: 100,
          fresh: 0,
          floral: 0,
          woody: 0,
        );

        expect(percentages.isValidSelection, isTrue);
      });

      test('accepts decimal percentages totaling 100', () {
        const percentages = FragrancePercentages(
          sweet: 25.5,
          fresh: 24.5,
          floral: 30.2,
          woody: 19.8,
        );

        expect(percentages.isValidSelection, isTrue);
      });

      test('accepts a small floating-point difference', () {
        const percentages = FragrancePercentages(
          sweet: 25,
          fresh: 25,
          floral: 25,
          woody: 24.9995,
        );

        expect(percentages.isValidSelection, isTrue);
      });

      test('rejects a total below 100', () {
        const percentages = FragrancePercentages(
          sweet: 20,
          fresh: 20,
          floral: 20,
          woody: 20,
        );

        expect(percentages.isValidSelection, isFalse);
      });

      test('rejects a total above 100', () {
        const percentages = FragrancePercentages(
          sweet: 30,
          fresh: 30,
          floral: 30,
          woody: 30,
        );

        expect(percentages.isValidSelection, isFalse);
      });

      test('rejects a total outside the tolerance', () {
        const percentages = FragrancePercentages(
          sweet: 25,
          fresh: 25,
          floral: 25,
          woody: 24.998,
        );

        expect(percentages.isValidSelection, isFalse);
      });

      test('rejects negative values even when the total is 100', () {
        const percentages = FragrancePercentages(
          sweet: -5,
          fresh: 35,
          floral: 35,
          woody: 35,
        );

        expect(percentages.total, 100);
        expect(percentages.isValidSelection, isFalse);
      });

      test('rejects values above 100 even when the total is 100', () {
        const percentages = FragrancePercentages(
          sweet: 105,
          fresh: -5,
          floral: 0,
          woody: 0,
        );

        expect(percentages.total, 100);
        expect(percentages.isValidSelection, isFalse);
      });

      for (final invalidValue in [
        double.nan,
        double.infinity,
        double.negativeInfinity,
      ]) {
        for (var index = 0; index < 4; index++) {
          test('rejects $invalidValue in family $index', () {
            final values = [25.0, 25.0, 25.0, 25.0];
            values[index] = invalidValue;

            final percentages = FragrancePercentages(
              sweet: values[0],
              fresh: values[1],
              floral: values[2],
              woody: values[3],
            );

            expect(percentages.isValidSelection, isFalse);
          });
        }
      }
    });

    group('differenceFrom', () {
      test('returns zero for identical percentages', () {
        const percentages = FragrancePercentages(
          sweet: 25,
          fresh: 25,
          floral: 25,
          woody: 25,
        );

        expect(percentages.differenceFrom(percentages), 0);
      });

      test('adds absolute differences across all four families', () {
        const selection = FragrancePercentages(
          sweet: 40,
          fresh: 30,
          floral: 20,
          woody: 10,
        );

        const perfume = FragrancePercentages(
          sweet: 20,
          fresh: 40,
          floral: 10,
          woody: 30,
        );

        expect(selection.differenceFrom(perfume), 60);
        expect(perfume.differenceFrom(selection), 60);
      });

      test('compares perfume data whose total is below 100', () {
        const selection = FragrancePercentages(
          sweet: 25,
          fresh: 25,
          floral: 25,
          woody: 25,
        );

        const perfume = FragrancePercentages(
          sweet: 20,
          fresh: 15,
          floral: 10,
          woody: 5,
        );

        expect(selection.differenceFrom(perfume), 50);
      });
    });
  });
}