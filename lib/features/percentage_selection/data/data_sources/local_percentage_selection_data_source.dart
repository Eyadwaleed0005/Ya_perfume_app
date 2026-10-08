import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ya_perfume/core/constants/app_asset_paths.dart';
import 'package:ya_perfume/core/constants/perfume_percentages_json_keys.dart';
import 'package:ya_perfume/features/percentage_selection/data/models/perfume_model.dart';
import 'percentage_selection_data_source.dart';

class LocalPercentageSelectionDataSource
    implements PercentageSelectionDataSource {
  final AssetBundle assetBundle;

  LocalPercentageSelectionDataSource({required this.assetBundle});

  @override
  Future<List<PerfumeModel>> getPerfumes() async {
    final jsonStrings = await Future.wait<String>([
      assetBundle.loadString(AppDataPaths.perfumePercentages),
      assetBundle.loadString(AppDataPaths.perfumeQuestions),
    ]);

    final percentagesList = jsonDecode(jsonStrings[0]) as List<dynamic>;

    final detailsList = jsonDecode(jsonStrings[1]) as List<dynamic>;

    // TODO: Replace name-based matching with code-based matching
    // once perfume codes are populated consistently in both data files.
    final detailsByName = <String, Map<String, dynamic>>{};

    for (final item in detailsList) {
      final details = item as Map<String, dynamic>;
      final name = details[PerfumePercentagesJsonKeys.name] as String;

      if (detailsByName.containsKey(name)) {
        throw StateError('Duplicate perfume details for "$name".');
      }
      detailsByName[name] = details;
    }

    return percentagesList
        .map((item) {
          final json = item as Map<String, dynamic>;
          final name = json[PerfumePercentagesJsonKeys.name] as String;
          final details = detailsByName[name];

          if (details == null) {
            throw StateError('Perfume details not found for "$name".');
          }
          return PerfumeModel.fromJson(json, detailsJson: details);
        })
        .toList(growable: false);
  }
}
