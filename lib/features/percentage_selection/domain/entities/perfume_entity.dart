import 'package:ya_perfume/features/results/domain/entities/perfume_result_entity.dart';

import 'fragrance_percentages.dart';

class PerfumeEntity {
  final int? code;
  final String name;
  final FragrancePercentages percentages;
  final String gender;
  final List<String> ageGroups;
  final String usageTime;
  final String season;
  final List<String> preferredScents;
  final List<String> avoidedScents;
  final List<String> occasions;
  final List<String> styles;
  final String projection;

  const PerfumeEntity({
    required this.code,
    required this.name,
    required this.percentages,
    required this.gender,
    required this.ageGroups,
    required this.usageTime,
    required this.season,
    required this.preferredScents,
    required this.avoidedScents,
    required this.occasions,
    required this.styles,
    required this.projection,
  });

  PerfumeResultEntity toResultEntity() {
    return PerfumeResultEntity(
      code: code,
      name: name,
      usageTime: usageTime,
      season: season,
      preferredScents: preferredScents,
      occasions: occasions,
      projection: projection,
      styles: styles,
    );
  }
}
