class AppImage {
  static AppImage? _instance;

  factory AppImage() {
    _instance ??= AppImage._internal();
    return _instance!;
  }

  AppImage._internal();

  // Base paths
  final String baseImages = 'assets/images/';
  final String baseIcons = 'assets/icons/';

  // ===== images =====
  late final String maleGenderImg = '${baseImages}male_gender.svg';
  late final String femaleGenderImg = '${baseImages}female_gender.svg';
  late final String twoGenderImg = '${baseImages}two_gender.svg';
  late final String twoGenderOffImg = '${baseImages}two_gender_off.svg';
  late final String butterflyCircleImg = '${baseImages}butterfly_circle.svg';
  late final String butterflyImg = '${baseImages}butterfly.svg';
  late final String initialQ2 = '${baseImages}initial_q2.svg';
  late final String twentyQ2 = '${baseImages}20_q2.svg';
  late final String twentyToQ2 = '${baseImages}20_29_q2.svg';
  late final String thirtyToQ2 = '${baseImages}30_39_q2.svg';
  late final String fourtyToQ2 = '${baseImages}40_49_q2.svg';
  late final String fiftyToQ2 = '${baseImages}50_q2.svg';

  // ===== icons =====
  late final String butterProgressBar = '${baseIcons}butter_progress_bar.svg';

  // ===== animations =====
}
