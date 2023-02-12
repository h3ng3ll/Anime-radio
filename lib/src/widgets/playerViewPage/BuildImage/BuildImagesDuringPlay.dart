

import 'package:admob_flutter/admob_flutter.dart';
import 'package:anime_radio/src/providers/AdMobProvider.dart';
import 'package:anime_radio/src/providers/PlayerDesignProvider.dart';
import 'package:anime_radio/src/services/AdMobService.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildImage/BuildImage.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildImage/BuildImageViewScreen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//  [ How should Work ] //
/// Image will had  changed until widget will be closed
/// Rendering of image not change this one  .
/// Rebuilding calls from SongStations class take new
/// song from SongProvider together with new image url .
class BuildImagesDuringPlay extends StatefulWidget {

  final String imgUrl ;
  const BuildImagesDuringPlay({super.key,required this.imgUrl});

  @override
  State<BuildImagesDuringPlay> createState() => _BuildImagesDuringPlayState();
}

class _BuildImagesDuringPlayState extends State<BuildImagesDuringPlay> {

  AdmobBannerSize? bannerSize ;

  late AdmobInterstitial admobInterstitial ;

  @override
  void initState() {
    loadAds();
    super.initState();
  }

  void loadAds() {
    bannerSize = AdmobBannerSize.FULL_BANNER;

    admobInterstitial = AdmobInterstitial(
        adUnitId: AdMobService().getInterstitialAdUnitId()!,
        listener: (event , args) {
          if(event == AdmobAdEvent.closed) admobInterstitial.load();
        }
    )..load();
  }


  void imageTap () {
    final adMobProvider = Provider.of<AdMobProvider>(context , listen:  false);

    final showAd = adMobProvider.increment();
    admobInterstitial.isLoaded.then((isLoaded) {

      if(isLoaded != null && isLoaded != false && showAd) {
        admobInterstitial.show();
      }

      Navigator.push(context, MaterialPageRoute(
          builder: (context) => BuildImageViewScreen(
              image: BuildImage(imgUrl: widget.imgUrl),
              imageURL: widget.imgUrl,
          )
      ));
    });
  }

  @override
  Widget build(BuildContext context) {

    final designProvider = Provider.of<PlayerDesignProvider>(context);
    final delta = designProvider.delta;
    final size = MediaQuery.of(context).size;


    return Expanded(
      flex: (delta/2).round(),
      child: GestureDetector(
        onTap: imageTap,
        onPanUpdate: (details) => designProvider.onPanUpdate(details),
        child: BuildImage(
            scale: delta,
            height: size.height/4 ,
            width: size.width,
            imgUrl: widget.imgUrl,
        ),
      ),
    );
  }
}

