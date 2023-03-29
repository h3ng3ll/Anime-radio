


import 'dart:async';


import 'package:anime_radio/src/databases/DatabaseImages/DatabaseImages.dart';
import 'package:anime_radio/src/databases/DatabaseImages/DatabaseMetalGenreImages.dart';
import 'package:anime_radio/src/databases/DatabaseRadioStations.dart';
import 'package:anime_radio/src/models/MusicGenre.dart';
import 'package:anime_radio/src/models/MusicStation.dart';
import 'package:anime_radio/src/models/Song.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/databases/DatabaseImages/DatabaseAnimeImages.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// late should separate SongsProvider to 2 Providers ,
/// first respond for Songs other one for Images .

/// Rule behaviour  temporary songs of session .

class SongsProvider extends ChangeNotifier {

  List<SavedSong> _haveBeenPlayingSongs = [];

  final FlutterRadioPlayer flutterRadioPlayer = FlutterRadioPlayer();

  final _stations = DatabaseRadioStations.getStations;

   int? activeStationIndex;
  final   BuildContext _context;
  late List<String>? Function (String? ) _metaFormat;

  String? _imgUrl ;



  late DatabaseImages _databaseImages  ;
  bool _isFirstRun = true ;



  SongsProvider(this._context) ;


  String? get imgUrl => _imgUrl;
  List<SavedSong> get haveBeenPlayingSongs => _haveBeenPlayingSongs;
  DatabaseImages get databaseImages => _databaseImages;

  Future<void> initRadioService(MusicStation musicStation , List<String>? Function (String? , ) metaFormat) async {
    if(_isFirstRun ){
     await _firstRun(musicStation , metaFormat);
    }
    else {
      if(_stations[activeStationIndex!] != musicStation) {
        flutterRadioPlayer.setUrl(
            musicStation.address,
            musicStation.name
        );
        activeStationIndex = _stations.indexOf(musicStation);
        _metaFormat = metaFormat ;
        changeImgPreview();
        // notifyListeners();
      }
    }
    
  }

  _firstRun (
      MusicStation musicStation ,
      List<String>? Function (String? ) metaFormat
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

    flutterRadioPlayer.metaDataStream?.listen((dirtString) async {

      if(dirtString == null) return ;
      final List<String>? newSong = _metaFormat(dirtString );
      if(newSong != null) {
        changeImgPreview();
        await _saveSong(newSong, _stations[activeStationIndex!].name);

        // notifyListeners();
      }
    });

    _metaFormat = metaFormat;
    activeStationIndex = _stations.indexOf(musicStation);
    _isFirstRun = false ;
    changeImgPreview();
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

  Future<void> _saveSong(List<String> meta, String musicStation) async {

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
    if (haveBeenPlayingSongs.isEmpty || haveBeenPlayingSongs.last.name != song.name) {
      /// after  new song save  to storage
       LocalStorageService.saveSong(song);

      addNewSong(song);
    }
  }


  
  void update() => notifyListeners();

  void changeLikeStatus (int index ) async {

    /// No song haven't added yet .
    if(_haveBeenPlayingSongs.isEmpty) return;

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
    await _firstRun(musicStation,musicStation.metaFormat);
    try {
      await flutterRadioPlayer.init(
          // ignore: use_build_context_synchronously
          AppLocalizations.of(_context)?.now_playing ?? "What now playing",
          "Live",
          musicStation.encAddress,
          "false",
          primaryColor: ColorService.ddGrey
      );
    } on PlatformException {
      throw Exception("Exception occurred while trying to register the services.");
    }
    await flutterRadioPlayer.play();
  }

  void changeImgPreview ({bool? update}) async {

    final settings = await LocalStorageService.getSettings();

    final setGenres = settings.selectedImageGenres!;

    ///  genre of station
    late DatabaseImagesGenres genre;

    /// What kind of genre this station is it ?
    if(_stations[activeStationIndex!].genres.contains(MusicGenre.anime)){
      /// Anime station
      genre = DatabaseImagesGenres.anime;
    }
    else {
      /// Metal station
      genre = DatabaseImagesGenres.metal;
    }

    /// Here's only 2 genres so far .
    switch (genre) {
      case DatabaseImagesGenres.anime:
        setGenres.elementAt(DatabaseImagesGenres.anime.index) ? _applyGenreAnime() :  _applyGenreMetal();
        break;

      case DatabaseImagesGenres.metal:
        setGenres.elementAt(DatabaseImagesGenres.metal.index)  ? _applyGenreMetal() : _applyGenreAnime() ;
        break;
    }
    if(update ?? false){
      notifyListeners();
    }
  }

  void _applyGenreMetal() {
    _imgUrl = DatabaseMetalGenreImages().randomImage();
    _databaseImages = DatabaseMetalGenreImages();
  }

  void _applyGenreAnime () {
    _imgUrl = DatabaseAnimeImages().randomImage();
    _databaseImages = DatabaseAnimeImages();
  }

}
