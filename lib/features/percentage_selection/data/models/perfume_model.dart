import 'package:ya_perfume/core/constants/perfume_percentages_json_keys.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/fragrance_percentages.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/perfume_entity.dart';

class PerfumeModel extends PerfumeEntity {
  const PerfumeModel({
    required super.code,
    required super.name,
    required super.percentages,
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

  factory PerfumeModel.fromJson(
    Map<String, dynamic> json, {
    required Map<String, dynamic> detailsJson,
  }) {
    final percentages =
        json[PerfumePercentagesJsonKeys.percentages] as Map<String, dynamic>;

    return PerfumeModel(
      code: (json[PerfumePercentagesJsonKeys.code] as int?) ?? 0,
      name: json[PerfumePercentagesJsonKeys.name] as String,
      percentages: FragrancePercentages(
        sweet: (percentages[PerfumePercentagesJsonKeys.sweet] as num)
            .toDouble(),
        fresh: (percentages[PerfumePercentagesJsonKeys.fresh] as num)
            .toDouble(),
        floral: (percentages[PerfumePercentagesJsonKeys.floral] as num)
            .toDouble(),
        woody: (percentages[PerfumePercentagesJsonKeys.woody] as num)
            .toDouble(),
        fruity: (percentages[PerfumePercentagesJsonKeys.fruity] as num)
            .toDouble(),
        whiteFloralJasmin:
            (percentages[PerfumePercentagesJsonKeys.whiteFloralJasmin] as num)
                .toDouble(),
      ),
      gender: detailsJson[PerfumePercentagesJsonKeys.gender] as String,
      ageGroups: List<String>.unmodifiable(
        detailsJson[PerfumePercentagesJsonKeys.ageGroups] as List<dynamic>,
      ),
      usageTime: detailsJson[PerfumePercentagesJsonKeys.usageTime] as String,
      season: detailsJson[PerfumePercentagesJsonKeys.season] as String,
      preferredScents: List<String>.unmodifiable(
        detailsJson[PerfumePercentagesJsonKeys.preferredScents]
            as List<dynamic>,
      ),
      avoidedScents: List<String>.unmodifiable(
        detailsJson[PerfumePercentagesJsonKeys.avoidedScents] as List<dynamic>,
      ),
      occasions: List<String>.unmodifiable(
        detailsJson[PerfumePercentagesJsonKeys.occasions] as List<dynamic>,
      ),
      styles: List<String>.unmodifiable(
        detailsJson[PerfumePercentagesJsonKeys.styles] as List<dynamic>,
      ),
      projection: detailsJson[PerfumePercentagesJsonKeys.projection] as String,
    );
  }
}
