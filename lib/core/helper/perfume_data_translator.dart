import 'package:ya_perfume/core/translations/perfume_english_translations.dart';
import 'package:ya_perfume/core/translations/perfume_french_translations.dart';
import 'package:ya_perfume/core/translations/perfume_italian_translations.dart';
import 'package:ya_perfume/core/translations/perfume_russian_translations.dart';

abstract final class PerfumeDataTranslator {
  static const Map<String, String> _aliases = {
    'نسائى': 'نسائي',
    'حلو ومستوحي من الحلوى': 'حلو ومستوحى من الحلوى',
    'حلو ومستوحي من الحلوي': 'حلو ومستوحى من الحلوى',
    'حلوي ومستوحي من الحلوى': 'حلو ومستوحى من الحلوى',
    'شرقي دافئ': 'شرقي ودافئ',
    'نظيف ومسكي بروائح البودرة': 'نظيف ومسكي وبروائح البودرة',
  };

  static String translate(
    String value, {
    required String languageCode,
  }) {
    final text = value.trim();
    final language = languageCode.toLowerCase().split(RegExp('[-_]')).first;

    if (language == 'ar') return value;

    final key = _aliases[text] ?? text;

    final Map<String, String> translations = switch (language) {
      'en' => PerfumeEnglishTranslations.values,
      'fr' => PerfumeFrenchTranslations.values,
      'ru' => PerfumeRussianTranslations.values,
      'it' => PerfumeItalianTranslations.values,
      _ => const <String, String>{},
    };

    return translations[key] ?? value;
  }

  static List<String> translateList(
    List<String> values, {
    required String languageCode,
  }) {
    return values
        .map(
          (value) => translate(
            value,
            languageCode: languageCode,
          ),
        )
        .toList(growable: false);
  }
}