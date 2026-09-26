part of 'questions_cubit.dart';

class QuestionsState {
  final int currentIndex;
  final List<QuestionModel> questions;
  final List<FragranceFamily> families;
  final Set<String> selectedOptions;
  final bool showInfo;
  final AppThemeType? selectedThemeType;

  const QuestionsState({
    this.currentIndex = 0,
    this.questions = const [],
    this.families = const [],
    this.selectedOptions = const {},
    this.showInfo = false,
    this.selectedThemeType,
  });

  QuestionsState copyWith({
    int? currentIndex,
    List<QuestionModel>? questions,
    List<FragranceFamily>? families,
    Set<String>? selectedOptions,
    bool? showInfo,
    AppThemeType? selectedThemeType,
  }) {
    return QuestionsState(
      currentIndex: currentIndex ?? this.currentIndex,
      questions: questions ?? this.questions,
      families: families ?? this.families,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      showInfo: showInfo ?? this.showInfo,
      selectedThemeType: selectedThemeType ?? this.selectedThemeType,
    );
  }
}
