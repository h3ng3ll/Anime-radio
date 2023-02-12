

class Song {
  final String name  ;
  final String compositor ;

  Song(this.name, this.compositor);
}


class SavedSong extends Song {
  final DateTime whenPlayed ;

  SavedSong(super.name, super.compositor, this.whenPlayed);


  static SavedSong fromJson (Map<String , dynamic> json) => SavedSong(
      json['name'],
      json['compositor'],
      DateTime.parse(json['whenPlayed'])
  );

  Map<String , dynamic> toJson () => {
    'name'       : name ,
    'compositor' : compositor,
    'whenPlayed' : whenPlayed.toString()
  };
}