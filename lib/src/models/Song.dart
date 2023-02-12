

class Song {
  final String name  ;
  final String compositor ;

  Song({required this.name, required this.compositor});
}


class SavedSong extends Song {

  final String musicStation ;
  final DateTime whenPlayed ;
  bool favoriteSong = false ;

  SavedSong({
    required super.name,
    required super.compositor,
    required this.whenPlayed,
    required  this.musicStation,
      this.favoriteSong = false
  });


  static SavedSong fromJson (Map<String , dynamic> json) => SavedSong(
      name: json['name'],
      compositor: json['compositor'],
      whenPlayed: DateTime.parse(json['whenPlayed']),
      musicStation: json['musicStation'],
      favoriteSong: json['favoriteSong'] ?? false,
  );

  Map<String , dynamic> toJson () => {
    'name'       : name ,
    'compositor' : compositor,
    'whenPlayed' : whenPlayed.toString(),
    'musicStation' : musicStation,
    'favoriteSong' : favoriteSong,
  };
}