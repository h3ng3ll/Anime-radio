

import 'package:anime_radio/src/databases/DatabaseRadioStations.dart';
import 'package:anime_radio/src/dialogs/BuildSearchSongDialog.dart';
import 'package:anime_radio/src/models/Song.dart';
import 'package:anime_radio/src/providers/playerViewPage/SongsProvider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildPlayingTitle extends StatefulWidget {
  const BuildPlayingTitle({Key? key}) : super(key: key);

  @override
  State<BuildPlayingTitle> createState() => _BuildPlayingTitleState();
}

class _BuildPlayingTitleState extends State<BuildPlayingTitle> {


  /// Normally show ${Compositor or Band} - ${name song}
  String nowPlaying (List<SavedSong> hasBeenPlaying , int index) {
    final stations = DatabaseRadioStations.getStations;
    // final index = stations.map((e) => e.name).toList().indexOf(activeStation);

    if (stations[index].noMeta) {
      return AppLocalizations.of(context)!
          .this_station_is_not_grant_inforation_about_played_track;
    } else if (hasBeenPlaying.isEmpty) {
      /// Information about track is lost
      return AppLocalizations.of(context)!.info_lost;
    }
    else {
      return "${hasBeenPlaying.last.compositor} - ${hasBeenPlaying.last.name} ";
    }
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<SongsProvider>(context);
    final hasBeenPlaying  = provider.haveBeenPlayingSongs;
    final index = provider.activeStationIndex;

    return InkWell(
        onLongPress: hasBeenPlaying.isEmpty ? null : () async   {
          await showDialog(
              context: context,
              builder: (context) => BuildSearchSongDialog(
                song: hasBeenPlaying.last,
              )
          );
        },
        child: Column(
          children: [
            Text(nowPlaying(hasBeenPlaying , provider.activeStationIndex!)),
            Align(
                alignment: Alignment.bottomRight,
                child: Text( "ST:${
                    DatabaseRadioStations.getStations[index!].name
                }"
                  ,)
            )
          ],
        )
    );
  }
}
