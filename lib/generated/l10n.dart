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

  /// `Now play`
  String get now_play {
    return Intl.message(
      'Now play',
      name: 'now_play',
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

  /// `Unofficial anime radio`
  String get unofficial_app {
    return Intl.message(
      'Unofficial anime radio',
      name: 'unofficial_app',
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

  /// `Image during playing`
  String get remove_image_while_playing {
    return Intl.message(
      'Image during playing',
      name: 'remove_image_while_playing',
      desc: '',
      args: [],
    );
  }

  /// `Show table with songs`
  String get do_not_show_last_song_table {
    return Intl.message(
      'Show table with songs',
      name: 'do_not_show_last_song_table',
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

  /// `App sources`
  String get app_sources {
    return Intl.message(
      'App sources',
      name: 'app_sources',
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
