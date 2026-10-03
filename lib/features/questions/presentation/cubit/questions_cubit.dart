import 'package:bloc/bloc.dart';
import 'package:ya_perfume/app/routes/app_images_routes.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/theme/app_theme.dart';
import 'package:ya_perfume/features/questions/data/models/fragrance_family_model.dart';
import 'package:ya_perfume/features/questions/data/models/question_model.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit() : super(const QuestionsState());

  QuestionModel get currentQuestion => state.questions[state.currentIndex];

  QuestionOption? get selectedOption {
    final saved = state.allAnswers[currentQuestion.id];
    if (saved == null || saved.isEmpty) return null;

    final selectedId = saved.first;
    for (final option in currentQuestion.options) {
      if (option.id == selectedId) return option;
    }
    return null;
  }

  void getQuestions() {
    emit(
      state.copyWith(
        questions: [
          QuestionModel(
            id: '1',
            title: 'question_1_title',
            questionText: 'question_1_text',
            note: 'question_1_note',
            initailImage: AppImage().twoGenderOffImgQ1,
            initailBackGroundColor: AppColors.bgCanvas,
            initailPrimaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
            initailSecondaryColor: AppColors.goldAccent,
            options: [
              QuestionOption(
                id: '1',
                text: 'question_1_option_1',
                image: AppImage().maleGenderImgQ1,
              ),
              QuestionOption(
                id: '2',
                text: 'question_1_option_2',
                image: AppImage().femaleGenderImgQ1,
              ),
              QuestionOption(
                id: '3',
                text: 'question_1_option_3',
                image: AppImage().twoGenderImgQ1,
              ),
            ],
          ),
          QuestionModel(
            id: '2',
            title: 'question_2_title',
            questionText: 'question_2_text',
            note: 'question_2_note',
            initailImage: AppImage().initialQ2,
            options: [
              QuestionOption(
                id: '1',
                text: 'question_2_option_1',
                image: AppImage().twentyQ2,
              ),
              QuestionOption(
                id: '2',
                text: 'question_2_option_2',
                image: AppImage().twentyToQ2,
              ),
              QuestionOption(
                id: '3',
                text: 'question_2_option_3',
                image: AppImage().thirtyToQ2,
              ),
              QuestionOption(
                id: '4',
                text: 'question_2_option_4',
                image: AppImage().fourtyToQ2,
              ),
              QuestionOption(id: '5', text: 'question_2_option_5', image: AppImage().fiftyToQ2),
            ],
          ),
          QuestionModel(
            id: '3',
            title: 'question_3_title',
            questionText: 'question_3_text',
            note: 'question_3_note',
            //initailImage: AppImage().twoGenderOffImg,
            options: [
              QuestionOption(
                id: '1',
                text: 'question_3_option_1',
                image: AppImage().sunLightQ3,
              ),
              QuestionOption(
                id: '2',
                text: 'question_3_option_2',
                image: AppImage().moonNightQ3,
              ),
              QuestionOption(
                id: '3',
                text: 'question_3_option_3',
                image: AppImage().lightNightQ3,
              ),
            ],
          ),
          QuestionModel(
            id: '4',
            title: 'question_4_title',
            questionText: 'question_4_text',
            note: 'question_4_note',
            initailImage: AppImage().perfumeQ4,
            options: [
              QuestionOption(
                id: '1',
                text: 'question_4_option_1',
                image: AppImage().summerQ4,
              ),
              QuestionOption(
                id: '2',
                text: 'question_4_option_2',
                image: AppImage().winterQ4,
              ),
              QuestionOption(id: '3', text: 'question_4_option_3'),
            ],
          ),
          QuestionModel(
            id: '5',
            title: 'question_5_title',
            questionText: 'question_5_text',
            note: 'question_5_note',

            options: [
              QuestionOption(
                id: '1',
                text: 'question_5_option_1',
                image: AppImage().freshQ5,
              ),
              QuestionOption(
                id: '2',
                text: 'question_5_option_2',
                image: AppImage().muskQ5,
              ),
              QuestionOption(id: '3', text: 'question_5_option_3', image: AppImage().springQ5),
              QuestionOption(id: '4', text: 'question_5_option_4', image: AppImage().fruitQ5),
              QuestionOption(
                id: '5',
                text: 'question_5_option_5',
                image: AppImage().sweetQ5,
              ),
              QuestionOption(id: '6', text: 'question_5_option_6', image: AppImage().woodQ5),
              QuestionOption(
                id: '7',
                text: 'question_5_option_7',
                image: AppImage().orientalQ5,
              ),
              QuestionOption(
                id: '8',
                text: 'question_5_option_8',
                image: AppImage().oudQ5,
              ),
            ],
            selectionType: QuestionSelectionType.multiple,
            minSelections: 1,
            maxSelections: 2,
          ),
          QuestionModel(
            id: '6',
            title: 'question_6_title',
            questionText: 'question_6_text',
            note: 'question_6_note',

            options: [
              QuestionOption(id: '1', text: 'question_6_option_1'),
              QuestionOption(id: '2', text: 'question_6_option_2'),
              QuestionOption(id: '3', text: 'question_6_option_3'),
              QuestionOption(id: '4', text: 'question_6_option_4'),
              QuestionOption(id: '5', text: 'question_6_option_5'),
              QuestionOption(id: '6', text: 'question_6_option_6'),
              QuestionOption(id: '7', text: 'question_6_option_7'),
            ],
            selectionType: QuestionSelectionType.multiple,
            minSelections: 1,
            maxSelections: 2,
            isSkippable: true,
          ),
          QuestionModel(
            id: '7',
            title: 'question_7_title',
            questionText: 'question_7_text',
            note: 'question_7_note',

            options: [
              QuestionOption(
                id: '1',
                text: 'question_7_option_1',
                image: AppImage().dailyQ7,
              ),
              QuestionOption(
                id: '2',
                text: 'question_7_option_2',
                image: AppImage().cityQ7,
              ),
              QuestionOption(
                id: '3',
                text: 'question_7_option_3',
                image: AppImage().activeQ7,
              ),
              QuestionOption(
                id: '4',
                text: 'question_7_option_4',
                image: AppImage().dateQ7,
              ),
              QuestionOption(
                id: '5',
                text: 'question_7_option_5',
                image: AppImage().formalQ7,
              ),
              QuestionOption(
                id: '6',
                text: 'question_7_option_6',
                image: AppImage().partyQ7,
              ),
            ],
          ),
          QuestionModel(
            id: '8',
            title: 'question_8_title',
            questionText: 'question_8_text',
            note: 'question_8_note',

            options: [
              QuestionOption(
                id: '1',
                text: 'question_8_option_1',
                image: AppImage().footballAndBicycleQ8,
              ),
              QuestionOption(
                id: '2',
                text: 'question_8_option_2',
                image: AppImage().footballAndBicycleQ8,
              ),
              QuestionOption(
                id: '3',
                text: 'question_8_option_3',
                image: AppImage().footballAndBicycleQ8,
              ),
              QuestionOption(
                id: '4',
                text: 'question_8_option_4',
                image: AppImage().footballAndBicycleQ8,
              ),
              QuestionOption(
                id: '5',
                text: 'question_8_option_5',
                image: AppImage().footballAndBicycleQ8,
              ),
              QuestionOption(
                id: '6',
                text: 'question_8_option_6',
                image: AppImage().footballAndBicycleQ8,
              ),
            ],
          ),
          QuestionModel(
            id: '9',
            title: 'question_9_title',
            questionText: 'question_9_text',
            note: 'question_9_note',

            options: [
              QuestionOption(
                id: '1',
                text: 'question_9_option_1',
                subtitle: 'question_9_option_1_subtitle',
                image: AppImage().smallCircleQ9,
              ),
              QuestionOption(
                id: '2',
                text: 'question_9_option_2',
                subtitle: 'question_9_option_2_subtitle',
                image: AppImage().mediumCircleQ9,
              ),
              QuestionOption(
                id: '3',
                text: 'question_9_option_3',
                subtitle: 'question_9_option_3_subtitle',
                image: AppImage().largeCircleQ9,
              ),
            ],
          ),
        ],
        selectedThemeType: null,
      ),
    );
  }

  void getFamilies() {
    emit(
      state.copyWith(
        families: [
          FragranceFamily(
            number: '01',
            title: 'family_1_title',
            description: 'family_1_description',
          ),
          FragranceFamily(
            number: '02',
            title: 'family_2_title',
            description: 'family_2_description',
          ),
          FragranceFamily(
            number: '03',
            title: 'family_3_title',
            description: 'family_3_description',
          ),
          FragranceFamily(
            number: '04',
            title: 'family_4_title',
            description: 'family_4_description',
          ),
          FragranceFamily(
            number: '05',
            title: 'family_5_title',
            description: 'family_5_description',
          ),
          FragranceFamily(
            number: '06',
            title: 'family_6_title',
            description: 'family_6_description',
          ),
          FragranceFamily(
            number: '07',
            title: 'family_7_title',
            description: 'family_7_description',
          ),
          FragranceFamily(
            number: '08',
            title: 'family_8_title',
            description: 'family_8_description',
          ),
        ],
      ),
    );
  }

  void toggleOption(String optionId) {
    final questionId = currentQuestion.id;
    final selected = {...state.selectedOptions};

    if (selected.contains(optionId)) {
      if (currentQuestion.selectionType == QuestionSelectionType.multiple &&
          selected.length == currentQuestion.maxSelections) {
        emit(state.copyWith(showInfo: false));
      }
      selected.remove(optionId);
    } else {
      if (currentQuestion.selectionType == QuestionSelectionType.single &&
          selected.length >= currentQuestion.maxSelections) {
        selected.clear();
      } else if (currentQuestion.selectionType ==
              QuestionSelectionType.multiple &&
          selected.length >= currentQuestion.maxSelections) {
        emit(state.copyWith(showInfo: true));
        return;
      } else if (currentQuestion.selectionType ==
              QuestionSelectionType.multiple &&
          selected.length < currentQuestion.maxSelections) {
        emit(state.copyWith(showInfo: false));
      }
      selected.add(optionId);
    }

    final updatedAnswers = Map<String, Set<String>>.from(state.allAnswers);
    updatedAnswers[questionId] = selected;

    final updatedImages = Map<String, String?>.from(state.accumulatedImages);

    if (questionId == '4') {
      // احفظ الزجازة
      updatedImages['4_bottle'] = currentQuestion.initailImage;
      // احفظ صورة الفصل
      if (selected.isNotEmpty) {
        final opt = currentQuestion.options.firstWhere(
          (o) => o.id == selected.first,
          orElse: () => currentQuestion.options.first,
        );
        updatedImages['4_season'] = opt.image;
      } else {
        updatedImages['4_season'] = null;
      }
    } else if ({'3', '5', '7', '8', '9'}.contains(questionId)) {
      // احفظ صورة الـoption المختار
      if (selected.isNotEmpty) {
        final opt = currentQuestion.options.firstWhere(
          (o) => o.id == selected.first,
          orElse: () => currentQuestion.options.first,
        );
        if (questionId == '5') {
          updatedImages['5_1'] = opt.image;
          updatedImages['5_2'] = opt.image;
        } else {
          updatedImages[questionId] = opt.image;
        }
      } else {
        updatedImages[questionId] = null;
      }
    }

    toggleTheme(updatedAnswers, state.selectedThemeType, updatedImages);
  }

  void toggleTheme(
    Map<String, Set<String>> allAnswers,
    AppThemeType? themeType,
    Map<String, String?> accumulatedImages,
  ) {
    if (currentQuestion.id == '3') {
      final selected = allAnswers[currentQuestion.id] ?? {};
      if (selected.contains('1')) {
        themeType = AppThemeType.light;
      } else if (selected.contains('2')) {
        themeType = AppThemeType.dark;
      } else if (selected.contains('3')) {
        themeType = AppThemeType.normal;
      }
    }
    emit(
      state.copyWith(
        allAnswers: allAnswers,
        selectedThemeType: themeType,
        accumulatedImages: accumulatedImages,
      ),
    );
  }

  void next() {
    if (!canContinue) return;
    if (state.currentIndex >= state.questions.length - 1) return;

    emit(state.copyWith(currentIndex: state.currentIndex + 1));
  }

  void skip() {
    if (!currentQuestion.isSkippable) return;
    if (state.currentIndex >= state.questions.length - 1) return;

    emit(state.copyWith(currentIndex: state.currentIndex + 1));
  }

  void previous() {
    if (state.currentIndex == 0) return;
    emit(state.copyWith(currentIndex: state.currentIndex - 1));
  }

  bool get canContinue =>
      state.selectedOptions.length >= currentQuestion.minSelections;
}
