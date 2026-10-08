import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ya_perfume/features/questions/data/models/perfume_questions_model.dart';
import 'package:ya_perfume/features/questions/domain/entities/perfume_questions_entity.dart';
import 'package:ya_perfume/features/questions/domain/repositories/questions_repository.dart';
import 'package:ya_perfume/features/questions/domain/use_cases/get_perfumes_use_case.dart';

class MockQuestionsRepository extends Mock implements QuestionsRepository {}

void main() {
  late MockQuestionsRepository repository;
  late GetPerfumesUseCase useCase;

  setUp(() {
    repository = MockQuestionsRepository();
    useCase = GetPerfumesUseCase(repository);
  });

  group('GetPerfumesUseCase', () {
    test('returns the closest four in ascending acceptance order', () async {
      final perfumesData = <PerfumeQuestionsModel>[
        PerfumeQuestionsModel(
          code: null,
          name: "Gucci Guilty Eau de Parfum",
          numOfAcceptance: 0,
          gender: "نسائي",
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
          name: "La Bomba Carolina Herrera",
          numOfAcceptance: 0,
          gender: "نسائي",
          ageGroups: ["أقل من 20", "20-29"],
          usageTime: "صباحاً ونهارًا",
          season: "الصيف",
          preferredScents: ["زهري", "فاكهي"],
          avoidedScents: ["الزهور القوية", "الفانيليا والحلاوة القوية"],
          occasions: [
            "استخدام يومي للعمل أو الدراسة",
            "نزهات وزيارات المقاهي",
            "موعد رومانسي أو عشاء هادئ",
          ],
          styles: ["جرئ ومختلف", "أنيق وراقٍ"],
          projection: "قوي ولافت",
        ),
        PerfumeQuestionsModel(
          code: null,
          name: "Secret Charm Victoria's Secret",
          numOfAcceptance: 0,
          gender: "نسائي",
          ageGroups: ["أقل من 20", "20-29"],
          usageTime: "صباحاً ونهارًا",
          season: "الصيف",
          preferredScents: ["زهري", "فاكهي"],
          avoidedScents: ["الزهور القوية"],
          occasions: ["استخدام يومي للعمل أو الدراسة", "نزهات وزيارات المقاهي"],
          styles: ["عملي ومريح", "ناعم ورومانسي"],
          projection: "هادئ وقريب منك",
        ),
        PerfumeQuestionsModel(
          code: null,
          name: "Flora by Gucci Eau de Parfum",
          numOfAcceptance: 0,
          gender: "نسائي",
          ageGroups: ["20-29", "30-39"],
          usageTime: "صباحاً ونهارًا",
          season: "طول العام",
          preferredScents: ["زهري", "منعش وحمضي"],
          avoidedScents: ["الزهور القوية", "الحمضيات"],
          occasions: ["استخدام يومي للعمل أو الدراسة", "نزهات وزيارات المقاهي"],
          styles: ["أنيق وراقٍ", "ناعم ورومانسي"],
          projection: "واضح ومتوازن",
        ),
      ];
      final questionsEntity = PerfumeQuestionsEntity(
        code: 000,
        name: 'sayed',
        numOfAcceptance: 0,
        gender: "نسائي",
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
      );

      when(() => repository.fetchPerfumes())
          .thenAnswer((_) async => perfumesData);

      final perfumes = await useCase.call(questionsEntity);

      expect(perfumes.length, 4);
      expect(perfumes.map((e) => e.name).toList(), [
        'Gucci Guilty Eau de Parfum',
        'Flora by Gucci Eau de Parfum',
        'La Bomba Carolina Herrera',
        'Secret Charm Victoria\'s Secret',
      ]);
      expect(perfumes.map((e) => e.numOfAcceptance).toList(), [11, 9, 7, 7]);

      verify(() => repository.fetchPerfumes()).called(1);
    });
  });
}
