


import 'dart:async';
import 'dart:math';

import 'package:anime_radio/src/models/MusicStation.dart';
import 'package:anime_radio/src/models/Song.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/services/ImageService.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



/// Rule behaviour  temporary songs of session .

class SongsProvider extends ChangeNotifier {

  List<SavedSong> _haveBeenPlayingSongs = [];

  final FlutterRadioPlayer flutterRadioPlayer = FlutterRadioPlayer();

  late String activeStation;
  late BuildContext _context;
  late List<String>? Function (String? , String) _metaFormat;
  late String _imgUrl ;

  bool _isFirstRun = true ;


  SongsProvider({ required BuildContext context}) {
    _context = context ;
    changeImgPreview();


  }

  /// List Radio Stations
  /// It can either break or change on other one
  /// Support stable migration between stations .

  String get imgUrl => _imgUrl;
  List<SavedSong> get haveBeenPlayingSongs => _haveBeenPlayingSongs;

  Future<void> initRadioService(MusicStation musicStation , List<String>? Function (String? , String) metaFormat) async {
    if(_isFirstRun ){
     await _firstRun(musicStation , metaFormat);
    }
    else {
      if(activeStation != musicStation.name) {
        flutterRadioPlayer.setUrl(musicStation.address, musicStation.name);
        activeStation = musicStation.name;
        _metaFormat = metaFormat ;
      }
    }
    
  }

  _firstRun (
      MusicStation musicStation ,
      List<String>? Function (String? , String) metaFormat
  ) async {
    try {
      await flutterRadioPlayer.init(
          AppLocalizations.of(_context)?.now_playing ?? "What now playing",
          "Live",
          musicStation.address,
          "false",
          primaryColor: ColorService.ddGrey
      );
    } on PlatformException {
      throw Exception("Exception occurred while trying to register the services.");
    }

    flutterRadioPlayer.metaDataStream?.listen((dirtString) {

      if(dirtString == null) return ;
      final List<String>? newSong = _metaFormat(dirtString , activeStation);
      if(newSong != null) {
        _saveSong(newSong, activeStation);
        changeImgPreview();

        notifyListeners();
      }
    });

    _metaFormat = metaFormat;
    activeStation = musicStation.name;
    _isFirstRun = false ;
  }


  /// add temp song in order to show to an user
  void addNewSong(SavedSong song) {
    _haveBeenPlayingSongs.add(song);
    notifyListeners();
  }

  /// clear songs
  void clearSongs() {
    _haveBeenPlayingSongs = [];
    notifyListeners();
  }

  void _saveSong(List<String> meta, String musicStation) async {

    /// 0 - song
    /// 1 - compositor
    /// 2 - anime
    SavedSong  song = SavedSong(
        name: meta[0],
        compositor: meta[1],
        whenPlayed: DateTime.now(),
        musicStation: musicStation,
    );


    /// check if same song added twice
    if (haveBeenPlayingSongs.isEmpty || haveBeenPlayingSongs.last.name != meta[0]) {
      /// after  new song save  to storage
      await LocalStorageService.saveSong(song);

      addNewSong(song);
    }
  }

  void changeImgPreview () {
    _imgUrl = ImageService.images[Random().nextInt(ImageService.images.length-1)];
  }

  void changeLikeStatus (int index ) async {
    /// change at user time

    _haveBeenPlayingSongs[index].favoriteSong = !_haveBeenPlayingSongs[index].favoriteSong;

    /// save to Local Storage
    await LocalStorageService.changeLikeStatusOfSongSession(
        _haveBeenPlayingSongs[index].favoriteSong,
        index,
        haveBeenPlayingSongs.length
    );

  }

  /// Used in case closing tab player .
  Future<void> hardReload (MusicStation musicStation) async {
    // await _firstRun(musicStation,musicStation.metaFormat);
    try {
      await flutterRadioPlayer.init(
          AppLocalizations.of(_context)?.now_playing ?? "What now playing",
          "Live",
          musicStation.address,
          "false",
          primaryColor: ColorService.ddGrey
      );
    } on PlatformException {
      throw Exception("Exception occurred while trying to register the services.");
    }
    await flutterRadioPlayer.play();
  } 

}
