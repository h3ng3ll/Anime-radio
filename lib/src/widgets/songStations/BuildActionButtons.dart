

import 'package:anime_radio/src/models/Settings.dart';
import 'package:anime_radio/src/providers/playerViewPage/PlayerDesignProvider.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildPlayButton.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildRemoveAllSongSession.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildActionButtons extends StatelessWidget {

  const BuildActionButtons({Key? key, required this.settings}) : super(key: key);

  final Settings settings ;

  @override
  Widget build(BuildContext context) {

    final designProvider = Provider.of<PlayerDesignProvider>(context);

    final showSongPreview = designProvider.showSongPreview;
    final delta = designProvider.delta;

    return Row(
      mainAxisAlignment: showSongPreview ?  MainAxisAlignment.spaceAround : MainAxisAlignment.center,
      children: [
        /// play button
         BuildPlayButton(delta: delta, ),

        /// remove button
        if(settings.showSongsTable && showSongPreview)
            BuildRemoveAllSongSession(delta: delta,)
      ],
    );
  }
}
