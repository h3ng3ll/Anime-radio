
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/providers/playerViewPage/SongsProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/databases/DatabaseRadioStations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:provider/provider.dart';

class BuildPlayButton extends StatefulWidget {


  const BuildPlayButton({Key? key, required this.delta}) : super(key: key);

  /// when image expanded max height
  /// RemoveAllSongSession button is disable
  /// and playOrPause button get shape to new size and position
  final double delta ;



  @override
  State<BuildPlayButton> createState() => _BuildPlayButtonState();
}

class _BuildPlayButtonState extends State<BuildPlayButton> {

  bool isPlaying = false;

  final alpha = 0.05;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializationPlayerEvents();

  }

  void initializationPlayerEvents () {

    final provider = Provider.of<SongsProvider>(context , listen:  false);

    provider.flutterRadioPlayer.isPlaying()
        .then((value) {
      isPlaying = value ?? false;
      setState(() {});
    });

    provider.flutterRadioPlayer.isPlayingStream?.listen((play) {

      switch (play) {
        case FlutterRadioPlayer.flutter_radio_paused:
          isPlaying = false ;

          break;
        case FlutterRadioPlayer.flutter_radio_loading:
          break;
        case FlutterRadioPlayer.flutter_radio_error:
          isPlaying = false;

          break;
        case FlutterRadioPlayer.flutter_radio_playing:
          isPlaying = true;

          break;
        default: isPlaying = false ;
      }
      if(mounted) {
        setState(() { });
      }
    });

  }

  void onPressedButton () async {
    final songsProvider = Provider.of<SongsProvider>(context , listen:  false);

    /// Pause Button
    if(isPlaying){
      await songsProvider.flutterRadioPlayer.pause();
    }
    /// Play Button
    else {
        await songsProvider.flutterRadioPlayer.play();

        /// did we tried to play song  but player has not attached ?
        bool? status =  await songsProvider.flutterRadioPlayer.isPlaying();

        if(!status!) {
          final activeStationIndex = songsProvider.activeStationIndex; // DatabaseRadioStations.getStations.map((e) => e.name).toList().indexOf(songsProvider.activeStationIndex);

          final activeStation = DatabaseRadioStations.getStations[activeStationIndex!];

          await songsProvider.hardReload(activeStation);
        }

    }
  }

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeProvider>(context , listen:  false).currentTheme;

    return ElevatedButton(
      onPressed: onPressedButton,
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: Size(widget.delta*alpha*50, widget.delta*alpha*50),
          backgroundColor: theme == ThemeMode.dark ? ColorService.lilac : ColorService.violet,

      ),
      child:  Icon(isPlaying ?    Icons.pause_outlined : Icons.play_arrow ,size: 25+widget.delta*0.8,)   ,
    );
  }
}
