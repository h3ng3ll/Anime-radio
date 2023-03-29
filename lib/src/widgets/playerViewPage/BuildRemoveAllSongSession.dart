
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/providers/playerViewPage/PlayerDesignProvider.dart';
import 'package:anime_radio/src/providers/playerViewPage/SongsProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildRemoveAllSongSession extends StatelessWidget {

  const BuildRemoveAllSongSession({Key? key, required this.delta}) : super(key: key);

  final double delta ;
  final alpha = 0.05;

  @override
  Widget build(BuildContext context) {
    final showSongPreview = Provider.of<PlayerDesignProvider>(context ).showSongPreview;
    final theme = Provider.of<ThemeProvider>(context , listen:  false).currentTheme;

    if(showSongPreview){
      return ElevatedButton(
        onPressed: () {
          Provider.of<SongsProvider>(context , listen:  false).clearSongs();
        },
        style: ElevatedButton.styleFrom(
            fixedSize: Size(delta*alpha*50, delta*alpha*50),
            shape: const CircleBorder(),
            backgroundColor: theme == ThemeMode.dark ? ColorService.lilac : ColorService.violet,
        ),
        child:  Icon(Icons.playlist_remove , size: 25+delta*0.8, ),
      );
    }
    else {
      return Container() ;
    }

  }
}
