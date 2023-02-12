import 'package:anime_radio/src/pages/HomePage/SongStations/SongStationsPage.dart';
import 'package:anime_radio/src/providers/AdMobProvider.dart';
import 'package:anime_radio/src/providers/PlayerDesignProvider.dart';
import 'package:anime_radio/src/providers/SongsProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';

import 'package:anime_radio/src/widgets/MyDrawer.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildOnlineStatus.dart';
import 'package:anime_radio/src/widgets/songStations/ShimmerAnimation/SHIMER_GRADIENT.dart';
import 'package:anime_radio/src/widgets/songStations/ShimmerAnimation/Shimmer.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /// Used in order to not reload already
  /// successfully loaded station again .
  bool firstBuild = true; 

  /// By default
  int index = 0 ;

  
  @override
  void initState() {
    super.initState();
    
    LocalStorageService.getSongStationsPageIndex()
        .then((index) {
          if(index != null) this.index = index ;

        }
    ); 
  }

  void onChangePage (int index) {
    if(this.index != index ) {
      this.index  = index;
      LocalStorageService.saveSongStationsPageIndex(index);
      setState(() { });
    }
  }

  List<BottomNavigationBarItem> navigationBarItems (bool lightTheme) =>  [
     BottomNavigationBarItem(

        icon: const Icon( Icons.explore_outlined , weight: 40, ),
        activeIcon: Icon(
          Icons.explore_outlined ,
          weight: 40,
          color: lightTheme ? ColorService.violet : ColorService.pink  ,
        ),
         label: AppLocalizations.of(context)!.all_stations
    ),
     BottomNavigationBarItem(
        activeIcon:  Icon(
          Icons.favorite ,
          weight: 40,
          color: lightTheme ? ColorService.red : ColorService.pink,
        ),
        icon:  const Icon(Icons.favorite,),
        label: AppLocalizations.of(context)!.favorite_stations
    ),
  ];


  List <Widget?> screens () => [
     SongStationsPage(firstBuild: firstBuild,),
     SongStationsPage(buildFavoriteStations: true , firstBuild: firstBuild,),
  ];

  @override
  Widget build(BuildContext context) {

    final  themeProvider = Provider.of<ThemeProvider>(context , listen:  false);
    bool lightTheme = themeProvider.currentTheme == ThemeMode.light;

    if(firstBuild) {
      Future.delayed(const Duration(seconds: 3)).then((value) => firstBuild = false);
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerDesignProvider>(
          create: (BuildContext context) => PlayerDesignProvider(),
        ),
        ChangeNotifierProvider<SongsProvider>(
          create: (BuildContext context) => SongsProvider(context: context),
        ),
        ChangeNotifierProvider<AdMobProvider>(
          create: (BuildContext  context) => AdMobProvider(),
        )
      ],
      child: Scaffold(
          appBar: AppBar(
            actions:   [
              const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: BuildOnlineStatus(),
              ),
              IconButton(
                  onPressed: () => setState(() {}),
                  icon: const  Icon(Icons.refresh)
              ),

            ],


          ),
          bottomNavigationBar: BottomNavigationBar(
            items: navigationBarItems(lightTheme) ,
            onTap: onChangePage ,
            currentIndex: index,
          ),
          drawer: Drawer(
              child: MyDrawer(update: () => setState(() { }))
          ),
          body:  Shimmer(
            linearGradient: shimmerGradient(lightTheme),
            child: screens()[index]
          ),
      ),
    );
  }


}




