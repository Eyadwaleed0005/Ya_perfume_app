import 'perfume_entity.dart';

class PerfumeMatchEntity {
  final PerfumeEntity perfume;
  final double difference;

  const PerfumeMatchEntity({
    required this.perfume,
    required this.difference,
  });
}