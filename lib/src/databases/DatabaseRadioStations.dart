



import 'dart:convert';

import 'package:anime_radio/src/models/ContriesList.dart';
import 'package:anime_radio/src/models/MusicGenre.dart';
import 'package:anime_radio/src/models/MusicStation.dart';


enum ProcessStringPattern {
  // ignore: constant_identifier_names,
  oneTwo_three ,   /// ${1 + 2} , $3
  // ignore: constant_identifier_names
  one_two_three ,  /// $1 , $2 , $3
  // ignore: constant_identifier_names
  two_one_three ,
  // ignore: constant_identifier_names
  two_one , /// $2 , $1
}

class DatabaseRadioStations {



  String decodeString (String url) => utf8.fuse(base64).decode(url);

  static List <MusicStation> getStations = [

    /// Anison.fm

    MusicStation(
      validateUrl: 'https://anison.fm/',
      genres: [
        MusicGenre.anime ,
        MusicGenre.metal ,
        MusicGenre.metalcore ,
      ],
      // address: "https://pool.anison.fm/AniSonFM(128)" ,
      encAddress: "aHR0cHM6Ly9wb29sLmFuaXNvbi5mbS9BbmlTb25GTSgxMjgp" ,
      imgAddress: "https://en.anison.fm/images/logo_f.png",
      name: "Anison.fm",
      metaFormat: (meta ) {

        final metaParts = meta?.split(RegExp(r'\(|\)'));

        final meta2 = "${metaParts?[0]}- ${metaParts?[1]}${metaParts?[2]}";

        if(metaParts != null){
          return metaFormat(
            meta2,

          );
        }
        return metaFormat(meta );

      },
      // metaFormat: (String? meta ,  ) {
      //   RegExp radioPreview = RegExp('Anison.FM');
      //
      //   if(meta == null || radioPreview.hasMatch(meta)) return null ;
      //   final part1 = meta.split(',')[0];
      //
      //   /// Example: title=\"Wolf's Rain (Maaya Sakamoto) - Gravity\"
      //   final pattern = RegExp(r'''title=\\?"[\w!'\s,-\\()]*"''');
      //   final part2 = pattern.stringMatch(part1);
      //
      //   if(part2 == "title=\" - \"" || part2 == null ) return null;
      //
      //   final part3 = part2.substring(7 , part2.length-2);
      //
      //   final split = part3.split(RegExp(r"\s-\s"));
      //
      //   final compositorPattern = RegExp(r"\((.*?)\)");
      //
      //   late String song ;
      //   if(split[1] == ""){
      //     song = "unknown";
      //   } else {
      //     song = split[1];
      //   }
      //
      //   late String anime;
      //   late String compositor; /// or band
      //
      //   if(compositorPattern.hasMatch(split[0])){
      //
      //     final animePart1 = compositorPattern.stringMatch(split[0]) as String;
      //     anime = animePart1.substring(1 , animePart1.length-1);
      //
      //    compositor = split[0].split("(")[0];
      //   }
      //   else {
      //     anime = "unknown";
      //     compositor = split[0];
      //   }
      //
      //   return  <String>[song , compositor , anime];
      // },
      countryIndex: CountriesEnum.russian.index ,
    ),

    // /// Animeradio.su
    //
    // MusicStation(
    //     address: "http://animeradio.su:8000",
    //     validateUrl: 'http://animeradio.su:8000',
    //     name: "Animeradio.su",
    //     metaFormat: (String? meta ,  ) {
    //       /// It seems they already haven't been servicing . No have any idea why .
    //       return [];
    //     },
    // ),

    /// Radio Nami

    MusicStation(
      validateUrl: 'http://5.9.2.139:8000',
      // address: 'http://5.9.2.139:8000/any-anime.ru',
      encAddress: 'aHR0cDovLzUuOS4yLjEzOTo4MDAwL2FueS1hbmltZS5ydQ==',
      name: 'Radio Nami',
      imgAddress: 'https://radionami.com/style/horo.png',
      metaFormat: (meta ) => metaFormat(
          meta,

          pattern:  ProcessStringPattern.two_one
      ),
      // metaFormat: (String? meta ,  ) {
      //   if (
      //     meta == null ||
      //     != "Radio Nami"
      //   ) return null;
      //
      //   final part1 = meta.split(',')[0];
      //   final pattern = RegExp(r'title="*"');
      //   final part2 = part1.split(pattern)[1];
      //   final part3  =  part2.substring(0, part2.length - 1).split(r"-");
      //
      //   final  song = part3[0] ;
      //   final compositor = part3[1];
      //   return [song , compositor];
      // },
      countryIndex: CountriesEnum.russian.index ,
    ),

    /// AnimeRadio.de

    MusicStation(
      genres: [
        MusicGenre.anime ,
        MusicGenre.jpop ,
        MusicGenre.rock
      ],
      validateUrl: 'http://stream.animeradio.de',
      // address: "http://stream.animeradio.de/animeradio.mp3",
      encAddress: "aHR0cDovL3N0cmVhbS5hbmltZXJhZGlvLmRlL2FuaW1lcmFkaW8ubXAz",
      name: "AnimeRadio.de",
      imgAddress: "https://www.animeradio.de/img/animeradio-stream-mp3-192.jpg",
      metaFormat: (meta ) => metaFormat(
          meta,

          pattern:  ProcessStringPattern.two_one,
          filterStrings: [
            "ICY: title=\"AnimeRadio.de - Impact\", url=\"null\", rawMetadata.length=\"69\""
          ]
      ),
      // metaFormat: (String? meta ,  ) {
      //   if (
      //   meta == null ||
      //       != "AnimeRadio.de"
      //   ) return null;
      //
      //   final part1 = meta.split(',')[0];
      //   final pattern = RegExp(r'title="*"');
      //   final part2 = part1.split(pattern)[1];
      //
      //   if(part2.substring(0 , part2.length -1 ) == "AnimeRadio.de - Impact") return null ;
      //
      //   final part3  =  part2.substring(0, part2.length - 1).split(r"-");
      //
      //   final  song = part3[0] ;
      //   final compositor = part3[1];
      //   return [song , compositor];
      // },
      countryIndex: CountriesEnum.germany.index ,
    ),

    /// Tsubaki Radio

    MusicStation(
      validateUrl: 'http://tsubakianimeradio.com/',
      // address: "http://stream.tsubakianimeradio.com:9000/play.mp3",
      encAddress: "aHR0cDovL3N0cmVhbS50c3ViYWtpYW5pbWVyYWRpby5jb206OTAwMC9wbGF5Lm1wMw==",
      imgAddress: "http://tsubakianimeradio.com/wp-content/uploads/2020/08/logo-new.png",
      name: "Tsubaki Radio",
      // metaFormat: metaFormat,
      metaFormat: (String? meta ,  ) {

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


      },
      countryIndex: CountriesEnum.japan.index ,
    ),

    /// Vocaloid Radio

    MusicStation(
      validateUrl: "https://vocaloidradio.com/",
      genres: [
        MusicGenre.anime ,
        MusicGenre.jpop ,
      ],
      metaFormat: (String? meta ,  ) => metaFormat(
          meta,

          pattern: ProcessStringPattern.two_one
      ),
      // address: "http://curiosity.shoutca.st:8019/stream",
      encAddress: "aHR0cDovL2N1cmlvc2l0eS5zaG91dGNhLnN0OjgwMTkvc3RyZWFt",
      name: "VOCALOID RADIO",
      imgAddress: "https://i1.sndcdn.com/avatars-000136602861-y5ivo2-t200x200.jpg",
      countryIndex: CountriesEnum.usa.index ,
    ),

    /// J-pop powerplay kawaii

    MusicStation(
      validateUrl: "https://kathy.torontocast.com",
      genres: [
        MusicGenre.anime ,
        MusicGenre.jpop ,
      ],
      metaFormat: (String? meta ,  ) => metaFormat(
          meta,

          pattern: ProcessStringPattern.two_one
      ),
      // address: "https://kathy.torontocast.com:3060/;",
      encAddress: "aHR0cHM6Ly9rYXRoeS50b3JvbnRvY2FzdC5jb206MzA2MC87",
      name: "J-Pop Powerplay Kawaii",
      imgAddress: "https://asiadreamradio.torontocast.stream/stations/en/images/en/ppkawaii@2x.png",
      countryIndex: CountriesEnum.japan.index ,
    ),

    /// Radio Free Otaku

    MusicStation(
      validateUrl: "https://radio.co/",
      metaFormat: (String? meta ,  ) => metaFormat(
          meta,

          pattern: ProcessStringPattern.two_one
      ),
      genres: [
        MusicGenre.anime ,
        MusicGenre.pop ,
      ],
      // address: "https://streaming.radio.co/s8267e5edc/listen",
      encAddress: "aHR0cHM6Ly9zdHJlYW1pbmcucmFkaW8uY28vczgyNjdlNWVkYy9saXN0ZW4=",
      name: "Radio Free Otaku" ,
      imgAddress: "https://static.mytuner.mobi/media/tvos_radios/4yxkkk9gvtqg.png",
      countryIndex: CountriesEnum.usa.index ,
    ),

    /// Radio Anime 24

    MusicStation(
        validateUrl: "https://www.radioanime24.pl/",
        metaFormat: (String? meta ,  ) => metaFormat(
            meta,

            pattern: ProcessStringPattern.two_one
        ),
        genres: [
          MusicGenre.anime ,
          MusicGenre.jpop ,
        ],
        countryIndex: CountriesEnum.poland.index ,
        // address: "http://91.232.4.33:7028/stream/;",
        encAddress: "aHR0cDovLzkxLjIzMi40LjMzOjcwMjgvc3RyZWFtLzs=",
        name: "Radio Anime 24",
        imgAddress: "https://scscript.radiohost.pl/files/covers/9723"

    ),

    /// Death FM

    MusicStation(
        genres: [
          MusicGenre.metal,
          MusicGenre.deathMetal,

        ],
        countryIndex: CountriesEnum.england.index ,
        validateUrl: "http://death.fm/",
        metaFormat: (String? meta ,  ) => metaFormat(
            meta,

            pattern: ProcessStringPattern.two_one_three
        ),
        // address: "http://hi5.death.fm/;",
        encAddress: "aHR0cDovL2hpNS5kZWF0aC5mbS87",
        name: "Death FM" ,
        imgAddress: "http://death.fm/images/logos/dfm_logo-200x200.png"
    ),

    /// Power Metal

    MusicStation(
      genres: [
        MusicGenre.metal,
        MusicGenre.powerMetal,

      ],
      validateUrl: "https://www.rockradio.com/",
      metaFormat: (String? meta ,  ) => metaFormat(
          meta,

          pattern:ProcessStringPattern.two_one
      ),
      // address: "http://prem4.rockradio.com/powermetal?66222d3be7d368c",
      encAddress: "aHR0cDovL3ByZW00LnJvY2tyYWRpby5jb20vcG93ZXJtZXRhbD82NjIyMmQzYmU3ZDM2OGM=",
      name: "RockRadio.com \n PowerMetal",
      imgAddress: "https://cdn-images.audioaddict.com/0/4/a/d/c/f/04adcfe84da46c0c404acefef9005b40.png?size=300x300",
      countryIndex: CountriesEnum.international.index ,
    ),

    /// Metal FM

    MusicStation(
        genres: [
          MusicGenre.metal,
          MusicGenre.thrashMetal,
          MusicGenre.alternativeRock,
          MusicGenre.heavyMetal,
        ],
        countryIndex: CountriesEnum.germany.index ,
        validateUrl: "http://the-radio.ru/radio/metal-fm-r1184",
        metaFormat: (String? meta  ) => metaFormat(
            meta,
            pattern:ProcessStringPattern.two_one
        ),
        // address: "http://streams.fluxfm.de/metalfm/mp3-128/fluxfm.de_webplayer/",
        encAddress: "aHR0cDovL3N0cmVhbXMuZmx1eGZtLmRlL21ldGFsZm0vbXAzLTEyOC9mbHV4Zm0uZGVfd2VicGxheWVyLw==",
        name: "Metal FM",
        imgAddress: "http://the-radio.ru//up/radio/ava/2017/11/1184_the_radio_ru_bfkig2n.png"
    ),

    /// Industrial Metal
    MusicStation(
      genres: [
        MusicGenre.metal,
        MusicGenre.industrialMetal,
      ],
      countryIndex: CountriesEnum.russian.index ,
      validateUrl: "https://101.ru",
      metaFormat: (String? meta ,  ) => metaFormat(
        meta,

        // pattern:ProcessStringPattern.two_one
      ),
      // address: "https://pub0102.101.ru:8443/stream/personal/aacp/64/893907?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJrZXkiOiI2NzcxYjAxOTNiYWY5ZmQxMGJhODBjYzYzODJjZmE5MSIsIklQIjoiMTk1LjY0LjE4My4yMzAiLCJVQSI6Ik1vemlsbGFcLzUuMCAoWDExOyBMaW51eCB4ODZfNjQ7IHJ2OjEwMi4wKSBHZWNrb1wvMjAxMDAxMDEgRmlyZWZveFwvMTAyLjAiLCJSZWYiOiIiLCJ1aWRfY2hhbm5lbCI6Ijg5MzkwNyIsInR5cGVfY2hhbm5lbCI6InBlcnNvbmFsIiwidHlwZURldmljZSI6IlBDIiwiQnJvd3NlciI6IkZpcmVmb3giLCJCcm93c2VyVmVyc2lvbiI6IjEwMi4wIiwiU3lzdGVtIjoiVWJ1bnR1IDE0LjA0IExUUyIsImV4cCI6MTY3ODAwODg4N30.CRt0UNe1HHNAXwZdRpadbiwaapo8qiJLC_Ts_75cVe0",
      encAddress: "aHR0cHM6Ly9wdWIwMTAyLjEwMS5ydTo4NDQzL3N0cmVhbS9wZXJzb25hbC9hYWNwLzY0Lzg5MzkwNz90b2tlbj1leUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpJVXpJMU5pSjkuZXlKclpYa2lPaUkyTnpjeFlqQXhPVE5pWVdZNVptUXhNR0poT0RCall6WXpPREpqWm1FNU1TSXNJa2xRSWpvaU1UazFMalkwTGpFNE15NHlNekFpTENKVlFTSTZJazF2ZW1sc2JHRmNMelV1TUNBb1dERXhPeUJNYVc1MWVDQjRPRFpmTmpRN0lISjJPakV3TWk0d0tTQkhaV05yYjF3dk1qQXhNREF4TURFZ1JtbHlaV1p2ZUZ3dk1UQXlMakFpTENKU1pXWWlPaUlpTENKMWFXUmZZMmhoYm01bGJDSTZJamc1TXprd055SXNJblI1Y0dWZlkyaGhibTVsYkNJNkluQmxjbk52Ym1Gc0lpd2lkSGx3WlVSbGRtbGpaU0k2SWxCRElpd2lRbkp2ZDNObGNpSTZJa1pwY21WbWIzZ2lMQ0pDY205M2MyVnlWbVZ5YzJsdmJpSTZJakV3TWk0d0lpd2lVM2x6ZEdWdElqb2lWV0oxYm5SMUlERTBMakEwSUV4VVV5SXNJbVY0Y0NJNk1UWTNPREF3T0RnNE4zMC5DUnQwVU5lMUhITkFYd1pkUnBhZGJpd2FhcG84cWlKTENfVHNfNzVjVmUw",
      name: "Industrial Metal",
      imgAddress: "https://cdn1.101.ru/proxy/vardata/modules/channel/dynamics/personal/89/893907.png?w=300&h=300&pos=center&t=1487514382",
      noMeta: true,
    ),



  ];




  static List<String>? metaFormat (
      String? meta ,
      {
        ProcessStringPattern? pattern,
        List<String> filterStrings = const []
      }
      ) {


    if (meta == null) return null;

    if(filterStrings.isNotEmpty){
      for (var filter in filterStrings) {
        if(meta == filter){
          return null ;
        }
      }
    }

    final pattern2 = RegExp(r"\s-\s");
    final pattern3 = RegExp(r'",\s');

    final a = meta.split(pattern2);

    if (a.length == 3){

      final firstPart = a[0].substring(12 ,a[0].length);
      final secondPart = a[1] ;
      final thirdPart = a[2].split(pattern3)[0];

      switch(pattern) {
        case ProcessStringPattern.oneTwo_three:
          return ["$firstPart $secondPart" , thirdPart ];
      // compositor = "$firstPart $secondPart";
      // song = thirdPart;
      // break;
        case ProcessStringPattern.two_one_three:
          return [ secondPart , firstPart , thirdPart];
        default: return [firstPart , secondPart , thirdPart];
      }


    }
    else if (a.length == 1) {
      return null;
    }
    else {
      final firstPart = a[0].substring(12 ,a[0].length );
      final secondPart = a[1].split(pattern3)[0];

      switch(pattern) {
        case ProcessStringPattern.two_one :
          return [ secondPart , firstPart];
        default :
          return [firstPart , secondPart];
      }


    }

  }
}