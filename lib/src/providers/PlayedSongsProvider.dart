


import 'package:anime_radio/src/models/Song.dart';

class PlayedSongsProvider  {

  List<SavedSong> songs = [];

  late double offsetAllSongs ;
  late double offsetFavoriteSongs  ;
  List<DateTime> unVisibleFilter = [];



  List<SavedSong> get favoriteSongs {
    final List<SavedSong> fvtSongs = [];

    for (var element in songs) {
      if(element.favoriteSong) {
        fvtSongs.add(element);
      }
    }
    return fvtSongs;
  }


  void initialize ({
    required List<SavedSong> songs,
     double? offsetFavoriteSongs,
     double? offsetAllSongs,
    required List<DateTime> unVisibleFilter
  }) {
    this.songs = songs;
    this.unVisibleFilter = unVisibleFilter;
    this.offsetAllSongs = offsetAllSongs ?? 1.0;
    this.offsetFavoriteSongs = offsetFavoriteSongs ?? 1.0;
  }


  void clearSongs () {
    offsetAllSongs = 1.0;
    offsetFavoriteSongs = 1.0;
    unVisibleFilter = [];
  }


}