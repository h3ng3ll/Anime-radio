

import 'package:anime_radio/src/models/Settings.dart';
import 'package:anime_radio/src/providers/playerViewPage/PlayerDesignProvider.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildPlayedSongsTable.dart';
import 'package:anime_radio/src/widgets/playerViewPage/PlayingSongTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildPlayedSongsSession extends StatefulWidget {
  const BuildPlayedSongsSession({Key? key, required this.settings , }) : super(key: key);

  final Settings settings ;

  @override
  State<BuildPlayedSongsSession> createState() => _BuildPlayedSongsSessionState();
}

class _BuildPlayedSongsSessionState extends State<BuildPlayedSongsSession> {


  @override
  Widget build(BuildContext context) {
    final showSongPreview = Provider.of<PlayerDesignProvider>(context).showSongPreview;

    if(widget.settings.showSongsTable && showSongPreview) {
      return const Expanded(
          child:  Column(
            children: [

              /// Song Compositor When Played Station
               BuildPlayingTitle(),

              /// played in current session
               BuildPlayedSongsTable()

            ],
          )
      );
    }

    return Container();

  }
}
