part of 'questions_cubit.dart';

class QuestionsState {
  final int currentIndex;
  final List<QuestionModel> questions;
  final List<FragranceFamily> families;
  final Set<String> selectedOptions;
  final bool showInfo;

  const QuestionsState({
    this.currentIndex = 0,
    this.questions = const [],
    this.families = const [],
    this.selectedOptions = const {},
    this.showInfo = false,
  });

  QuestionsState copyWith({
    int? currentIndex,
    List<QuestionModel>? questions,
    List<FragranceFamily>? families,
    Set<String>? selectedOptions,
    bool? showInfo,
  }) {
    return QuestionsState(
      currentIndex: currentIndex ?? this.currentIndex,
      questions: questions ?? this.questions,
      families: families ?? this.families,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      showInfo: showInfo ?? this.showInfo,
    );
  }
}
