import 'package:anime_radio/src/models/MusicStation.dart';
import 'package:anime_radio/src/models/Settings.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:anime_radio/src/services/NetworkConnectivityService.dart';
import 'package:anime_radio/src/services/RadioStationService.dart';
import 'package:anime_radio/src/widgets/songStations/BuildActiveTile.dart';
import 'package:anime_radio/src/widgets/songStations/BuildNoInternetConncetionImage.dart';
import 'package:anime_radio/src/widgets/songStations/BuildUnActiveTile.dart';
import 'package:anime_radio/src/widgets/songStations/ShimmerAnimation/ShimmerLoading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SongStationsPage extends StatefulWidget {

  /// this constant prevent needless update !
   const  SongStationsPage({
    Key? key,
    this.buildFavoriteStations = false,
    required this.firstBuild
  }) : super(key: key);

  /// First build show us loading animation
  /// others just load widgets
  final bool firstBuild ;
  final bool buildFavoriteStations ;

  @override
  State<SongStationsPage> createState() => _SongStationsPageState();
}

class _SongStationsPageState extends State<SongStationsPage> {
  late Settings settings;

  List<MusicStation> stations = RadioStationService.getStations;

  List<bool> successfullyLoadedStations  = List.generate(
      RadioStationService.getStations.length, (index) => false);

  void saveFavoriteStation (MusicStation stations) {
    final index = this.stations.map((station) => station.name)
        .toList().indexOf(stations.name);

    this.stations[index].favorite = stations.favorite;

    LocalStorageService.saveFavoriteSongStations(
        this.stations.map((e) => e.favorite).toList()
    );
  }

  bool stationFilter (MusicStation station ) {
    if(!widget.buildFavoriteStations) {
      return  true;
    }
    else if  (station.favorite) {
      return true;
    }
    else {
      return false ;
    }
  }

  void restoreSettings () {
    LocalStorageService.getFavoriteSongStations()
        .then((value) {
      if(value != null ) {
        for (int i = 0 ; i<value.length ; i++) {
          stations[i].favorite = value[i];
        }
      }
    });
    LocalStorageService.getSettings().then((value) {
      settings = value;
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    restoreSettings();


    return FutureBuilder(
      ///   initialization time
      future: widget.firstBuild ?  Future.delayed(const Duration(seconds: 3)) : null,
      builder: ( context,  snapshot) {

        if(snapshot.connectionState == ConnectionState.done || !widget.firstBuild) {
          /// check connection to Internet

          final online = NetworkConnectivityService.instance.isOnline;
          if(online){
            return ListView.builder(
                itemCount:  stations.length,
                itemBuilder: (context , index) {
                  final songStation = stations[index];


                  /// nothing build if this
                  /// song not favorite
                  final  build = stationFilter(songStation);
                  if(!build) return Container() ;


                  /// build if song station already has been
                  /// loaded and rebuild again .
                  if(!widget.firstBuild && successfullyLoadedStations[index]){
                    return Provider<Function(MusicStation)>(
                      create: (BuildContext context) => saveFavoriteStation,
                      child: BuildActiveTile(
                        songStation: songStation,
                        saveFavoriteStation: saveFavoriteStation,
                      ),
                    );
                  }

                  return FutureBuilder<bool>(
                      future:  NetworkConnectivityService.instance.
                      checkConnectivityToAddress(songStation.validateUrl),
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {



                        /// the checking if address even  connectible
                        if(snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                          final connection = snapshot.data!;

                          /// if url loaded successfully we
                          /// show it .
                          if(connection) {
                            successfullyLoadedStations[index] = true;

                            return BuildActiveTile(
                              songStation: songStation,
                              saveFavoriteStation: saveFavoriteStation,
                            );
                          }

                          /// url has load failure
                          /// and user want to see error
                          /// about it
                          else if (!settings.showUnloadedStations) {
                            return Container();
                          }

                          /// user don't want to see station which hasn't loaded successfully
                          else {
                            successfullyLoadedStations[index] = false;
                            return const BuildUnActiveTile(loading: false);
                          }
                        }
                        else if (snapshot.connectionState == ConnectionState.waiting){
                          successfullyLoadedStations[index] = false;
                          return const ShimmerLoading(
                              isLoading: true,
                              child:  BuildUnActiveTile(loading: true)
                          );
                        }

                        return Container();

                      }
                  );
                }
            );
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
