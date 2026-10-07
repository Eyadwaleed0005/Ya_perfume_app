import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_perfume/features/questions/data/data_sources/questions_data_source.dart';
import 'package:ya_perfume/features/questions/data/models/perfume_questions_model.dart';
import 'package:ya_perfume/features/questions/data/repositories/questions_repository_impl.dart';

class MockQuestionsDataSource extends Mock implements QuestionsDataSource {}

void main() {
  late MockQuestionsDataSource dataSource;
  late QuestionsRepositoryImpl repository;

  setUp(() {
    dataSource = MockQuestionsDataSource();
    repository = QuestionsRepositoryImpl(dataSource: dataSource);
  });

  group('QuestionsRepositoryImpl', () {
    test('returns the perfumes supplied by the data source', () async {
      final perfumes = [
        PerfumeQuestionsModel(
          code: 1,
          name: 'sexy boy',
          gender: "نسائي",
          numOfAcceptance: 6,
          ageGroups: ["20-29", "30-39"],
          usageTime: "صباحاً ونهارًا",
          season: "طول العام",
          preferredScents: ["زهري", "نظيف ومسكي وبروائح البودرة"],
          avoidedScents: ["الزهور القوية", "المسك وروائح البودرة"],
          occasions: [
            "استخدام يومي للعمل أو الدراسة",
            "موعد رومانسي أو عشاء هادئ",
          ],
          styles: ["أنيق وراقٍ", "ناعم ورومانسي"],
          projection: "واضح ومتوازن",
        ),
        PerfumeQuestionsModel(
          code: null,
          name: 'Second Perfume',
          gender: "رجالي",
          numOfAcceptance: 4,
          ageGroups: ["20-29", "30-39"],
          usageTime: "صباحاً ونهارًا",
          season: "طول العام",
          preferredScents: ["زهري", "نظيف ومسكي وبروائح البودرة"],
          avoidedScents: ["الزهور القوية", "المسك وروائح البودرة"],
          occasions: [
            "استخدام يومي للعمل أو الدراسة",
            "موعد رومانسي أو عشاء هادئ",
          ],
          styles: ["أنيق وراقٍ", "ناعم ورومانسي"],
          projection: "واضح ومتوازن",
        ),
      ];

      when(() => dataSource.fetchPerfumes()).thenAnswer((_) async => perfumes);

      final result = await repository.fetchPerfumes();

      expect(result, perfumes);

      verify(() => dataSource.fetchPerfumes()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('returns an empty list when the data source is empty', () async {
      when(() => dataSource.fetchPerfumes())
          .thenAnswer((_) async => <PerfumeQuestionsModel>[]);

      final result = await repository.fetchPerfumes();

      expect(result, isEmpty);
      verify(() => dataSource.fetchPerfumes()).called(1);
    });

    test('propagates exceptions from the data source', () async {
      final error = Exception('Asset loading failed');

      when(() => dataSource.fetchPerfumes())
          .thenAnswer((_) async => throw error);

      await expectLater(repository.fetchPerfumes(), throwsA(isA<Exception>()));

      verify(() => dataSource.fetchPerfumes()).called(1);
    });
  });
}
