

import 'package:anime_radio/src/models/MusicStation.dart';
import 'package:anime_radio/src/models/Settings.dart';

import 'package:anime_radio/src/widgets/songStations/BuildActionButtons.dart';
import 'package:anime_radio/src/widgets/songStations/BuildTop.dart';
import 'package:anime_radio/src/providers/SongsProvider.dart';

import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildImage/BuildImagesDuringPlay.dart';
import 'package:anime_radio/src/dialogs/BuildSearchSongDialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import '../../../widgets/songStations/BuildPlayedSongs.dart';



class PlayerViewPage extends StatefulWidget {

  final MusicStation musicStation ;

  const PlayerViewPage({Key? key, required this.musicStation}) : super(key: key);

  @override
  State<PlayerViewPage> createState() => _PlayerViewPageState();


}

class _PlayerViewPageState extends State<PlayerViewPage> {




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSongStation();
 }
 
  void initializeSongStation () {
    final savedSongProvider = Provider.of<SongsProvider>(context , listen:  false);
    savedSongProvider.initRadioService(widget.musicStation , widget.musicStation.metaFormat,);
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final provider = Provider.of<SongsProvider>(context);
    final hasBeenPlaying  = provider.haveBeenPlayingSongs;
    final imgUrl  = provider.imgUrl;


    return Scaffold(

      body: SafeArea(
        child: FutureBuilder<Settings>(
            future: LocalStorageService.getSettings(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                final settings = snapshot.data!;

                return Column(

                  children: [
                    SizedBox(height: size.height*0.02,),
                    /// back button , Internet Connection Status and Station name .
                    const BuildTop(),
                    /// image
                    if(settings.showImageDuringPlaying ) BuildImagesDuringPlay(
                      imgUrl: imgUrl,
                    ),
                    SizedBox(height: size.height*0.02,),
                    /// play and remove tracks
                    BuildActionButtons(settings: settings,),
                    SizedBox(height: size.height*0.02,),

                    /// Now playing Fairy Tail (Hero)
                    InkWell(
                        onLongPress: hasBeenPlaying.isEmpty ? null : () async   {
                            await showDialog(
                                context: context,
                                builder: (context) => BuildSearchSongDialog(song: hasBeenPlaying.last,)
                            );
                        },
                        child: Column(
                          children: [
                            Text(
                                "${AppLocalizations.of(context)!.now_playing }:"
                                    " \t\t ${hasBeenPlaying.isNotEmpty  ?
                                        "${hasBeenPlaying.last.name} - ${hasBeenPlaying.last.compositor} " :
                                        AppLocalizations.of(context)!.info_lost} ",
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: Text( "ST:${Provider.of<SongsProvider>(context, listen: false).activeStation}",)
                            )
                          ],
                        )
                    ),
                    SizedBox(height: size.height*0.04),

                    ///     Song          Compositor   When Played   Station
                    /// Fairy Tail (Hero)   Tenohira    08:34         Anison
                    BuildPlayedSongsSession(settings: settings,)
                    ],
                );
              }
              return Container();
            }
        ),
      )
    );

  }


}

