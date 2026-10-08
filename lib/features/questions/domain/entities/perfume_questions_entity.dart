import 'package:ya_perfume/features/results/domain/entities/perfume_result_entity.dart';

class PerfumeQuestionsEntity {
  final int? code;
  final String name;
  final int numOfAcceptance;
  final String gender;
  final List<String> ageGroups;
  final String usageTime;
  final String season;
  final List<String> preferredScents;
  final List<String> avoidedScents;
  final List<String> occasions;
  final List<String> styles;
  final String projection;

  PerfumeQuestionsEntity({
    required this.code,
    required this.name,
    required this.numOfAcceptance,
    required this.gender,
    required this.ageGroups,
    required this.usageTime,
    required this.season,
    required this.preferredScents,
    required this.avoidedScents,
    required this.occasions,
    required this.styles,
    required this.projection,
  });

  PerfumeResultEntity toResultEntity() {
    return PerfumeResultEntity(
      code: code,
      name: name,
      usageTime: usageTime,
      season: season,
      preferredScents: preferredScents,
      occasions: occasions,
      projection: projection,
      styles: styles,
    );
  }

  PerfumeQuestionsEntity copyWith({
    int? code,
    String? name,
    int? numOfAcceptance,
    String? gender,
    List<String>? ageGroups,
    String? usageTime,
    String? season,
    List<String>? preferredScents,
    List<String>? avoidedScents,
    List<String>? occasions,
    List<String>? styles,
    String? projection,
  }) {
    return PerfumeQuestionsEntity(
      code: code ?? this.code,
      name: name ?? this.name,
      numOfAcceptance: numOfAcceptance ?? this.numOfAcceptance,
      gender: gender ?? this.gender,
      ageGroups: ageGroups ?? this.ageGroups,
      usageTime: usageTime ?? this.usageTime,
      season: season ?? this.season,
      preferredScents: preferredScents ?? this.preferredScents,
      avoidedScents: avoidedScents ?? this.avoidedScents,
      occasions: occasions ?? this.occasions,
      styles: styles ?? this.styles,
      projection: projection ?? this.projection,
    );
  }

  @override
  String toString() {
    return '''
PerfumeQuestionsEntity(
  code: $code,
  name: $name,
  numOfAcceptance: $numOfAcceptance,
  gender: $gender,
  ageGroups: $ageGroups,
  usageTime: $usageTime,
  season: $season,
  preferredScents: $preferredScents,
  avoidedScents: $avoidedScents,
  occasions: $occasions,
  styles: $styles,
  projection: $projection,
)''';
  }
}
