class PerfumeResultEntity {
  final int? code;
  final String name;
  final String usageTime;
  final String season;
  final List<String> preferredScents;
  final List<String> occasions;
  final String projection;
  final List<String> styles;

  const PerfumeResultEntity({
    required this.code,
    required this.name,
    required this.usageTime,
    required this.season,
    required this.preferredScents,
    required this.occasions,
    required this.projection,
    required this.styles,
  });
}