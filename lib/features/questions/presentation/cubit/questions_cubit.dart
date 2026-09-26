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
    if (state.selectedOptions.isEmpty) {
      return null;
    }

    final selectedId = state.selectedOptions.first;

    for (final option in currentQuestion.options) {
      if (option.id == selectedId) {
        return option;
      }
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
            initailImage: AppImage().twoGenderOffImg,
            initailBackGroundColor: AppColors.bgCanvas,
            initailPrimaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
            initailSecondaryColor: AppColors.goldAccent,
            options: [
              QuestionOption(
                id: '1',
                text: 'رجالي',
                image: AppImage().maleGenderImg,
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '2',
                text: 'نسائي',
                image: AppImage().femaleGenderImg,
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '3',
                text: 'للجنسين',
                image: AppImage().twoGenderImg,
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
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
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '2',
                text: '20–29',
                image: AppImage().twentyToQ2,
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '3',
                text: '30–39',
                image: AppImage().thirtyToQ2,
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '4',
                text: '40–49',
                image: AppImage().fourtyToQ2,
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '5',
                text: '50+',
                image: AppImage().fiftyToQ2,
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
            ],
          ),
          QuestionModel(
            id: '3',
            title: "وقت الاستخدام",
            questionText: "متى تستخدم العطر غالبًا؟",
            note: "اختر الوقت الأقرب إلى استخدامك.",
            initailImage: AppImage().twoGenderOffImg,
            options: [
              QuestionOption(
                id: '1',
                text: 'صباحًا ونهارًا',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '2',
                text: 'مساءً وليلًا',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '3',
                text: 'في كلا الوقتين',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
            ],
          ),
          QuestionModel(
            id: '4',
            title: "الفصل",
            questionText: "في أي فصل تستخدم العطر غالبًا؟",
            note: "اختر الفصل الأقرب إلى استخدامك.",
            initailImage: AppImage().twoGenderOffImg,
            options: [
              QuestionOption(
                id: '1',
                text: 'الصيف',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '2',
                text: 'الشتاء',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '3',
                text: 'طول العام',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
            ],
          ),
          QuestionModel(
            id: '5',
            title: "الروائح المفضلة",
            questionText: "ما الروائح التي تفضّلها؟",
            note: "اختر عائلة عطرية واحدة أو عائلتين كحد أقصى.",
            initailImage: AppImage().twoGenderOffImg,
            options: [
              QuestionOption(
                id: '1',
                text: 'منعش وحمضي',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '2',
                text: 'نظيف ومسكي وبروائح البودرة',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '3',
                text: 'زهري',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '4',
                text: 'فاكهي',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '5',
                text: 'حلو ومستوحى من الحلوى',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '6',
                text: 'خشبي',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '7',
                text: 'شرقي ودافئ',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '8',
                text: 'عود ودخان وجلد',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
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
            initailImage: AppImage().twoGenderOffImg,
            options: [
              QuestionOption(
                id: '1',
                text: 'الفانيليا والحلاوة القوية',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '2',
                text: 'الحمضيات',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '3',
                text: 'الزهور القوية',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '4',
                text: 'المسك وروائح البودرة',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '5',
                text: 'العود والبخور',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '6',
                text: 'التوابل',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '7',
                text: 'التبغ والجلد والدخان',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
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
            initailImage: AppImage().twoGenderOffImg,
            options: [
              QuestionOption(
                id: '1',
                text: 'استخدام يومي للعمل أو الدراسة',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '2',
                text: 'نزهات وزيارات المقاهي',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '3',
                text: 'رياضة وأنشطة خارجية',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '4',
                text: 'موعد رومانسي أو عشاء هادئ',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '5',
                text: 'حفل زفاف أو مناسبة رسمية',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '6',
                text: 'حفلة أو سهرة ليلية',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
            ],
          ),
          QuestionModel(
            id: '8',
            title: "الأسلوب الشخصي",
            questionText: "ما الأسلوب الأقرب إلى شخصيتك؟",
            note: "اختر الأسلوب الأقرب إلى شخصيتك.",
            initailImage: AppImage().twoGenderOffImg,
            options: [
              QuestionOption(
                id: '1',
                text: 'رياضي وحيوي',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '2',
                text: 'عملي ومريح',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '3',
                text: 'كلاسيكي ورسمي',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '4',
                text: 'أنيق وراقٍ',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '5',
                text: 'جريء ومختلف',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '6',
                text: 'ناعم ورومانسي',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
            ],
          ),
          QuestionModel(
            id: '9',
            title: "الفوحان",
            questionText: "ما درجة فوحان العطر التي تفضّلها؟",
            note: "اختر مدى انتشار رائحة العطر حولك.",
            initailImage: AppImage().twoGenderOffImg,
            options: [
              QuestionOption(
                id: '1',
                text: 'هادئ وقريب منك',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '2',
                text: 'واضح ومتوازن',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
              ),
              QuestionOption(
                id: '3',
                text: 'قوي ولافت',
                backGroundColor: AppColors.bgCanvas,
                primaryColor: AppColors.goldAccent.withValues(alpha: 0.14),
                secondaryColor: AppColors.goldAccent,
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

    AppThemeType? themeType = state.selectedThemeType;
    if (currentQuestion.id == '3') {
      if (selected.contains('1')) {
        themeType = AppThemeType.light;
      } else if (selected.contains('2')) {
        themeType = AppThemeType.dark;
      } else if (selected.contains('3')) {
        themeType = AppThemeType.normal;
      }
    }
    emit(
      state.copyWith(selectedOptions: selected, selectedThemeType: themeType),
    );
  }

  void next() {
    if (!canContinue) return;

    if (state.currentIndex >= state.questions.length - 1) {
      return;
    }

    emit(
      state.copyWith(currentIndex: state.currentIndex + 1, selectedOptions: {}),
    );
  }

  void skip() {
    if (!currentQuestion.isSkippable) return;

    if (state.currentIndex >= state.questions.length - 1) {
      return;
    }
    emit(
      state.copyWith(currentIndex: state.currentIndex + 1, selectedOptions: {}),
    );
  }

  bool get canContinue =>
      state.selectedOptions.length >= currentQuestion.minSelections;

  void previous() {
    if (state.currentIndex == 0) return;
    emit(
      state.copyWith(currentIndex: state.currentIndex - 1, selectedOptions: {}),
    );
  }
}
