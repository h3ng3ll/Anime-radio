
import 'package:admob_flutter/admob_flutter.dart';
import 'package:anime_radio/src/dialogs/BuildDownloadStatusDialog.dart';
import 'package:anime_radio/src/services/AdMobService.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/services/ExternalStorageService.dart';
import 'package:flutter/material.dart';

class BuildDownloadButton extends StatefulWidget {
  const BuildDownloadButton({Key? key, required this.lightTheme, required this.imageURL}) : super(key: key);
  final bool lightTheme  ;
  final String imageURL ;
  @override
  State<BuildDownloadButton> createState() => _BuildDownloadButtonState();
}

class _BuildDownloadButtonState extends State<BuildDownloadButton> {



  late AdmobReward rewardAd ;
  late AdmobInterstitial interstitialAd ;

  bool  nowDownloadImage = false;

  @override
  void initState() {


    rewardAd = AdmobReward(
        adUnitId: AdMobService().getRewardBasedVideoAdUnitId()!,
        listener: (event , args) {
          if(event == AdmobAdEvent.closed) rewardAd.load();
        }
    )..load();

    interstitialAd = AdmobInterstitial(
        adUnitId: AdMobService().getInterstitialAdUnitId()!,
        listener: (event , args) {
          if(event == AdmobAdEvent.closed) rewardAd.load();
        }
    )..load();
    super.initState();
  }

  Future adMobService () async {
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

    await adMobService();

    // ignore: use_build_context_synchronously
    final status = await ExternalStorageService()
        .saveImageToGallery(widget.imageURL , context );

    // ignore: use_build_context_synchronously
    await showDialog(
        context: context,
        builder: (context) =>   BuildDownloadStatusDialog(status: status,)
    );


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

