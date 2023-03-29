

import 'dart:convert';

import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/src/models/Settings.dart';
import 'package:anime_radio/src/models/Song.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {



  static Future _saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    }
    else {
      throw Exception("Trying save data to LocalStorage with Invalid type");
    }
  }

  /// SONG
  static Future<void> saveSong (SavedSong newSong) async {
    final oldSongs = await  restoreSongs();

    final allSongs = [...oldSongs , newSong];

    _saveData(
        "songList",
        /// ... => SavedSong => String(SavedSong to Map<...>).toList<String>
        allSongs.map((song) => jsonEncode(song.toJson())).toList());
  }

  /// Change status that songs which added recently from SongProvider only
  /// Used when at least 1 song added
  static Future<void> changeLikeStatusOfSongSession (bool status , int index , int length) async {
    List<SavedSong> oldSongs = await  restoreSongs();

    /// same as reversed "songs.length - index -1"
   oldSongs.reversed.take(length).elementAt(length - index - 1 ).favoriteSong = status;

   _saveData("songList", oldSongs.map((song) => jsonEncode(song.toJson())).toList());

  }

  static Future<void> changeLikeStatusOfSongLocally (bool status , int index) async {
    List<SavedSong> oldSongs = await  restoreSongs();

    oldSongs[index].favoriteSong = status;

    _saveData(
        "songList",
        /// ... => SavedSong => String(SavedSong to Map<...>).toList<String>
        oldSongs.map((song) => jsonEncode(song.toJson())).toList());

  }

  static Future<List<SavedSong>> restoreSongs () async {
    final pref = await SharedPreferences.getInstance();

    final List<String>? encodedSongs = pref.getStringList("songList");

    if(encodedSongs == null) return [];

    final List<Map<String , dynamic>> decodedJsonSongs =
        encodedSongs.map((encodedSong) =>
        jsonDecode(encodedSong) as Map<String , dynamic>).toList();

    /// convert Json files into class the  SavedSong
    /// and return
    return decodedJsonSongs.map((jsonSong) =>
        SavedSong.fromJson(jsonSong)).toList();
  }
  static Future<void> resetSongsListWithFilter () async {
    final pref = await SharedPreferences.getInstance();

    await pref.setStringList("songList", []);
    await pref.setStringList("UnVisibleFilter", []);

  }

  /// SETTINGS
  static Future<Settings> getSettings () async {
    final prefs = await SharedPreferences.getInstance();

    final encodedSettings = prefs.getString("settings");

    if(encodedSettings == null) return Settings();

    final decodedSettings = jsonDecode(encodedSettings) as Map<String , dynamic>;

    return Settings.fromJson(decodedSettings);

  }
  static Future<void> saveSettings (Settings settings) async {
    final decodeSettings = jsonEncode(settings.toJson());
    await _saveData("settings", decodeSettings);
  }

  /// THEME
  static Future<ThemeMode> getTheme () async{
    final pref = await SharedPreferences.getInstance();

    final String? restoreMode = pref.getString("themeMode");

    switch (restoreMode) {
      case "light": return  ThemeMode.light ;
      case  "dark": return  ThemeMode.dark ;
      default:      return  ThemeMode.system;
    }
  }

  /// LOCALE
  static Future<Locale?> getLocale () async {
    final pref = await SharedPreferences.getInstance();
    /// store locale index
    final int? localeIndex = pref.getInt("locale");
    if(localeIndex == null) return null ;

    return L10n.all[localeIndex];
  }
  /// store locale index
  static Future<void> saveLocale (Locale locale) async
  => await _saveData("locale", L10n.all.indexOf(locale));

  /// IMAGE SCALE
  static Future<void> saveScaleImagePosition (double scale) async {
    await _saveData("scaleImagePosition", scale);
  }
  static Future<double?> getScaleImagePosition () async {
    final pref = await SharedPreferences.getInstance();
    return  pref.getDouble("scaleImagePosition");
  }

  /// Favorite songStations
  static Future<void> saveFavoriteSongStations (List<bool> songsStatus) async {
    final listStrings = songsStatus.map((e) => e.toString()).toList();
    await _saveData("favoriteSongStations", listStrings);
  }

  static Future<List<bool>?> getFavoriteSongStations () async {
    final pref = await SharedPreferences.getInstance();
    final favSongs =  pref.getStringList("favoriteSongStations");

    if(favSongs == null ) return null;

    final songs = favSongs.map((status) => status == "true" ).toList();
    return songs;
  }

  static Future<double?> getScrollPositionAllPlayedSongs () async {
    final pref = await SharedPreferences.getInstance();
    return  pref.getDouble("ListPlayedSongsPosition");
  }
  static Future<void> saveScrollPositionAllPlayedSongs (double position) async =>
      await _saveData("ListPlayedSongsPosition", position);


  static Future<double?> getScrollPositionAllFvrtSongs () async {
    final pref = await SharedPreferences.getInstance();
    return  pref.getDouble("ListPlayedSongsPositionFvrt");
  }

  static Future<void> saveScrollPositionAllFvrtSongs (double position) async =>
      await _saveData("ListPlayedSongsPositionFvrt", position);

  /// used at ListPlayedSongs page
  static Future<List<DateTime>?> getUnVisibleFilter () async {
    final pref = await SharedPreferences.getInstance();
    List<String>? encodedFilter =  pref.getStringList("UnVisibleFilter");

    if(encodedFilter == null) return null;

    return encodedFilter.map((String filter) {

      final decFilter = jsonDecode(filter) as Map<String , dynamic>;

      return DateTime(
        decFilter['year']! ,
        decFilter['month']! ,
        decFilter['day']! ,
      );
    }).toList();
  }


  /// use at ListPlayedSongs page
  static Future<void> saveUnVisibleFilter (List<DateTime> dates) async {
    final  encodedDates = dates.map((date) {

      final dateJson =  {
        'year' : date.year,
      'month' : date.month ,
      'day' : date.day
      };

      return jsonEncode(dateJson);
    }).toList();

    await _saveData("UnVisibleFilter", encodedDates);
  }

  static Future<int?> getSongStationsPageIndex() async {
    final pref = await SharedPreferences.getInstance();
    return  pref.getInt("songStationsPageIndex");
  }

  static Future<void> saveSongStationsPageIndex(int index) async =>
      await _saveData("songStationsPageIndex", index);

  /// SavedSong page number

  static Future<int?> getSavedSongsPageIndex() async {
    final pref = await SharedPreferences.getInstance();
    return  pref.getInt("savedSongsPageIndex");
  }

  static Future<void> saveSongsPageIndex(int index) async =>
      await _saveData("savedSongsPageIndex", index);

  /// Home page 1 page : Scrollcontroller position Value

  static Future<double?> getStsPgePos() async {
    final pref = await SharedPreferences.getInstance();
    return  pref.getDouble("saveStationsPagePosition");
  }

  static Future<void> saveStsPgePos (double position) async =>
      await _saveData("saveStationsPagePosition", position);

  /// Home page 2 page : Scrollcontroller position Value

  static Future<double?> getFvtStsPgePos() async {
    final pref = await SharedPreferences.getInstance();
    return  pref.getDouble("saveFavoriteStationsPagePosition");
  }

  static Future<void> saveFvtStsPgePos (double position) async =>
      await _saveData("saveFavoriteStationsPagePosition", position);
}