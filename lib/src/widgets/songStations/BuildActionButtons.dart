

import 'package:anime_radio/src/models/Settings.dart';
import 'package:anime_radio/src/providers/PlayerDesignProvider.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildPlayButton.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildRemoveAllSongSession.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildActionButtons extends StatefulWidget {

  const BuildActionButtons({Key? key, required this.settings}) : super(key: key);

  final Settings settings ;

  @override
  State<BuildActionButtons> createState() => _BuildActionButtonsState();
}

class _BuildActionButtonsState extends State<BuildActionButtons> {


  // void initializeNetworkConnectivity () {
  //   _networkConnectivity.initialize();
  //   _networkConnectivity.myStream.listen((source) {
  //     _source = source;
  //     print("source $_source");
  //
  //     switch  (_source.keys.toList()[0]){
  //       case ConnectivityResult.mobile:
  //         if(_source.values.toList()[0]) {
  //           text = "Mobile: Online";
  //           // isOnline = true;
  //         }
  //         else {
  //           text = "Mobile offline";
  //           // isOnline = false;
  //         }
  //         break;
  //       case ConnectivityResult.wifi:
  //         if(_source.values.toList()[0]){
  //           text = "Wifi : Online";
  //           // isOnline = true;
  //         }
  //         else{
  //           text = "Wifi offline" ;
  //           // isOnline = false;
  //         }
  //         break;
  //       case ConnectivityResult.none:
  //       default: text = "offline";
  //       // isOnline = false;
  //     }
  //     setState(() { });
  //     print("update");
  //   });
  // }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initializeNetworkConnectivity();
  }

  // Map _source = {ConnectivityResult.none : false};
  // final  NetworkConnectivityService _networkConnectivity =
  //     NetworkConnectivityService.instance;
  // String text = "";
  // bool isOnline = false;
  
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
        if(widget.settings.showSongsTable && showSongPreview)
            BuildRemoveAllSongSession(delta: delta,)
      ],
    );
  }
}
