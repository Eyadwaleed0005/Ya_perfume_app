import 'fragrance_percentages.dart';

class PerfumeEntity {
  final int? code;
  final String name;
  final FragrancePercentages percentages;

  const PerfumeEntity({
    required this.code,
    required this.name,
    required this.percentages,
  });
}