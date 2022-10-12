
class Settings {

   bool removeImage;
   bool removeSoundSlider;
   bool removeListLastSongs;

  Settings(
      this.removeImage,
      this.removeSoundSlider,
      this.removeListLastSongs
  );


  static Settings fromJson (Map<String , dynamic> json ) => Settings(
      json['removeImage'],
      json['removeSoundSlider'],
      json['removeListLastSongs']
  );

  Map<String , dynamic> toJson () => {
    'removeImage' : removeImage,
    'removeSoundSlider' : removeSoundSlider,
    'removeListLastSongs' : removeListLastSongs
  };
}

