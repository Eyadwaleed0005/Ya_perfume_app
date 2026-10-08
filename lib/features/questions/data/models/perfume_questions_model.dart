import 'package:ya_perfume/core/constants/perfume_questions_json_keys.dart';
import 'package:ya_perfume/features/questions/domain/entities/perfume_questions_entity.dart';

class PerfumeQuestionsModel extends PerfumeQuestionsEntity {
  PerfumeQuestionsModel({
    required super.code,
    required super.name,
    required super.numOfAcceptance,
    required super.gender,
    required super.ageGroups,
    required super.usageTime,
    required super.season,
    required super.preferredScents,
    required super.avoidedScents,
    required super.occasions,
    required super.styles,
    required super.projection,
  });

  factory PerfumeQuestionsModel.fromJson(Map<String, dynamic> json) {
    return PerfumeQuestionsModel(
      code: json[PerfumeQuestionsJsonKeys.code] ?? 0,
      name: json[PerfumeQuestionsJsonKeys.name] ?? 'none name',
      numOfAcceptance: 0,
      gender: json[PerfumeQuestionsJsonKeys.gender] ?? 'none gender',
      ageGroups: json[PerfumeQuestionsJsonKeys.ageGroups] ?? 'none ageGroups',
      usageTime: json[PerfumeQuestionsJsonKeys.usageTime] ?? 'none usageTime',
      season: json[PerfumeQuestionsJsonKeys.season] ?? 'none season',
      preferredScents:
          json[PerfumeQuestionsJsonKeys.preferredScents] ??
          'none preferredScents',
      avoidedScents:
          json[PerfumeQuestionsJsonKeys.avoidedScents] ?? 'none avoidedScents',
      occasions: json[PerfumeQuestionsJsonKeys.occasions] ?? 'none occasions',
      styles: json[PerfumeQuestionsJsonKeys.styles] ?? 'none styles',
      projection:
          json[PerfumeQuestionsJsonKeys.projection] ?? 'none projection',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      PerfumeQuestionsJsonKeys.code: code,
      PerfumeQuestionsJsonKeys.name: name,
      PerfumeQuestionsJsonKeys.numOfAcceptance: numOfAcceptance,
      PerfumeQuestionsJsonKeys.gender: gender,
      PerfumeQuestionsJsonKeys.ageGroups: ageGroups,
      PerfumeQuestionsJsonKeys.usageTime: usageTime,
      PerfumeQuestionsJsonKeys.season: season,
      PerfumeQuestionsJsonKeys.preferredScents: preferredScents,
      PerfumeQuestionsJsonKeys.avoidedScents: avoidedScents,
      PerfumeQuestionsJsonKeys.occasions: occasions,
      PerfumeQuestionsJsonKeys.styles: styles,
      PerfumeQuestionsJsonKeys.projection: projection,
    };
  }
}
