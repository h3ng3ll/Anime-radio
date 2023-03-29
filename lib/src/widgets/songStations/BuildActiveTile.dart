

import 'package:anime_radio/src/models/MusicStation.dart';
import 'package:anime_radio/src/pages/HomePage/SongStations/PlayerViewPage.dart';
import 'package:anime_radio/src/providers/AdMobProvider.dart';
import 'package:anime_radio/src/providers/SettingsProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/providers/playerViewPage/PlayerDesignProvider.dart';
import 'package:anime_radio/src/providers/playerViewPage/SongsProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/widgets/songStations/FavoriteStationButton.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildActiveTile extends StatelessWidget {


  const BuildActiveTile({
    Key? key,
    required this.songStation,
    required this.saveFavoriteStation,
    required this.height,
  }) : super(key: key);

  final MusicStation songStation ;
  final double height ;

  final void Function (MusicStation songStation) saveFavoriteStation ;

  @override
  Widget build(BuildContext context) {


    final  themeProvider = Provider.of<ThemeProvider>(context );



    bool lightTheme = themeProvider.currentTheme == ThemeMode.light;

    final songsProvider = Provider.of<SongsProvider>(context , listen: false);
    final designProvider = Provider.of<PlayerDesignProvider>(context , listen: false);
    final adMobProvider =  Provider.of<AdMobProvider>(context , listen: false);
    final settingsProvider =  Provider.of<SettingsProvider>(context , listen: false);

    return InkWell(
      onTap: () =>  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<SongsProvider>.value(value: songsProvider,),
                  ChangeNotifierProvider<PlayerDesignProvider>.value(value: designProvider,),
                  ChangeNotifierProvider<AdMobProvider>.value(value: adMobProvider,),
                  ChangeNotifierProvider<SettingsProvider>.value(value: settingsProvider,),
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
            height: height,
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

  Widget buildImageOfStation () {
    if(songStation.imgAddress != null) {
      return CachedNetworkImage(
        imageUrl: songStation.imgAddress!,
        imageBuilder:  (BuildContext context , ImageProvider imageProvider) => ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child:   Image.network(
            songStation.imgAddress! ,
            fit: BoxFit.cover,
          ),
        ),
        errorWidget: (context , error , d) => Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/greyBG.jpg"))
          ),
          child: Text(
            AppLocalizations.of(context)!.failed_to_load_an_image ,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Container();
    }

  }


  Widget items (bool lightTheme) =>  Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        flex: 3,
          child: buildImageOfStation()
      )   ,
      const Spacer(),
      Flexible(
        flex: 4,
        child: Text(
            songStation.name  ,
            style: const TextStyle(fontSize: 20 , overflow: TextOverflow.visible)),
      ),

      FavoriteStationButton(songStation: songStation,)
    ],
  );
}
