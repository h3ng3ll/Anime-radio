

import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/src/dialogs/BuildRemoveAllSongsDialog.dart';
import 'package:anime_radio/src/models/Song.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:anime_radio/src/widgets/shared/BuildPlayedSongs.dart';
import 'package:anime_radio/src/widgets/homePage/PlayingSongTitle.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';


class ListPlayedSongs extends StatefulWidget{

  @override
  State<ListPlayedSongs> createState() => _ListPlayedSongsState();
}

class _ListPlayedSongsState extends State<ListPlayedSongs> {


  String formatTime (DateTime time) {

    final locale = L10n.all[L10n.nameLanguages
        .indexOf(AppLocalizations.of(context)!.language)].languageCode;

      return DateFormat("dd MMMM yyyy" , locale).format(time);

  }

  @override
  Widget build(BuildContext context) {


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
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.02),
          const BuildPlayingTitle(),
          SizedBox(height: MediaQuery.of(context).size.height*0.02),
          FutureBuilder<List<SavedSong>>(
            future: LocalStorageService.restoreSongs(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                final songs = snapshot.data;

                return Expanded(
                  child: GroupedListView<SavedSong , DateTime>(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      elements:  songs! ,
                      groupBy: (element) => DateTime(
                        element.whenPlayed.year,
                        element.whenPlayed.month,
                        element.whenPlayed.day
                      ),
                      groupSeparatorBuilder: (date) => Text(formatTime(date) , style:  const TextStyle(fontSize: 24) , textAlign: TextAlign.center,),

                      itemBuilder: (context , song) {
                        return BuildPlayedSongItem(song: song);
                      },
                  ),
                );
              }
              return Container();


            }
          )
        ],
      ),
    );
  }
}
