import 'package:admob_flutter/admob_flutter.dart';
import 'package:anime_radio/src/models/StationFilter.dart';
import 'package:anime_radio/src/pages/HomePage/SongStations/SongStationsPage.dart';
import 'package:anime_radio/src/providers/SettingsProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/AdMobService.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:anime_radio/src/services/NetworkConnectivityService.dart';

import 'package:anime_radio/src/widgets/MyDrawer.dart';
import 'package:anime_radio/src/widgets/homePage/BuildFilterButton.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildOnlineStatus.dart';

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

  bool isOverlayVisible = false ;

  StationFilter? filter;


  @override
  void initState() {
    super.initState();

    LocalStorageService.getSongStationsPageIndex()
        .then((index) {if(index != null) this.index = index ;}
    );

  }

  void onChangePage (int index) {
    if(this.index != index ) {
      this.index  = index;
      LocalStorageService.saveSongStationsPageIndex(index);
      setState(() { });
    }
  }

  Widget buildFilter () {


    if(NetworkConnectivityService.instance.isOnline ) {
      return BuildFilterButton(
        updateFilter: (StationFilter? filter ) {
          this.filter = filter;
          setState(() {});
        },
      );
    }

    return Container();

  }


  @override
  Widget build(BuildContext context) {

    final  themeProvider = Provider.of<ThemeProvider>(context , listen:  false);
    bool lightTheme = themeProvider.currentTheme == ThemeMode.light;

    if(firstBuild) {
      Future.delayed(const Duration(seconds: 3)).then((value) => firstBuild = false);
    }

    return Scaffold(
        appBar: AppBar(
          actions:   [
            const SizedBox(width: 50),
            Expanded(
              flex: 1,
              child: AdmobBanner(
                  adUnitId: AdMobService.getBannerAdUnitId()!,
                  adSize: AdmobBannerSize.SMART_BANNER(context)
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.5),
              child: BuildOnlineStatus(),
            ),
            IconButton(
                onPressed: () => setState(() {}),
                icon: const  Icon(Icons.refresh)
            ),
            buildFilter() ,

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
        body:  InternetConnectionCheckerWidget(
            firstBuild: firstBuild,
            loadWidget:
                IndexedStack(
                  index: index,
                  children: screens(),
                )
        )
    );
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


  List <Widget> screens () => [
   Provider<StationFilter?>.value(
        value: filter,
        child: SongStationPage(
          firstBuild: firstBuild, buildFavoriteStations: false,)
    ),
    SongStationPage(
      buildFavoriteStations: true , firstBuild: firstBuild,
    ),
  ];

}




