

import 'package:anime_radio/src/databases/DatabaseRadioStations.dart';
import 'package:anime_radio/src/models/MusicGenre.dart';

/// Describe any translated music address
///
///

class MusicStation {


  String? imgAddress ;

  
  ///getCountry index
  final int countryIndex; 
  
  final String encAddress ;

  String get address => DatabaseRadioStations().decodeString(encAddress);

  final String name ;

  bool favorite ;

  /// Does station provide information about
  /// played song .
  final bool noMeta ;

  /// basic check if site accessible to connect
  final String validateUrl ;

  final List<MusicGenre> genres ;

  /// fetch unfiltered metadata about playing song and
  /// for every case must be initialized
  final List<String>? Function (String? ) metaFormat;


  MusicStation({
    required this.validateUrl,
    required  this.metaFormat ,
    required this.encAddress ,
    required this.name ,
    this.imgAddress,
    this.favorite = false  ,
    this.genres = const [],
    required this.countryIndex,
    this.noMeta = false,
  });


}