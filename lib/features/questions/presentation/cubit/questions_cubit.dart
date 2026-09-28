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
            title: "طابع العطر",
            questionText: "ما الطابع الذي تفضّله لعطرك؟",
            note: "اختر الطابع الذي تفضّله، بصرف النظر عن جنسك.",
            initailImage: AppImage().twoGenderOffImgQ1,
            initailBackGroundColor: AppColors.bgCanvas,
            initailPrimaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
            initailSecondaryColor: AppColors.goldAccent,
            options: [
              QuestionOption(
                id: '1',
                text: 'رجالي',
                image: AppImage().maleGenderImgQ1,
              ),
              QuestionOption(
                id: '2',
                text: 'نسائي',
                image: AppImage().femaleGenderImgQ1,
              ),
              QuestionOption(
                id: '3',
                text: 'للجنسين',
                image: AppImage().twoGenderImgQ1,
              ),
            ],
          ),
          QuestionModel(
            id: '2',
            title: "العمر",
            questionText: "ما فئتك العمرية؟",
            note: "تساعدنا إجابتك على اقتراح طابع عطري يناسبك.",
            initailImage: AppImage().initialQ2,
            options: [
              QuestionOption(
                id: '1',
                text: 'أقل من 20',
                image: AppImage().twentyQ2,
              ),
              QuestionOption(
                id: '2',
                text: '20–29',
                image: AppImage().twentyToQ2,
              ),
              QuestionOption(
                id: '3',
                text: '30–39',
                image: AppImage().thirtyToQ2,
              ),
              QuestionOption(
                id: '4',
                text: '40–49',
                image: AppImage().fourtyToQ2,
              ),
              QuestionOption(id: '5', text: '50+', image: AppImage().fiftyToQ2),
            ],
          ),
          QuestionModel(
            id: '3',
            title: "وقت الاستخدام",
            questionText: "متى تستخدم العطر غالبًا؟",
            note: "اختر الوقت الأقرب إلى استخدامك.",
            //initailImage: AppImage().twoGenderOffImg,
            options: [
              QuestionOption(
                id: '1',
                text: 'صباحًا ونهارًا',
                image: AppImage().sunLightQ3,
              ),
              QuestionOption(
                id: '2',
                text: 'مساءً وليلًا',
                image: AppImage().moonNightQ3,
              ),
              QuestionOption(
                id: '3',
                text: 'في كلا الوقتين',
                image: AppImage().lightNightQ3,
              ),
            ],
          ),
          QuestionModel(
            id: '4',
            title: "الفصل",
            questionText: "في أي فصل تستخدم العطر غالبًا؟",
            note: "اختر الفصل الأقرب إلى استخدامك.",
            initailImage: AppImage().perfumeQ4,
            options: [
              QuestionOption(
                id: '1',
                text: 'الصيف',
                image: AppImage().summerQ4,
              ),
              QuestionOption(
                id: '2',
                text: 'الشتاء',
                image: AppImage().winterQ4,
              ),
              QuestionOption(id: '3', text: 'طول العام'),
            ],
          ),
          QuestionModel(
            id: '5',
            title: "الروائح المفضلة",
            questionText: "ما الروائح التي تفضّلها؟",
            note: "اختر عائلة عطرية واحدة أو عائلتين كحد أقصى.",

            options: [
              QuestionOption(
                id: '1',
                text: 'منعش وحمضي',
                image: AppImage().freshQ5,
              ),
              QuestionOption(
                id: '2',
                text: 'نظيف ومسكي وبروائح البودرة',
                image: AppImage().muskQ5,
              ),
              QuestionOption(id: '3', text: 'زهري', image: AppImage().springQ5),
              QuestionOption(id: '4', text: 'فاكهي', image: AppImage().fruitQ5),
              QuestionOption(
                id: '5',
                text: 'حلو ومستوحى من الحلوى',
                image: AppImage().sweetQ5,
              ),
              QuestionOption(id: '6', text: 'خشبي', image: AppImage().woodQ5),
              QuestionOption(
                id: '7',
                text: 'شرقي ودافئ',
                image: AppImage().orientalQ5,
              ),
              QuestionOption(
                id: '8',
                text: 'عود ودخان وجلد',
                image: AppImage().oudQ5,
              ),
            ],
            selectionType: QuestionSelectionType.multiple,
            minSelections: 1,
            maxSelections: 2,
          ),
          QuestionModel(
            id: '6',
            title: "الروائح غير المحبوبة · اختياري",
            questionText: "هل توجد روائح تفضّل تجنّبها؟",
            note: "اختر الروائح التي تفضّل تجنّبها، أو تخطَّ هذا السؤال.",

            options: [
              QuestionOption(id: '1', text: 'الفانيليا والحلاوة القوية'),
              QuestionOption(id: '2', text: 'الحمضيات'),
              QuestionOption(id: '3', text: 'الزهور القوية'),
              QuestionOption(id: '4', text: 'المسك وروائح البودرة'),
              QuestionOption(id: '5', text: 'العود والبخور'),
              QuestionOption(id: '6', text: 'التوابل'),
              QuestionOption(id: '7', text: 'التبغ والجلد والدخان'),
            ],
            selectionType: QuestionSelectionType.multiple,
            minSelections: 1,
            maxSelections: 2,
            isSkippable: true,
          ),
          QuestionModel(
            id: '7',
            title: "المناسبة",
            questionText: "ما المناسبة التي تستخدم فيها العطر غالبًا؟",
            note: "اختر الاستخدام الأساسي للعطر.",

            options: [
              QuestionOption(
                id: '1',
                text: 'استخدام يومي للعمل أو الدراسة',
                image: AppImage().dailyQ7,
              ),
              QuestionOption(
                id: '2',
                text: 'نزهات وزيارات المقاهي',
                image: AppImage().cityQ7,
              ),
              QuestionOption(
                id: '3',
                text: 'رياضة وأنشطة خارجية',
                image: AppImage().activeQ7,
              ),
              QuestionOption(
                id: '4',
                text: 'موعد رومانسي أو عشاء هادئ',
                image: AppImage().dateQ7,
              ),
              QuestionOption(
                id: '5',
                text: 'حفل زفاف أو مناسبة رسمية',
                image: AppImage().formalQ7,
              ),
              QuestionOption(
                id: '6',
                text: 'حفلة أو سهرة ليلية',
                image: AppImage().partyQ7,
              ),
            ],
          ),
          QuestionModel(
            id: '8',
            title: "الأسلوب الشخصي",
            questionText: "ما الأسلوب الأقرب إلى شخصيتك؟",
            note: "اختر الأسلوب الأقرب إلى شخصيتك.",

            options: [
              QuestionOption(
                id: '1',
                text: 'رياضي وحيوي',
                image: AppImage().footballAndBicycleQ8,
              ),
              QuestionOption(
                id: '2',
                text: 'عملي ومريح',
                image: AppImage().footballAndBicycleQ8,
              ),
              QuestionOption(
                id: '3',
                text: 'كلاسيكي ورسمي',
                image: AppImage().footballAndBicycleQ8,
              ),
              QuestionOption(
                id: '4',
                text: 'أنيق وراقٍ',
                image: AppImage().footballAndBicycleQ8,
              ),
              QuestionOption(
                id: '5',
                text: 'جريء ومختلف',
                image: AppImage().footballAndBicycleQ8,
              ),
              QuestionOption(
                id: '6',
                text: 'ناعم ورومانسي',
                image: AppImage().footballAndBicycleQ8,
              ),
            ],
          ),
          QuestionModel(
            id: '9',
            title: "الفوحان",
            questionText: "ما درجة فوحان العطر التي تفضّلها؟",
            note: "اختر مدى انتشار رائحة العطر حولك.",

            options: [
              QuestionOption(
                id: '1',
                text: 'هادئ وقريب منك',
                image: AppImage().smallCircleQ9,
              ),
              QuestionOption(
                id: '2',
                text: 'واضح ومتوازن',
                image: AppImage().mediumCircleQ9,
              ),
              QuestionOption(
                id: '3',
                text: 'قوي ولافت',
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
            title: 'منعش وحمضي',
            description: 'ليمون وبرغموت؛ إحساس مشرق ومنعش.',
          ),
          FragranceFamily(
            number: '02',
            title: 'نظيف ومسكي وبروائح البودرة',
            description: 'نعومة ونظافة؛ روائح تشبه القطن والبودرة.',
          ),
          FragranceFamily(
            number: '03',
            title: 'زهري',
            description:
                'ورد وياسمين؛ روائح زهرية تتدرّج من الخفيفة إلى الغنية.',
          ),
          FragranceFamily(
            number: '04',
            title: 'فاكهي',
            description: 'تفاح وتوت وخوخ؛ طابع فاكهي غني.',
          ),
          FragranceFamily(
            number: '05',
            title: 'حلو ومستوحى من الحلوى',
            description: 'فانيليا وكراميل؛ روائح مستوحاة من الحلوى.',
          ),
          FragranceFamily(
            number: '06',
            title: 'خشبي',
            description: 'أرز وصندل؛ إحساس خشبي جاف أو ناعم.',
          ),
          FragranceFamily(
            number: '07',
            title: 'شرقي ودافئ',
            description: 'عنبر وتوابل؛ طابع دافئ وغني.',
          ),
          FragranceFamily(
            number: '08',
            title: 'عود ودخان وجلد',
            description: 'عود وبخور وجلد؛ طابع عميق ومدخن.',
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
