import 'package:ya_perfume/core/constants/perfume_percentages_json_keys.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/fragrance_percentages.dart';
import 'package:ya_perfume/features/percentage_selection/domain/entities/perfume_entity.dart';

class PerfumeModel extends PerfumeEntity {
  const PerfumeModel({
    required super.code,
    required super.name,
    required super.percentages,
  });

  factory PerfumeModel.fromJson(Map<String, dynamic> json) {
    final percentages =
        json[PerfumePercentagesJsonKeys.percentages] as Map<String, dynamic>;

    return PerfumeModel(
      code: json[PerfumePercentagesJsonKeys.code] as int?,
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
      ),
    );
  }
}
