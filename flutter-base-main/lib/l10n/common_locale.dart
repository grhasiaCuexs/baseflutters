import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myeshop/coreapp/helpers/constants.dart';
import 'package:myeshop/l10n/app_localizations.dart';

class CommonLocale {
  static const List<Locale> supportedLocales = [
    Locale(Constants.localeID),
    Locale(Constants.localeEN),
  ];

  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
