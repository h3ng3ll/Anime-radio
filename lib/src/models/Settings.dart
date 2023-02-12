
class Settings {

   bool showImageDuringPlaying;
   bool showSongsTable;

   /// If station was loaded unsuccessfully then
   /// this field will rule state of loading station.
   bool showUnloadedStations;
   
  Settings({
    this.showUnloadedStations = true,
    this.showImageDuringPlaying = true,
    this.showSongsTable = true,
  });
  
  static Settings fromJson (Map<String , dynamic> json ) => Settings(
    showUnloadedStations: json['showUnloadedStations'],
    showImageDuringPlaying:   json['showImageDuringPlaying'],
    showSongsTable:   json['showSongsTable']
  );

  Map<String , dynamic> toJson () => {
    'showUnloadedStations' : showUnloadedStations,
    'showImageDuringPlaying' : showImageDuringPlaying,
    'showSongsTable' : showSongsTable
  };

   void resetSettings () {
     showUnloadedStations = true;
     showImageDuringPlaying = true;
     showSongsTable = true;
   }
}

