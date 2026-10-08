import 'package:flutter_test/flutter_test.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/fragrance_percentages.dart';

void main() {
  group('FragrancePercentages', () {
    group('total', () {
      test('adds all six percentages', () {
        const percentages = FragrancePercentages(
          sweet: 10,
          fresh: 20,
          floral: 15,
          woody: 10,
          fruity: 12,
          whiteFloralJasmin: 8,
        );

        expect(percentages.total, 75);
      });
    });

    group('isValidSelection', () {
      test('accepts six percentages totaling 100', () {
        const percentages = FragrancePercentages(
          sweet: 20,
          fresh: 20,
          floral: 15,
          woody: 15,
          fruity: 20,
          whiteFloralJasmin: 10,
        );

        expect(percentages.isValidSelection, isTrue);
      });

      const familyNames = [
        'sweet',
        'fresh',
        'floral',
        'woody',
        'fruity',
        'whiteFloralJasmin',
      ];

      for (var index = 0; index < familyNames.length; index++) {
        test('accepts ${familyNames[index]} at 100 and the others at zero', () {
          final values = List<double>.filled(6, 0);
          values[index] = 100;

          final percentages = FragrancePercentages(
            sweet: values[0],
            fresh: values[1],
            floral: values[2],
            woody: values[3],
            fruity: values[4],
            whiteFloralJasmin: values[5],
          );

          expect(percentages.isValidSelection, isTrue);
        });
      }

      test('accepts decimal percentages totaling 100', () {
        const percentages = FragrancePercentages(
          sweet: 20.5,
          fresh: 19.5,
          floral: 15.2,
          woody: 14.8,
          fruity: 20.3,
          whiteFloralJasmin: 9.7,
        );

        expect(percentages.isValidSelection, isTrue);
      });

      test('accepts a small floating-point difference', () {
        const percentages = FragrancePercentages(
          sweet: 20,
          fresh: 20,
          floral: 15,
          woody: 15,
          fruity: 20,
          whiteFloralJasmin: 9.9995,
        );

        expect(percentages.isValidSelection, isTrue);
      });

      test('rejects a total below 100', () {
        const percentages = FragrancePercentages(
          sweet: 15,
          fresh: 15,
          floral: 15,
          woody: 15,
          fruity: 10,
          whiteFloralJasmin: 10,
        );

        expect(percentages.total, 80);
        expect(percentages.isValidSelection, isFalse);
      });

      test('rejects a total above 100', () {
        const percentages = FragrancePercentages(
          sweet: 20,
          fresh: 20,
          floral: 20,
          woody: 20,
          fruity: 20,
          whiteFloralJasmin: 20,
        );

        expect(percentages.total, 120);
        expect(percentages.isValidSelection, isFalse);
      });

      test('rejects a total outside the tolerance', () {
        const percentages = FragrancePercentages(
          sweet: 20,
          fresh: 20,
          floral: 15,
          woody: 15,
          fruity: 20,
          whiteFloralJasmin: 9.998,
        );

        expect(percentages.isValidSelection, isFalse);
      });

      for (var index = 0; index < familyNames.length; index++) {
        test(
          'rejects a negative ${familyNames[index]} even when the total is 100',
          () {
            final values = List<double>.filled(6, 21);
            values[index] = -5;

            final percentages = FragrancePercentages(
              sweet: values[0],
              fresh: values[1],
              floral: values[2],
              woody: values[3],
              fruity: values[4],
              whiteFloralJasmin: values[5],
            );

            expect(percentages.total, 100);
            expect(percentages.isValidSelection, isFalse);
          },
        );

        test(
          'rejects ${familyNames[index]} above 100 even when the total is 100',
          () {
            final values = List<double>.filled(6, 0);
            values[index] = 105;
            values[(index + 1) % values.length] = -5;

            final percentages = FragrancePercentages(
              sweet: values[0],
              fresh: values[1],
              floral: values[2],
              woody: values[3],
              fruity: values[4],
              whiteFloralJasmin: values[5],
            );

            expect(percentages.total, 100);
            expect(percentages.isValidSelection, isFalse);
          },
        );
      }

      for (final invalidValue in [
        double.nan,
        double.infinity,
        double.negativeInfinity,
      ]) {
        for (var index = 0; index < familyNames.length; index++) {
          test('rejects $invalidValue in ${familyNames[index]}', () {
            final values = [20.0, 20.0, 15.0, 15.0, 20.0, 10.0];
            values[index] = invalidValue;

            final percentages = FragrancePercentages(
              sweet: values[0],
              fresh: values[1],
              floral: values[2],
              woody: values[3],
              fruity: values[4],
              whiteFloralJasmin: values[5],
            );

            expect(percentages.isValidSelection, isFalse);
          });
        }
      }
    });

    group('differenceFrom', () {
      test('returns zero for identical percentages', () {
        const percentages = FragrancePercentages(
          sweet: 20,
          fresh: 20,
          floral: 15,
          woody: 15,
          fruity: 20,
          whiteFloralJasmin: 10,
        );

        expect(percentages.differenceFrom(percentages), 0);
      });

      test('adds absolute differences across all six families', () {
        const selection = FragrancePercentages(
          sweet: 30,
          fresh: 20,
          floral: 15,
          woody: 10,
          fruity: 15,
          whiteFloralJasmin: 10,
        );

        const perfume = FragrancePercentages(
          sweet: 10,
          fresh: 30,
          floral: 10,
          woody: 20,
          fruity: 10,
          whiteFloralJasmin: 20,
        );

        // 20 + 10 + 5 + 10 + 5 + 10 = 60.
        expect(selection.differenceFrom(perfume), 60);
        expect(perfume.differenceFrom(selection), 60);
      });

      test('includes fruity and white floral differences', () {
        const selection = FragrancePercentages(
          sweet: 20,
          fresh: 20,
          floral: 15,
          woody: 15,
          fruity: 20,
          whiteFloralJasmin: 10,
        );

        const perfume = FragrancePercentages(
          sweet: 20,
          fresh: 20,
          floral: 15,
          woody: 15,
          fruity: 10,
          whiteFloralJasmin: 20,
        );

        expect(selection.differenceFrom(perfume), 20);
      });

      test('compares stored percentages without normalizing them', () {
        const selection = FragrancePercentages(
          sweet: 20,
          fresh: 20,
          floral: 15,
          woody: 15,
          fruity: 20,
          whiteFloralJasmin: 10,
        );

        const perfume = FragrancePercentages(
          sweet: 10,
          fresh: 10,
          floral: 10,
          woody: 5,
          fruity: 10,
          whiteFloralJasmin: 5,
        );

        expect(perfume.total, 50);
        expect(selection.differenceFrom(perfume), 50);
      });
    });
  });
}
