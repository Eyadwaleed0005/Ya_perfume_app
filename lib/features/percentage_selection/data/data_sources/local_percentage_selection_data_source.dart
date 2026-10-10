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

    final detailsByCode = <int, Map<String, dynamic>>{};

    for (final item in detailsList) {
      final details = item as Map<String, dynamic>;
      final code = details[PerfumePercentagesJsonKeys.code] as int;

      if (detailsByCode.containsKey(code)) {
        throw StateError('Duplicate perfume details for code $code.');
      }

      detailsByCode[code] = details;
    }

    final perfumes = <PerfumeModel>[];
    final percentageCodes = <int>{};

    for (final item in percentagesList) {
      final json = item as Map<String, dynamic>;
      final code = json[PerfumePercentagesJsonKeys.code] as int;

      if (!percentageCodes.add(code)) {
        throw StateError('Duplicate perfume percentages for code $code.');
      }

      final details = detailsByCode[code];

      if (details == null) {
        throw StateError('Perfume details not found for code $code.');
      }

      perfumes.add(PerfumeModel.fromJson(json, detailsJson: details));
    }

    final missingPercentageCodes = detailsByCode.keys.toSet().difference(
      percentageCodes,
    );

    if (missingPercentageCodes.isNotEmpty) {
      throw StateError(
        'Perfume percentages not found for codes: '
        '${missingPercentageCodes.join(', ')}.',
      );
    }

    return perfumes.toList(growable: false);
  }
}
