

import 'package:anime_radio/src/models/MusicGenre.dart';
import 'package:equatable/equatable.dart';

class StationFilter with EquatableMixin {

   List<MusicGenre> genres = [];
   List<int> countryIndexes = [];

  StationFilter();


  addGenre (MusicGenre genre) {
    if(!genres.contains(genre)){
      genres.add(genre);
    }
  }

  addCounty (int index) {
    if(!countryIndexes.contains(index)){
      countryIndexes.add(index);
    }
  }

  removeGenre (int index) {
    genres.removeAt(index);
  }

  removeCountry(int index){
    countryIndexes.removeAt(index);
  }

  @override
  List<Object?> get props => [genres , countryIndexes];
}