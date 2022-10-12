

import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/main.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier{

  Locale? _locale ;

  Locale? get locale => _locale;

  LocaleProvider() {
    LocalStorageService.getLocale().then((locale) => _locale = locale);
  }

  void setLocale (Locale locale , BuildContext context) {
    if(!L10n.all.contains(locale)) return ;
    _locale = locale ;

    MyApp.of(context).updateLocale(locale);
    notifyListeners();
  }

}