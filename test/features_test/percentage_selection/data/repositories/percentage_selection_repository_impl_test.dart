import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_perfume/features/percentage_selection/data/data_sources/percentage_selection_data_source.dart';
import 'package:ya_perfume/features/percentage_selection/data/models/perfume_model.dart';
import 'package:ya_perfume/features/percentage_selection/data/repositories/percentage_selection_repository_impl.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/fragrance_percentages.dart';

class MockPercentageSelectionDataSource extends Mock
    implements PercentageSelectionDataSource {}

void main() {
  late MockPercentageSelectionDataSource dataSource;
  late PercentageSelectionRepositoryImpl repository;

  setUp(() {
    dataSource = MockPercentageSelectionDataSource();
    repository = PercentageSelectionRepositoryImpl(
      dataSource: dataSource,
    );
  });

  group('PercentageSelectionRepositoryImpl', () {
    test('returns the perfumes supplied by the data source', () async {
      final perfumes = [
        const PerfumeModel(
          code: 101,
          name: 'First Perfume',
          percentages: FragrancePercentages(
            sweet: 30,
            fresh: 20,
            floral: 25,
            woody: 25,
          ),
        ),
        const PerfumeModel(
          code: null,
          name: 'Second Perfume',
          percentages: FragrancePercentages(
            sweet: 10,
            fresh: 40,
            floral: 20,
            woody: 30,
          ),
        ),
      ];

      when(() => dataSource.getPerfumes()).thenAnswer(
        (_) async => perfumes,
      );

      final result = await repository.getPerfumes();

      expect(result, orderedEquals(perfumes));

      verify(() => dataSource.getPerfumes()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('returns an empty list when the data source is empty', () async {
      when(() => dataSource.getPerfumes()).thenAnswer(
        (_) async => <PerfumeModel>[],
      );

      final result = await repository.getPerfumes();

      expect(result, isEmpty);
      verify(() => dataSource.getPerfumes()).called(1);
    });

    test('propagates exceptions from the data source', () async {
      final error = Exception('Asset loading failed');

      when(() => dataSource.getPerfumes()).thenAnswer(
        (_) async => throw error,
      );

      await expectLater(
        repository.getPerfumes(),
        throwsA(same(error)),
      );

      verify(() => dataSource.getPerfumes()).called(1);
    });
  });
}