

import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/src/dialogs/BuildRemoveAllSongsDialog.dart';
import 'package:anime_radio/src/models/Song.dart';
import 'package:anime_radio/src/providers/PlayedSongsProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:anime_radio/src/widgets/listPlayedSongs/BuildAllPlayedSongs.dart';
import 'package:anime_radio/src/widgets/listPlayedSongs/BuildFavoritePlayedSongs.dart';


import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class ListPlayedSongs extends StatefulWidget{
  const ListPlayedSongs({super.key});


  static String formatTime (DateTime time , BuildContext context) {

    final locale = L10n.all[L10n.nameLanguages
        .indexOf(AppLocalizations.of(context)!.language)].languageCode;

    return DateFormat("dd MMMM yyyy" , locale).format(time);

  }

  @override
  State<ListPlayedSongs> createState() => _ListPlayedSongsState();
}

class _ListPlayedSongsState extends State<ListPlayedSongs> {



  int index = 0 ;
  List<SavedSong> songs = [];
  List<SavedSong> favoriteSongs = [];

  double? offsetAllSongs ;
  double? offsetFavoriteSongs ;

  List<DateTime> unVisibleFilter = [];
  bool firstLoad = true;




    @override
    void initState () {
      super.initState();


      restorePageIndex();
    }



  void restorePageIndex () async {
    index = await LocalStorageService
        .getSavedSongsPageIndex() ?? 0;

    setState(() {  });
  }
  Future<void> restoreScrollPosition () async {
   var  value = await  LocalStorageService.getScrollPositionAllPlayedSongs();
    if(value == null) return ;
    offsetAllSongs = value;


     final value2 = await  LocalStorageService.getScrollPositionAllFvrtSongs();
   if(value2 == null) return ;

   offsetFavoriteSongs = value2;

  }
  Future<void> restoreSavedSongs () async {
    final value = await LocalStorageService.restoreSongs();
    songs = value;

    for (var element in songs) {
      if(element.favoriteSong) {
        favoriteSongs.add(element);
      }
    }
  }
  Future<void> restoreUnVisibleFilter () async {
    unVisibleFilter = await  LocalStorageService
        .getUnVisibleFilter() ?? [];
  }


  void onChangePage (index) {
    LocalStorageService.saveSongsPageIndex(index);
    setState(() => this.index = index);
  }

  Future<void> initializer() async {
    await restoreUnVisibleFilter();
    await restoreSavedSongs();
    await restoreScrollPosition();

    // ignore: use_build_context_synchronously
    Provider.of<PlayedSongsProvider>(context , listen:  false).initialize(
        songs: songs,
        unVisibleFilter: unVisibleFilter,
        offsetAllSongs: offsetAllSongs,
        offsetFavoriteSongs: offsetFavoriteSongs
    );

  }


  @override
  Widget build(BuildContext context) {

    final  themeProvider = Provider.of<ThemeProvider>(context , listen:  false);
    bool lightTheme = themeProvider.currentTheme == ThemeMode.light;



    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async  {
                final res = await showDialog(
                    context: context,
                    builder: (context) => const BuildRemoveAllSongsDialog()
                );
                if(res == "yes" ){
                  setState(() { });
                }
              },
              icon: const Icon(Icons.playlist_remove))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navigationBarItems(lightTheme) ,
        onTap: onChangePage ,
        currentIndex: index,
      ),
      body: FutureBuilder<void>(
        future: firstLoad ? initializer() : null,
        builder: (context, snapshot) {


          if(snapshot.connectionState == ConnectionState.done || !firstLoad){
            if(firstLoad) firstLoad = false ;
            return screens()[index];
          }
          return const Center(child:  CircularProgressIndicator());
        }
      )
    );
  }


  List<BottomNavigationBarItem> navigationBarItems (bool lightTheme) => [
    BottomNavigationBarItem(

        icon: const Icon( Icons.queue_music_rounded , weight: 40, ),
        activeIcon: Icon(
          Icons.queue_music_rounded ,
          weight: 40,
          color: lightTheme ? ColorService.violet : ColorService.pink  ,
        ),
        label: AppLocalizations.of(context)!.all_songs
    ),
    BottomNavigationBarItem(

        icon: const Icon( Icons.favorite , weight: 40, ),
        activeIcon: Icon(
          Icons.favorite ,
          weight: 40,
          color: lightTheme ? ColorService.red : ColorService.pink  ,
        ),
        label: AppLocalizations.of(context)!.favorite_songs
    ),
  ];

  List<Widget> screens () =>  [
    const BuildAllPlayedSongs(),

    const BuildFavoritePlayedSongs()
  ];
}
