

import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/src/models/ContriesList.dart';
import 'package:anime_radio/src/models/MusicGenre.dart';
import 'package:anime_radio/src/models/StationFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterStationProvider  extends ChangeNotifier{

  int _localeIndex (BuildContext context) => L10n.nameLanguages.indexOf(AppLocalizations.of(context)!.language);


  /// constants
  List<String> countriesList (BuildContext context) =>
      CountriesList().getCountry(L10n.all[_localeIndex(context)].languageCode);


  /// persistent var
  StationFilter filter = StationFilter();

  /// tempuary vars

  MusicGenre genre = MusicGenre.values.first;
  int countryIndex = 0;

  bool get isActiveFilter => filter != StationFilter();


  void resetFilter () {
    filter = StationFilter();

    notifyListeners();
  }
  void update ( ) {
    notifyListeners();
  }

}