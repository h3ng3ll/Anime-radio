

import 'package:anime_radio/src/models/MusicStation.dart';

class RadioStationService {
  
  static List <MusicStation> getStations = [

    /// Anison.fm

    MusicStation(
      validateUrl: 'https://anison.fm/',
      address: "https://pool.anison.fm/AniSonFM(128)" ,
        imgAddress: "https://en.anison.fm/images/logo_f.png",
        name: "Anison.fm",
        metaFormat: (String? meta , String activeStation) {
          RegExp radioPreview = RegExp('Anison.FM');

          if(meta == null || radioPreview.hasMatch(meta)) return null ;
          final part1 = meta.split(',')[0];

          /// Example: title=\"Wolf's Rain (Maaya Sakamoto) - Gravity\"
          final pattern = RegExp(r'''title=\\?"[\w!'\s,-\\()]*"''');
          final part2 = pattern.stringMatch(part1);

          if(part2 == "title=\" - \"" || part2 == null ) return null;

          final part3 = part2.substring(7 , part2.length-2);

          final split = part3.split(RegExp(r"\s-\s"));

          final compositorPattern = RegExp(r"\((.*?)\)");

          late String song ;
          if(split[1] == ""){
            song = "unknown";
          } else {
            song = split[1];
          }

          late String anime;
          late String compositor; /// or band

          if(compositorPattern.hasMatch(split[0])){

            final animePart1 = compositorPattern.stringMatch(split[0]) as String;
            anime = animePart1.substring(1 , animePart1.length-1);

           compositor = split[0].split("(")[0];
          }
          else {
            anime = "unknown";
            compositor = split[0];
          }

          return  <String>[song , compositor , anime];
        },
    ),

    /// Animeradio.su

    MusicStation(
        address: "http://animeradio.su:8000",
        validateUrl: 'http://animeradio.su:8000',
        name: "Animeradio.su",
        metaFormat: (String? meta , String activeStation) {
          /// It seems they already haven't been servicing . No have any idea why .
          return [];
        },
    ),

    /// Radio Nami

    MusicStation(
        validateUrl: 'http://5.9.2.139:8000',
        address: 'http://5.9.2.139:8000/any-anime.ru',
        name: 'Radio Nami',
        imgAddress: 'https://radionami.com/style/horo.png',
        metaFormat: (String? meta , String activeStation) {
          if (
            meta == null ||
            activeStation != "Radio Nami"
          ) return null;

          final part1 = meta.split(',')[0];
          final pattern = RegExp(r'title="*"');
          final part2 = part1.split(pattern)[1];
          final part3  =  part2.substring(0, part2.length - 1).split(r"-");

          final  song = part3[0] ;
          final compositor = part3[1];
          return [song , compositor];
        },
    ),

    /// AnimeRadio.de

    MusicStation(
      validateUrl: 'http://stream.animeradio.de',
      address: "http://stream.animeradio.de/animeradio.mp3",
        name: "AnimeRadio.de",
        imgAddress: "https://www.animeradio.de/img/animeradio-stream-mp3-192.jpg",
        metaFormat: (String? meta , String activeStation) {
          if (
          meta == null ||
              activeStation != "AnimeRadio.de"
          ) return null;

          final part1 = meta.split(',')[0];
          final pattern = RegExp(r'title="*"');
          final part2 = part1.split(pattern)[1];

          if(part2.substring(0 , part2.length -1 ) == "AnimeRadio.de - Impact") return null ;

          final part3  =  part2.substring(0, part2.length - 1).split(r"-");

          final  song = part3[0] ;
          final compositor = part3[1];
          return [song , compositor];
        },
    ),

    /// Tsubaki Radio

    MusicStation(
        validateUrl: 'http://tsubakianimeradio.com/',
        address: "http://stream.tsubakianimeradio.com:9000/play.mp3",
        imgAddress: "http://tsubakianimeradio.com/wp-content/uploads/2020/08/logo-new.png",
        name: "Tsubaki Radio",
        metaFormat: (String? meta , String activeStation) {

          if(meta == null) return null;



          final pattern = RegExp(r'title=\\?"[\][\w\s&-.,\u0080-\u00FF\\]*"');
          final part1 = pattern.stringMatch(meta)!;
          final part2  =  part1.substring(0, part1.length - 1).split(RegExp(r'''\s-(\\"|\s)'''));

          /// not full meta information
          if(part2.length < 2){
            return null;
          }

          String compositor ;
          String song ;
          String? anime ;

          compositor = part2[0].replaceAll(RegExp(r'title=\\?"'), "");

          song = part2[1].replaceAll(RegExp(r"-$"), "");

          if(part2.length > 2  && part2[2] != ""){
            anime = part2[2].replaceAll(RegExp(r"\[|\]"), "");

          }

          if(anime ==  null){
            return [song , compositor ];
          }
          else {
            return [song , compositor , anime];
          }


        }
    )
    
  ];
}