import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'language.dart';

final languageCodeProvider =
    StateNotifierProvider<LanguageCodeProviderNotifier, Language>((ref) {
  return LanguageCodeProviderNotifier();
});

class LanguageCodeProviderNotifier extends StateNotifier<Language> {
  LanguageCodeProviderNotifier() : super(getMobileLanguageCode());

  changeLanguage({required Language newLanguage}) {
    state = newLanguage;
  }
}

Language getMobileLanguageCode() {
  return Language.languageList()[1];
}
