
import 'package:admob_flutter/admob_flutter.dart';
import 'package:anime_radio/src/databases/DatabaseImages/DatabaseImages.dart';
import 'package:anime_radio/src/dialogs/BuildDownloadStatusDialog.dart';
import 'package:anime_radio/src/providers/playerViewPage/SongsProvider.dart';
import 'package:anime_radio/src/services/AdMobService.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/services/ExternalStorageService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildDownloadButton extends StatefulWidget {
  const BuildDownloadButton({
    Key? key,
    required this.lightTheme,
    required this.imageURL, required this.databaseImages
  }) : super(key: key);
  final bool lightTheme  ;
  final String imageURL ;
  final DatabaseImages databaseImages;

  @override
  State<BuildDownloadButton> createState() => _BuildDownloadButtonState();
}

class _BuildDownloadButtonState extends State<BuildDownloadButton> {



  final AdmobReward rewardAd = AdMobService.instance.rewardAd;
  final  AdmobInterstitial interstitialAd = AdMobService.instance.interstitialAdBanner;
  bool  nowDownloadImage = false;



  Future adMobService (SongsProvider provider) async {
    await provider.flutterRadioPlayer.stop();
    if(await rewardAd.isLoaded){
      rewardAd.show();
    }
    else if (await interstitialAd.isLoaded ?? false){
      interstitialAd.show();
      debugPrint("reward iad is still loading ");
    }
  }

  void onPressed () async {

    setState(() => nowDownloadImage = true );

    final provider = Provider.of<SongsProvider>(context , listen:  false);

    await adMobService(provider);

    // ignore: use_build_context_synchronously
    final status = await ExternalStorageService()
        .saveImageToGallery(widget.imageURL , context , widget.databaseImages );

    // ignore: use_build_context_synchronously
    await showDialog(
        context: context,
        builder: (context) =>   BuildDownloadStatusDialog(status: status,)
    );

    await provider.flutterRadioPlayer.play();

    setState(() => nowDownloadImage = false );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon:  Icon(
          Icons.save_alt_outlined,
          color: widget.lightTheme ? ColorService.black : ColorService.white,
          shadows: [ Shadow(color: widget.lightTheme ?  ColorService.white : ColorService.black , blurRadius: 25.0) ],
          size: 40,
        )
    );
  }
}

