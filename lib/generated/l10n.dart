// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `General information`
  String get general_information {
    return Intl.message(
      'General information',
      name: 'general_information',
      desc: '',
      args: [],
    );
  }

  /// `Light theme`
  String get light_theme {
    return Intl.message(
      'Light theme',
      name: 'light_theme',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get dark_theme {
    return Intl.message(
      'Dark theme',
      name: 'dark_theme',
      desc: '',
      args: [],
    );
  }

  /// `Now playing`
  String get now_playing {
    return Intl.message(
      'Now playing',
      name: 'now_playing',
      desc: '',
      args: [],
    );
  }

  /// `Information about track is lost`
  String get info_lost {
    return Intl.message(
      'Information about track is lost',
      name: 'info_lost',
      desc: '',
      args: [],
    );
  }

  /// `This app created by`
  String get created_by {
    return Intl.message(
      'This app created by',
      name: 'created_by',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedBack {
    return Intl.message(
      'Feedback',
      name: 'feedBack',
      desc: '',
      args: [],
    );
  }

  /// `Images taken from `
  String get img_taken_from {
    return Intl.message(
      'Images taken from ',
      name: 'img_taken_from',
      desc: '',
      args: [],
    );
  }

  /// `Radio is broadcasting at `
  String get radio_broadcasting {
    return Intl.message(
      'Radio is broadcasting at ',
      name: 'radio_broadcasting',
      desc: '',
      args: [],
    );
  }

  /// `Play recently`
  String get play_recently {
    return Intl.message(
      'Play recently',
      name: 'play_recently',
      desc: '',
      args: [],
    );
  }

  /// `Saved songs`
  String get saved_songs {
    return Intl.message(
      'Saved songs',
      name: 'saved_songs',
      desc: '',
      args: [],
    );
  }

  /// `Show all played songs`
  String get show_all_played_songs {
    return Intl.message(
      'Show all played songs',
      name: 'show_all_played_songs',
      desc: '',
      args: [],
    );
  }

  /// `Find song`
  String get find_song {
    return Intl.message(
      'Find song',
      name: 'find_song',
      desc: '',
      args: [],
    );
  }

  /// `Find`
  String get find {
    return Intl.message(
      'Find',
      name: 'find',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove songs ?`
  String get remove_songs_alert {
    return Intl.message(
      'Are you sure you want to remove songs ?',
      name: 'remove_songs_alert',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Compositor`
  String get compositor {
    return Intl.message(
      'Compositor',
      name: 'compositor',
      desc: '',
      args: [],
    );
  }

  /// `Song`
  String get song {
    return Intl.message(
      'Song',
      name: 'song',
      desc: '',
      args: [],
    );
  }

  /// `When played`
  String get when_played {
    return Intl.message(
      'When played',
      name: 'when_played',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Show image during playing`
  String get show_image_during_playing {
    return Intl.message(
      'Show image during playing',
      name: 'show_image_during_playing',
      desc: '',
      args: [],
    );
  }

  /// `Show table with songs`
  String get show_table_with_songs {
    return Intl.message(
      'Show table with songs',
      name: 'show_table_with_songs',
      desc: '',
      args: [],
    );
  }

  /// `Sound slider`
  String get remove_slider {
    return Intl.message(
      'Sound slider',
      name: 'remove_slider',
      desc: '',
      args: [],
    );
  }

  /// `Auto settings`
  String get auto_settings {
    return Intl.message(
      'Auto settings',
      name: 'auto_settings',
      desc: '',
      args: [],
    );
  }

  /// `Navigation`
  String get navigation {
    return Intl.message(
      'Navigation',
      name: 'navigation',
      desc: '',
      args: [],
    );
  }

  /// `About app`
  String get about_app {
    return Intl.message(
      'About app',
      name: 'about_app',
      desc: '',
      args: [],
    );
  }

  /// `Send bugs and errors`
  String get send_bugs_and_errors {
    return Intl.message(
      'Send bugs and errors',
      name: 'send_bugs_and_errors',
      desc: '',
      args: [],
    );
  }

  /// `Go to settings`
  String get go_to_settings {
    return Intl.message(
      'Go to settings',
      name: 'go_to_settings',
      desc: '',
      args: [],
    );
  }

  /// `Station`
  String get station {
    return Intl.message(
      'Station',
      name: 'station',
      desc: '',
      args: [],
    );
  }

  /// `More about app`
  String get more_app_info {
    return Intl.message(
      'More about app',
      name: 'more_app_info',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load station`
  String get failed_to_load_station {
    return Intl.message(
      'Failed to load station',
      name: 'failed_to_load_station',
      desc: '',
      args: [],
    );
  }

  /// `Reset settings`
  String get reset {
    return Intl.message(
      'Reset settings',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Show unsuccessfully loaded stations`
  String get show_unsuccessfully_loaded_stations {
    return Intl.message(
      'Show unsuccessfully loaded stations',
      name: 'show_unsuccessfully_loaded_stations',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get no_internet_connection {
    return Intl.message(
      'No internet connection',
      name: 'no_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Image successfully has been saved to `
  String get image_successfully_has_been_saved_to {
    return Intl.message(
      'Image successfully has been saved to ',
      name: 'image_successfully_has_been_saved_to',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Storage permission haven't been granted`
  String get storage_permission_have_not_granted {
    return Intl.message(
      'Storage permission haven\'t been granted',
      name: 'storage_permission_have_not_granted',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `All songs`
  String get all_songs {
    return Intl.message(
      'All songs',
      name: 'all_songs',
      desc: '',
      args: [],
    );
  }

  /// `Favorite songs`
  String get favorite_songs {
    return Intl.message(
      'Favorite songs',
      name: 'favorite_songs',
      desc: '',
      args: [],
    );
  }

  /// `All stations`
  String get all_stations {
    return Intl.message(
      'All stations',
      name: 'all_stations',
      desc: '',
      args: [],
    );
  }

  /// `Favorite stations`
  String get favorite_stations {
    return Intl.message(
      'Favorite stations',
      name: 'favorite_stations',
      desc: '',
      args: [],
    );
  }

  /// `Version `
  String get version {
    return Intl.message(
      'Version ',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save image to`
  String get failed_to_save_image {
    return Intl.message(
      'Failed to save image to',
      name: 'failed_to_save_image',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Genre`
  String get genre {
    return Intl.message(
      'Genre',
      name: 'genre',
      desc: '',
      args: [],
    );
  }

  /// `Genre`
  String get by_genre {
    return Intl.message(
      'Genre',
      name: 'by_genre',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sort_by {
    return Intl.message(
      'Sort by',
      name: 'sort_by',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `by Location `
  String get by_location {
    return Intl.message(
      'by Location ',
      name: 'by_location',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load an image`
  String get failed_to_load_an_image {
    return Intl.message(
      'Failed to load an image',
      name: 'failed_to_load_an_image',
      desc: '',
      args: [],
    );
  }

  /// `This station isn't grant information about played track`
  String get this_station_is_not_grant_inforation_about_played_track {
    return Intl.message(
      'This station isn\'t grant information about played track',
      name: 'this_station_is_not_grant_inforation_about_played_track',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Disable all animations`
  String get disable_all_animations {
    return Intl.message(
      'Disable all animations',
      name: 'disable_all_animations',
      desc: '',
      args: [],
    );
  }

  /// `Disable image animation`
  String get disable_image_animation {
    return Intl.message(
      'Disable image animation',
      name: 'disable_image_animation',
      desc: '',
      args: [],
    );
  }

  /// `Disable loading station animations`
  String get disable_loading_station_animations {
    return Intl.message(
      'Disable loading station animations',
      name: 'disable_loading_station_animations',
      desc: '',
      args: [],
    );
  }

  /// `Show genres of image`
  String get show_genres_of_image {
    return Intl.message(
      'Show genres of image',
      name: 'show_genres_of_image',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Here's must be even one selected item or you can disable all options which is located above.`
  String get here_is_must_be_even_one_selected_item {
    return Intl.message(
      'Here\'s must be even one selected item or you can disable all options which is located above.',
      name: 'here_is_must_be_even_one_selected_item',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
