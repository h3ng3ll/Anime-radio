

import 'package:anime_radio/src/models/Settings.dart';
import 'package:anime_radio/src/models/Song.dart';

import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:anime_radio/src/widgets/homePage/BuildImagesDuringPlay.dart';
import 'package:anime_radio/src/widgets/homePage/BuildPlayButton.dart';
import 'package:anime_radio/src/widgets/shared/BuildPlayedSongs.dart';
import 'package:anime_radio/src/dialogs/BuildSearchSongDialog.dart';
import 'package:anime_radio/src/widgets/homePage/BuildSoundSlider.dart';
import 'package:anime_radio/src/widgets/MyDrawer.dart';
import 'package:anime_radio/src/widgets/homePage/PlayingSongTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();


}

class _HomePageState extends State<HomePage> {

  final _flutterRadioPlayer = FlutterRadioPlayer();
  final  String urlStream = "http://animeradio.su:8000";

  bool isPlaying = false ;

  List<SavedSong> hasBeenPlaying = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRadioService();
  }



  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init(
        "animeradio.su",
        "Live",
        urlStream,
        "false",
        primaryColor: ColorService.darkGrey
      );
    } on PlatformException {
      throw Exception("Exception occurred while trying to register the services.");
    }


    _flutterRadioPlayer.isPlayingStream!.listen((play) {


      switch (play) {
        case FlutterRadioPlayer.flutter_radio_error: isPlaying = false;  break;
        case FlutterRadioPlayer.flutter_radio_playing: isPlaying = true; break;
      }
    });
  }




  void saveSongToPlaying(String? title) async{
    if(title == null) return ;

    final listOfParts = title.split(" - ");
    SavedSong song = SavedSong(listOfParts[0], listOfParts[1], DateTime.now());
    /// check if same song added twice
    if(hasBeenPlaying.isEmpty || "${hasBeenPlaying.last.name} - ${hasBeenPlaying.last.compositor}" != title){

      hasBeenPlaying.add(song);
      await LocalStorageService.saveSong(hasBeenPlaying);
    }
  }

  String? formatTitle (String? meta) {
    final part1 = meta?.split(',')[0];
    final pattern = RegExp(r'title="*"');
    final part2 = part1?.split(pattern)[1];
    return part2?.substring(0 , part2.length-1);
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),

      drawer: Drawer(
          child: MyDrawer(update: () => setState(() { })),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: _flutterRadioPlayer.metaDataStream,
            builder: (context , snapshot) {

              final title = formatTitle(snapshot.data);

              saveSongToPlaying(title);

              return FutureBuilder<Settings>(
                future: LocalStorageService.getSettings(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    final settings = snapshot.data!;

                    return Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: size.height*0.04,),
                        /// image and sound slider
                        Row(
                          children: [
                              Spacer(flex: (settings.removeSoundSlider ?  3 : 1)),
                            if(settings.removeImage ) BuildImagesDuringPlay(takeSizeLimit:  (!settings.removeListLastSongs && !settings.removeSoundSlider )  ),
                              Spacer(flex: (settings.removeSoundSlider ? 1 : 1 ) ),
                            if(settings.removeSoundSlider) BuildSoundSlider(updateSlider: (double volume)  => _flutterRadioPlayer.setVolume(volume))
                          ],
                        ),
                        /// play and remove tracks
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            /// play button
                            BuildPlayButton(
                              playOrPause: () async => await _flutterRadioPlayer.playOrPause(),
                              isPlaying: isPlaying,
                            ),
                            /// remove button
                            if(settings.removeListLastSongs)  ElevatedButton(
                              onPressed: () => setState(() =>   hasBeenPlaying = []),
                              style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                              child: const Icon(Icons.playlist_remove),
                            )
                          ],
                        ),
                        /// what play now
                        InkWell(
                            onLongPress: () async  {
                              await showDialog(
                                  context: context,
                                  builder: (context) => BuildSearchSongDialog(
                                    song: hasBeenPlaying.last,)
                              );
                            },
                            child: Text("${AppLocalizations.of(context)!.now_play }: \t\t ${title ?? AppLocalizations.of(context)!.info_lost}")
                        ),
                        SizedBox(height: size.height*0.03),
                        SizedBox(height: size.height*0.01),
                        if(settings.removeListLastSongs)  const BuildPlayingTitle(),
                        /// played in past
                        if(settings.removeListLastSongs) BuildPlayedSongs(songs: hasBeenPlaying.reversed.toList())
                      ],
                    );
                  }
                  return Container();
                }
              );
            }
        ),
      ),
    );
  }


}

