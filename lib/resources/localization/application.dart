import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/@core/constants.dart';
import 'package:flutter_to_do/resources/localization/app_translations_delegate.dart';

class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();

  GlobalKey<NavigatorState> _navigatorKey;

  final List<String> supportedLanguages = [
    "Japanese",
    "English",
  ];

  final List<String> supportedLanguagesCodes = [
    AppConstants.JA_CODE,
    AppConstants.EN_CODE,
  ];

  //returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));

  //function to be invoked when changing the language
  LocaleChangeCallback onLocaleChanged;

  GlobalKey<NavigatorState> getNavigatorKey({
    bool isGenNewKey = false,
  }) {
    if (isGenNewKey) {
      _navigatorKey = GlobalKey<NavigatorState>();
    }
    return _navigatorKey;
  }

  BuildContext getCurrentContext() => _navigatorKey.currentState.context;
}

Application application = Application();
AppTranslationsDelegate newLocaleDelegate;
String langCode;

typedef void LocaleChangeCallback(Locale locale);

Future<void> initLangCode() async {
  langCode = AppConstants.JA_CODE;
}
