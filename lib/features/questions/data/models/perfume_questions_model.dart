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
      code: json[PerfumeQuestionsJsonKeys.code] as int,
      name: json[PerfumeQuestionsJsonKeys.name] as String,
      numOfAcceptance: 0,
      gender: json[PerfumeQuestionsJsonKeys.gender] as String,
      ageGroups: List<String>.unmodifiable(
        json[PerfumeQuestionsJsonKeys.ageGroups] as List<dynamic>,
      ),
      usageTime: json[PerfumeQuestionsJsonKeys.usageTime] as String,
      season: json[PerfumeQuestionsJsonKeys.season] as String,
      preferredScents: List<String>.unmodifiable(
        json[PerfumeQuestionsJsonKeys.preferredScents] as List<dynamic>,
      ),
      avoidedScents: List<String>.unmodifiable(
        json[PerfumeQuestionsJsonKeys.avoidedScents] as List<dynamic>,
      ),
      occasions: List<String>.unmodifiable(
        json[PerfumeQuestionsJsonKeys.occasions] as List<dynamic>,
      ),
      styles: List<String>.unmodifiable(
        json[PerfumeQuestionsJsonKeys.styles] as List<dynamic>,
      ),
      projection: json[PerfumeQuestionsJsonKeys.sillage] as String,
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
      PerfumeQuestionsJsonKeys.sillage: projection,
    };
  }
}