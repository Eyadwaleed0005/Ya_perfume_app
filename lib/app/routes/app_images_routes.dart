class AppImage {
  static AppImage? _instance;

  factory AppImage() {
    _instance ??= AppImage._internal();
    return _instance!;
  }

  AppImage._internal();

  // Base paths

  final String baseIcons = 'assets/icons/';
  final String baseImages = 'assets/images/';

  final String baseImagesQ1 = 'assets/images/q1/';
  final String baseImagesQ2 = 'assets/images/q2/';
  final String baseImagesQ3 = 'assets/images/q3/';
  final String baseImagesQ4 = 'assets/images/q4/';
  final String baseImagesQ5 = 'assets/images/q5/';
  final String baseImagesQ7 = 'assets/images/q7/';
  final String baseImagesQ8 = 'assets/images/q8/';
  final String baseImagesQ9 = 'assets/images/q9/';

  // ===== images =====
  late final String butterflyCircleImg = '${baseImages}butterfly_circle.svg';
  late final String butterflyImg = '${baseImages}butterfly.svg';

  late final String maleGenderImgQ1 = '${baseImagesQ1}male_gender.svg';
  late final String femaleGenderImgQ1 = '${baseImagesQ1}female_gender.svg';
  late final String twoGenderImgQ1 = '${baseImagesQ1}two_gender.svg';
  late final String twoGenderOffImgQ1 = '${baseImagesQ1}two_gender_off.svg';

  late final String initialQ2 = '${baseImagesQ2}initial_q2.svg';
  late final String twentyQ2 = '${baseImagesQ2}20_q2.svg';
  late final String twentyToQ2 = '${baseImagesQ2}20_29_q2.svg';
  late final String thirtyToQ2 = '${baseImagesQ2}30_39_q2.svg';
  late final String fourtyToQ2 = '${baseImagesQ2}40_49_q2.svg';
  late final String fiftyToQ2 = '${baseImagesQ2}50_q2.svg';

  late final String lightNightQ3 = '${baseImagesQ3}light_night.svg';
  late final String moonNightQ3 = '${baseImagesQ3}moon_night.svg';
  late final String sunLightQ3 = '${baseImagesQ3}sun_light.svg';

  late final String perfumeQ4 = '${baseImagesQ4}perfume.svg';
  late final String summerQ4 = '${baseImagesQ4}summer.svg';
  late final String winterQ4 = '${baseImagesQ4}winter.svg';
  late final String naturalFrostQ4 = '${baseImagesQ4}natural_frost.svg';

  late final String springQ5 = '${baseImagesQ5}spring.svg';
  late final String freshQ5 = '${baseImagesQ5}fresh.svg';
  late final String fruitQ5 = '${baseImagesQ5}fruit.svg';
  late final String muskQ5 = '${baseImagesQ5}musk.svg';
  late final String orientalQ5 = '${baseImagesQ5}oriental.svg';
  late final String oudQ5 = '${baseImagesQ5}oud.svg';
  late final String woodQ5 = '${baseImagesQ5}wood.svg';
  late final String sweetQ5 = '${baseImagesQ5}sweet.svg';

  late final String activeQ7 = '${baseImagesQ7}active.svg';
  late final String cityQ7 = '${baseImagesQ7}city.svg';
  late final String dailyQ7 = '${baseImagesQ7}daily.svg';
  late final String dateQ7 = '${baseImagesQ7}date.svg';
  late final String formalQ7 = '${baseImagesQ7}formal.svg';
  late final String partyQ7 = '${baseImagesQ7}party.svg';

  late final String footballAndBicycleQ8 =
      '${baseImagesQ8}football_and_bicycle.svg';

  late final String smallCircleQ9 = '${baseImagesQ9}small_circle.svg';
  late final String mediumCircleQ9 = '${baseImagesQ9}medium_circle.svg';
  late final String largeCircleQ9 = '${baseImagesQ9}large_circle.svg';

  // ===== icons =====
  late final String butterProgressBar = '${baseIcons}butter_progress_bar.svg';

  // ===== animations =====
}
