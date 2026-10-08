import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/fragrance_percentages.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/perfume_entity.dart';
import 'package:ya_perfume/features/percentage_selection/domain/repositories/percentage_selection_repository.dart';
import 'package:ya_perfume/features/percentage_selection/domain/use_cases/get_closest_perfumes_use_case.dart';

class MockPercentageSelectionRepository extends Mock
    implements PercentageSelectionRepository {}

void main() {
  late MockPercentageSelectionRepository repository;
  late GetClosestPerfumesUseCase useCase;

  const selection = FragrancePercentages(
    sweet: 25,
    fresh: 25,
    floral: 25,
    woody: 25,
    fruity: 0,
    whiteFloralJasmin: 0,
  );

  PerfumeEntity createPerfume({
    required String name,
    double sweet = 25,
    double fresh = 25,
    double floral = 25,
    double woody = 25,
    double fruity = 0,
    double whiteFloralJasmin = 0,
  }) {
    return PerfumeEntity(
      code: 0,
      name: name,
      percentages: FragrancePercentages(
        sweet: sweet,
        fresh: fresh,
        floral: floral,
        woody: woody,
        fruity: fruity,
        whiteFloralJasmin: whiteFloralJasmin,
      ),
      gender: 'رجالي',
      ageGroups: const ['20-29', '30-39'],
      usageTime: 'مساءً وليلاً',
      season: 'الشتاء',
      preferredScents: const ['خشبي', 'شرقي ودافئ'],
      avoidedScents: const ['الزهور القوية'],
      occasions: const ['نزهات وزيارات المقاهي'],
      styles: const ['أنيق وراقٍ'],
      projection: 'واضح ومتوازن',
    );
  }

  setUp(() {
    repository = MockPercentageSelectionRepository();
    useCase = GetClosestPerfumesUseCase(repository);
  });

  group('GetClosestPerfumesUseCase', () {
    test('returns the closest four in ascending difference order', () async {
      final exact = createPerfume(name: 'Z Exact');
      final second = createPerfume(
        name: 'Y Second',
        sweet: 27,
        fresh: 23,
      );
      final third = createPerfume(
        name: 'X Third',
        floral: 30,
        woody: 20,
      );
      final fourth = createPerfume(
        name: 'W Fourth',
        sweet: 35,
        woody: 15,
      );
      final fifth = createPerfume(
        name: 'B Fifth',
        fresh: 40,
        floral: 10,
      );
      final sixth = createPerfume(
        name: 'A Sixth',
        sweet: 45,
        fresh: 5,
      );

      when(() => repository.getPerfumes()).thenAnswer(
        (_) async => [sixth, fourth, second, fifth, exact, third],
      );

      final result = await useCase(selection);

      expect(result, orderedEquals([exact, second, third, fourth]));

      verify(() => repository.getPerfumes()).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('includes fruity and white floral in ranking', () async {
      const sixFamilySelection = FragrancePercentages(
        sweet: 15,
        fresh: 15,
        floral: 25,
        woody: 25,
        fruity: 10,
        whiteFloralJasmin: 10,
      );

      final exact = createPerfume(
        name: 'Z Exact',
        sweet: 15,
        fresh: 15,
        fruity: 10,
        whiteFloralJasmin: 10,
      );

      final close = createPerfume(
        name: 'M Close',
        sweet: 15,
        fresh: 15,
        fruity: 12,
        whiteFloralJasmin: 8,
      );

      final farther = createPerfume(
        name: 'A Farther',
        sweet: 15,
        fresh: 15,
        fruity: 20,
        whiteFloralJasmin: 0,
      );

      // أول أربع نسب متطابقة؛ النسبتان الجديدتان تحددان الترتيب.
      // الفرق: exact = 0، close = 4، farther = 20.
      when(() => repository.getPerfumes()).thenAnswer(
        (_) async => [farther, close, exact],
      );

      final result = await useCase(sixFamilySelection);

      expect(result, orderedEquals([exact, close, farther]));
    });

    test('sorts equal differences alphabetically by name', () async {
      final zulu = createPerfume(
        name: 'Zulu',
        sweet: 30,
        fresh: 20,
      );
      final alpha = createPerfume(
        name: 'Alpha',
        floral: 30,
        woody: 20,
      );
      final beta = createPerfume(
        name: 'Beta',
        fresh: 30,
        sweet: 20,
      );

      when(() => repository.getPerfumes()).thenAnswer(
        (_) async => [zulu, beta, alpha],
      );

      final result = await useCase(selection);

      expect(result, orderedEquals([alpha, beta, zulu]));
    });

    test('uses alphabetical order at the fourth-place cutoff', () async {
      final perfumes = [
        createPerfume(name: 'Echo'),
        createPerfume(name: 'Delta'),
        createPerfume(name: 'Charlie'),
        createPerfume(name: 'Bravo'),
        createPerfume(name: 'Alpha'),
      ];

      when(() => repository.getPerfumes()).thenAnswer(
        (_) async => perfumes,
      );

      final result = await useCase(selection);

      expect(
        result.map((perfume) => perfume.name),
        orderedEquals(['Alpha', 'Bravo', 'Charlie', 'Delta']),
      );
    });

    test('returns all available perfumes when fewer than four exist', () async {
      final closest = createPerfume(name: 'Closest');
      final farther = createPerfume(
        name: 'Farther',
        sweet: 35,
        fresh: 15,
      );

      when(() => repository.getPerfumes()).thenAnswer(
        (_) async => [farther, closest],
      );

      final result = await useCase(selection);

      expect(result, orderedEquals([closest, farther]));
    });

    test('returns an empty list when the repository is empty', () async {
      when(() => repository.getPerfumes()).thenAnswer(
        (_) async => <PerfumeEntity>[],
      );

      final result = await useCase(selection);

      expect(result, isEmpty);
    });

    test('compares stored percentages without normalizing them', () async {
      final partial = createPerfume(
        name: 'Partial',
        sweet: 20,
        fresh: 20,
        floral: 20,
        woody: 20,
      );

      final full = createPerfume(
        name: 'Full',
        sweet: 30,
        fresh: 30,
        floral: 20,
        woody: 20,
      );

      // الفرق متساوي: 20 لكل عطر.
      // بالتالي الاسم هو اللي يحدد الترتيب.
      when(() => repository.getPerfumes()).thenAnswer(
        (_) async => [partial, full],
      );

      final result = await useCase(selection);

      expect(result, orderedEquals([full, partial]));
      expect(partial.percentages.total, 80);
      expect(full.percentages.total, 100);
    });

    test('does not change the repository list order', () async {
      final farther = createPerfume(
        name: 'Farther',
        sweet: 40,
        fresh: 10,
      );
      final closest = createPerfume(name: 'Closest');
      final source = [farther, closest];

      when(() => repository.getPerfumes()).thenAnswer(
        (_) async => source,
      );

      final result = await useCase(selection);

      expect(result, orderedEquals([closest, farther]));
      expect(source, orderedEquals([farther, closest]));
    });

    test('propagates exceptions from the repository', () async {
      final error = Exception('Unable to load perfumes');

      when(() => repository.getPerfumes()).thenAnswer(
        (_) async => throw error,
      );

      await expectLater(
        useCase(selection),
        throwsA(same(error)),
      );

      verify(() => repository.getPerfumes()).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}