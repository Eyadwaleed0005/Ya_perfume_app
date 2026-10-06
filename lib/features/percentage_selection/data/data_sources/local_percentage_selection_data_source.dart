import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ya_perfume/core/constants/app_asset_paths.dart';
import 'package:ya_perfume/features/percentage_selection/data/models/perfume_model.dart';

import 'percentage_selection_data_source.dart';

class LocalPercentageSelectionDataSource
    implements PercentageSelectionDataSource {
  final AssetBundle assetBundle;

  LocalPercentageSelectionDataSource({required this.assetBundle});

  @override
  Future<List<PerfumeModel>> getPerfumes() async {
    final jsonString = await assetBundle.loadString(
      AppDataPaths.perfumePercentages,
    );
    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList
        .map((json) => PerfumeModel.fromJson(json as Map<String, dynamic>))
        .toList(growable: false);
  }
}
