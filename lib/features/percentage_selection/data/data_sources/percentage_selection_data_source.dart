import 'package:ya_perfume/features/percentage_selection/data/models/perfume_model.dart';

abstract class PercentageSelectionDataSource {
  Future<List<PerfumeModel>> getPerfumes();
}