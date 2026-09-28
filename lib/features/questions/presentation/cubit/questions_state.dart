part of 'questions_cubit.dart';

class QuestionsState {
  final int currentIndex;
  final List<QuestionModel> questions;
  final List<FragranceFamily> families;
  final Map<String, Set<String>> allAnswers;
  final bool showInfo;
  final AppThemeType? selectedThemeType;
  final Map<String, String?> accumulatedImages;

  const QuestionsState({
    this.currentIndex = 0,
    this.questions = const [],
    this.families = const [],
    this.allAnswers = const {},
    this.showInfo = false,
    this.selectedThemeType,
    this.accumulatedImages = const {},
  });

  Set<String> get selectedOptions =>
      allAnswers[questions.isEmpty ? '' : questions[currentIndex].id] ?? {};

  QuestionsState copyWith({
    int? currentIndex,
    List<QuestionModel>? questions,
    List<FragranceFamily>? families,
    Map<String, Set<String>>? allAnswers,
    bool? showInfo,
    AppThemeType? selectedThemeType,
    Map<String, String?>? accumulatedImages,
  }) {
    return QuestionsState(
      currentIndex: currentIndex ?? this.currentIndex,
      questions: questions ?? this.questions,
      families: families ?? this.families,
      allAnswers: allAnswers ?? this.allAnswers,
      showInfo: showInfo ?? this.showInfo,
      selectedThemeType: selectedThemeType ?? this.selectedThemeType,
      accumulatedImages: accumulatedImages ?? this.accumulatedImages,
    );
  }
}
