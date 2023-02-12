

import 'package:anime_radio/src/models/MusicStation.dart';
import 'package:anime_radio/src/pages/HomePage/SongStations/PlayerViewPage.dart';
import 'package:anime_radio/src/providers/AdMobProvider.dart';
import 'package:anime_radio/src/providers/PlayerDesignProvider.dart';
import 'package:anime_radio/src/providers/SongsProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/widgets/songStations/FavoriteStationButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildActiveTile extends StatelessWidget {


  const BuildActiveTile({
    Key? key,
    required this.songStation,
    required this.saveFavoriteStation,
  }) : super(key: key);

  final MusicStation songStation ;

  final void Function (MusicStation songStation) saveFavoriteStation ;

  @override
  Widget build(BuildContext context) {


    final  themeProvider = Provider.of<ThemeProvider>(context , listen:  false);
    bool lightTheme = themeProvider.currentTheme == ThemeMode.light;

    final songsProvider = Provider.of<SongsProvider>(context , listen: false);
    final designProvider = Provider.of<PlayerDesignProvider>(context , listen: false);
    final adMobProvider =  Provider.of<AdMobProvider>(context , listen: false);


    return InkWell(
      onTap: () =>  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<SongsProvider>.value(value: songsProvider,),
                  ChangeNotifierProvider<PlayerDesignProvider>.value(value: designProvider,),
                  ChangeNotifierProvider<AdMobProvider>.value(value: adMobProvider,),
                ],
                child: PlayerViewPage(
                  musicStation: songStation,
                ),
              )
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: lightTheme ? ColorService.white : ColorService.dGrey,
                borderRadius: BorderRadius.circular(17.5),
                border: Border.all(color: ColorService.black , width: 1 )
            ),
            padding: const  EdgeInsets.symmetric(vertical: 5 , horizontal: 5),
            child: items(lightTheme)
        ),
      ),
    );
  }

  Widget buildImageOfStation () => CachedNetworkImage(
        imageUrl: songStation.imgAddress!,
        imageBuilder:  (BuildContext context , ImageProvider imageProvider) => ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child:   Image.network(
            songStation.imgAddress! ,
            width: 150, fit: BoxFit.fitHeight,
          ),
        ),
      );


  Widget items (bool lightTheme) =>  Row(
    children: [
      songStation.imgAddress != null ?
      buildImageOfStation()  : Container() ,
      const Spacer(),

      Text(songStation.name  , style: const TextStyle(fontSize: 20)),
      const Spacer(),

      FavoriteStationButton(songStation: songStation,)
    ],
  );
}
