import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ya_perfume/core/constants/app_asset_paths.dart';
import 'package:ya_perfume/features/questions/data/models/perfume_questions_model.dart';

import 'questions_data_source.dart';

class LocalQuestionsDataSource implements QuestionsDataSource {
  final AssetBundle assetBundle;

  LocalQuestionsDataSource({required this.assetBundle});

  @override
  Future<List<PerfumeQuestionsModel>> fetchPerfumes() async {
    final jsonString = await assetBundle.loadString(
      AppDataPaths.perfumeQuestions,
    );
    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList
        .map(
          (json) =>
              PerfumeQuestionsModel.fromJson(json as Map<String, dynamic>),
        )
        .toList(growable: false);
  }
}
