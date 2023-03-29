
import 'dart:convert';

import 'package:anime_radio/src/databases/DatabaseImages/DatabaseImages.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Settings extends Equatable{

   bool showImageDuringPlaying;

   List<bool>? selectedImageGenres ;

   bool showSongsTable;


   /// turn off any animations
   bool disableAllAnimations;

   bool disableImageAnimations;

   bool disableLoadingStationAnimations;

   /// If station was loaded unsuccessfully then
   /// this field will rule state of loading station.
   bool showUnloadedStations;



  Settings({
    this.showUnloadedStations = true,
    this.showImageDuringPlaying = true,
    this.showSongsTable = true,
    this.disableAllAnimations = false,
    this.disableImageAnimations = false,
    this.disableLoadingStationAnimations = false,
    List<bool>? selectedImageGenres
   }) : selectedImageGenres = selectedImageGenres ?? List.generate(
      DatabaseImagesGenres.values.length, (index) => true);


  static Settings fromJson (Map<String , dynamic> json ) => Settings(
    showUnloadedStations: json['showUnloadedStations'],
    showImageDuringPlaying:   json['showImageDuringPlaying'],
    showSongsTable:   json['showSongsTable'],
    disableAllAnimations: json['disableAllAnimations'],
    disableImageAnimations: json['disableImageAnimations'],
    disableLoadingStationAnimations: json['disableLoadingStationAnimations'],
    selectedImageGenres: List<bool>.from(jsonDecode(json['selectedImageGenres'])),
  );

  Map<String , dynamic> toJson () => {
    'showUnloadedStations' : showUnloadedStations,
    'showImageDuringPlaying' : showImageDuringPlaying,
    'showSongsTable' : showSongsTable,
    'disableAllAnimations' : disableAllAnimations,
    'disableImageAnimations': disableImageAnimations,
    'disableLoadingStationAnimations': disableLoadingStationAnimations,
    'selectedImageGenres' : jsonEncode(selectedImageGenres),

  };

   void resetSettings () {
     showUnloadedStations = true;
     showImageDuringPlaying = true;
     showSongsTable = true;
     disableAllAnimations = false;
     disableImageAnimations = false;
     disableLoadingStationAnimations = false;
     selectedImageGenres = List.generate(DatabaseImagesGenres.values.length, (index) => false);
   }

  @override
  List<Object?> get props => [
    showUnloadedStations,
    showImageDuringPlaying ,
    showSongsTable,
    disableAllAnimations,
    disableImageAnimations,
    disableLoadingStationAnimations,
    selectedImageGenres,
  ];


}

