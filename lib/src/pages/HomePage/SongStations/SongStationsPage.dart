import 'package:anime_radio/src/models/MusicStation.dart';
import 'package:anime_radio/src/models/StationFilter.dart';
import 'package:anime_radio/src/providers/SettingsProvider.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:anime_radio/src/services/NetworkConnectivityService.dart';
import 'package:anime_radio/src/databases/DatabaseRadioStations.dart';
import 'package:anime_radio/src/widgets/songStations/BuildActiveTile.dart';
import 'package:anime_radio/src/widgets/songStations/BuildNoInternetConncetionImage.dart';
import 'package:anime_radio/src/widgets/songStations/BuildUnActiveTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class InternetConnectionCheckerWidget extends StatelessWidget {

  /// this constant prevent needless update !
   const  InternetConnectionCheckerWidget({
    Key? key,
    required this.firstBuild,
     required this.loadWidget
  }) : super(key: key);

  /// First build show us loading animation
  /// others just load widgets

  final bool firstBuild ;
  final Widget loadWidget ;


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      ///   initialization time
      future: firstBuild ?  Future.delayed(const Duration(seconds: 2)) : null,
      builder: ( context,  snapshot) {

        if(snapshot.connectionState == ConnectionState.done || !firstBuild) {

          /// check connection to Internet
          final online = NetworkConnectivityService.instance.isOnline;
          if(online){
            return loadWidget;
          }
          else {
            return const BuildNoInternetConnectionImage();
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class SongStationPage extends StatefulWidget {
  const SongStationPage({
    Key? key,
    required this.firstBuild,
    required this.buildFavoriteStations
  }) : super(key: key);


  final bool firstBuild ;
  final bool buildFavoriteStations ;

  @override
  State<SongStationPage> createState() => _SongStationPageState();
}

class _SongStationPageState extends State<SongStationPage> {

 final ScrollController controller  = ScrollController();
  late List<MusicStation> stations;
  late List<bool> successfullyLoadedStations ;


  @override
  void initState() {

    super.initState();

    stations =  DatabaseRadioStations.getStations;

    successfullyLoadedStations = List.generate(
        stations.length, (index) => false);

    restoreSettings();

    if(widget.buildFavoriteStations){
      LocalStorageService.getFvtStsPgePos().then((value) {
        Future.delayed(const Duration(seconds: 1)).then((_) {
          if(value != null) controller.jumpTo(value );
        });
        controller.addListener(() {
          LocalStorageService.saveFvtStsPgePos(controller.offset);
        });
      });
    } else {
      LocalStorageService.getStsPgePos().then((value) {
        Future.delayed(const Duration(seconds: 1)).then((_) {
          if(value != null) controller.jumpTo(value );
        });
        controller.addListener(() {
          LocalStorageService.saveStsPgePos(controller.offset);
        });
      });
    }

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<MusicStation> stationFilter (StationFilter filter) {

    List<MusicStation> selected = [];


    for (var station in DatabaseRadioStations.getStations) {
      /// sort by Genre | Station is selected if even one is matched .

      for (var genre in station.genres) {
        if (filter.genres.contains(genre)) {
          selected.add(station);
          break;
        }
      }

      /// sort by Country | Location

      for (var index in filter.countryIndexes) {
        if (station.countryIndex == index) {
          if(!selected.contains(station)){
            selected.add(station);
            break;
          }
        }
      }
    }

    return selected;
  }

  void saveFavoriteStation (MusicStation stations) {
    final index = this.stations.map((station) => station.name)
        .toList().indexOf(stations.name);

    this.stations[index].favorite = stations.favorite;

    LocalStorageService.saveFavoriteSongStations(
        this.stations.map((e) => e.favorite).toList()
    );
  }

  bool stationFavoriteFilter (MusicStation station ) =>
      !widget.buildFavoriteStations ? true :
           station.favorite ? true  :
           false;

  void restoreSettings () {
    LocalStorageService.getFavoriteSongStations()
        .then((value) {
      if(value != null ) {
        for (int i = 0 ; i<value.length ; i++) {
          stations[i].favorite = value[i];
        }
      }
    });
  }


  StationFilter? filter;

  void resetShimmerAnimation(StationFilter? newFilter) {
    if(filter != newFilter){
      successfullyLoadedStations = List.generate(
          stations.length, (index) => false);
    } else if( filter == null && successfullyLoadedStations.length != stations.length){
      successfullyLoadedStations = List.generate(
          stations.length, (index) => false);
    }
  }

  @override
  Widget build(BuildContext context) {

    final filter = Provider.of<StationFilter?>(context);
    final settings = Provider.of<SettingsProvider>(context ).settings;

    if(!widget.firstBuild) {
      if(filter != null) {
        /// get sorted stations
        stations = stationFilter(filter);
      }
      else {
        /// get all stations
        stations =  DatabaseRadioStations.getStations;
      }
      resetShimmerAnimation(filter);
    }



    return ListView.builder(
        controller: controller ,
        itemCount:  stations.length,
        itemBuilder: (context , index) {
          final MusicStation songStation = stations[index];

          const double height = 90 ;

          /// nothing build if this
          /// song not favorite
          final bool  build = stationFavoriteFilter(songStation);

          if(!build) return Container() ;


          /// build if song station already has been
          /// loaded and rebuild again .
          if(!widget.firstBuild && successfullyLoadedStations[index]){
            return Provider<Function(MusicStation)>(
              create: (BuildContext context) => saveFavoriteStation,
              child: BuildActiveTile(
                songStation: songStation,
                saveFavoriteStation: saveFavoriteStation,
                height: height,
              ),
            );
          }

          return FutureBuilder<bool>(
              future:  NetworkConnectivityService.instance.
              checkConnectivityToAddress(songStation.validateUrl),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {


                final showUnloadedStations = settings.showUnloadedStations;
                final offAnimation = settings.disableLoadingStationAnimations || settings.disableAllAnimations;


                /// the checking if address even  connectible
                if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                  final bool connection = snapshot.data!;

                  /// if url loaded successfully we
                  /// show it .
                  if(connection) {
                    successfullyLoadedStations[index] = true;

                    return BuildActiveTile(
                      songStation: songStation,
                      saveFavoriteStation: saveFavoriteStation,
                      height: height,
                    );
                  }
                  /// user don't want to see station which hasn't loaded successfully


                  else if (!showUnloadedStations) {
                    return Container();
                  }

                  /// url has load failure
                  /// and user want to see error
                  /// about it
                  else {
                    successfullyLoadedStations[index] = false;
                    return  const BuildUnActiveTile(
                        loading: false,
                        height: height,
                    );
                  }
                }
                else if (snapshot.connectionState == ConnectionState.waiting){
                  successfullyLoadedStations[index] = false;
                  return BuildUnActiveTile(
                        loading: true,
                        height: height,
                        offAnimation: offAnimation,
                  );
                }

                return Container();

              }
          );
        }
    );
  }
}


