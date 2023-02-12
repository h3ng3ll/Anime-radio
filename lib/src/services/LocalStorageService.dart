

import 'dart:convert';

import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/src/models/Settings.dart';
import 'package:anime_radio/src/models/Song.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {



  static Future saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
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
  static Future<void> saveSong (List<SavedSong> newSongs) async {
    final oldSongs = await  restoreSongs();

    final allSongs = [...oldSongs , ...newSongs];

    saveData(
        "songList",
        /// ... => SavedSong => String(SavedSong to Map<...>).toList<String>
        allSongs.map((song) => jsonEncode(song.toJson())).toList());
  }
  static Future<List<SavedSong>> restoreSongs () async {
    final pref = await SharedPreferences.getInstance();

    final List<String>? encodedSongs = pref.getStringList("songList");

    if(encodedSongs == null) return [];

    final List<Map<String , dynamic>> decodedJsonSongs =
        encodedSongs.map((encodedSong) =>
        jsonDecode(encodedSong) as Map<String , dynamic>).toList();

    /// convert Jsons files into class the  SavedSong
    /// and return
    return decodedJsonSongs.map((jsonSong) =>
        SavedSong.fromJson(jsonSong)).toList();
  }
  static Future<void> resetSongsList () async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList("songList", []);
  }

  /// SETTINGS
  static Future<Settings> getSettings () async {
    final prefs = await SharedPreferences.getInstance();

    final encodedSettings = prefs.getString("settings");

    if(encodedSettings == null) return Settings(true , true, true);

    final decodedSettings = jsonDecode(encodedSettings) as Map<String , dynamic>;

    return Settings.fromJson(decodedSettings);

  }
  static Future<void> saveSettings (Settings settings) async {
    final decodeSettings = jsonEncode(settings.toJson());
    await saveData("settings", decodeSettings);
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
  => await saveData("locale", L10n.all.indexOf(locale));

}