import 'package:flutter/material.dart';
import 'package:myeshop/l10n/app_localizations.dart';

extension AppLocalizationExt on BuildContext {
  AppLocalizations getAppLocalizations() => AppLocalizations.of(this)!;
  String get currentLanguageCode => Localizations.localeOf(this).languageCode;
}
