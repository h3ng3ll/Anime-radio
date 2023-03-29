

import 'package:admob_flutter/admob_flutter.dart';
import 'package:anime_radio/src/providers/AdMobProvider.dart';
import 'package:anime_radio/src/providers/SettingsProvider.dart';
import 'package:anime_radio/src/providers/playerViewPage/PlayerDesignProvider.dart';
import 'package:anime_radio/src/providers/playerViewPage/SongsProvider.dart';
import 'package:anime_radio/src/services/AdMobService.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildImage/BuildAnimatedImage.dart';
import 'package:anime_radio/src/pages/HomePage/SongStations/BuildImageViewPage.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildImage/BuildImage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//  [ How should Work ] //
/// Image will had  changed until widget will be closed
/// Rendering of image not change this one  .
/// Rebuilding calls from SongStations class take new
/// song from SongProvider together with new image url .
class BuildImagesDuringPlay extends StatelessWidget {
   BuildImagesDuringPlay({super.key});

  /// ad
  final  bannerSize = AdmobBannerSize.FULL_BANNER ;

  final  admobInterstitial = AdMobService.instance.interstitialAd;

  void imageTap (String? imgUrl , BuildContext context , SongsProvider provider) {
    final adMobProvider = Provider.of<AdMobProvider>(context , listen:  false);

    final showAd = adMobProvider.increment();
    admobInterstitial.isLoaded.then((isLoaded) async {

      /// conditions to load ads
      if(isLoaded != null && isLoaded != false && showAd) {
        admobInterstitial.show();
      }
      else if (imgUrl == null) {
        return;
      }

      /// go to image preview
       await  Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: provider,
            child: BuildImageViewPage(
                imageURL: imgUrl!,
                db: provider.databaseImages,
            ),
          )
      ));

    });
  }


  @override
  Widget build(BuildContext context) {

    final settings = Provider.of<SettingsProvider>
      (context , listen: false).settings;

    /// Do images are disabled .
    if(!settings.showImageDuringPlaying) return Container();

    /// Img height delta
    final designProvider = Provider.of<PlayerDesignProvider>(context);
    final delta = designProvider.delta;

    /// img url
    final  provider = Provider.of<SongsProvider>(context);
    final imgUrl  = provider.imgUrl;

    final size = MediaQuery.of(context).size;

    return Expanded(
      flex: (delta/2).round(),
      child: GestureDetector(
        onTap: () => imageTap(imgUrl , context , provider),
        onPanUpdate: (details) => designProvider.onPanUpdate(details),

        /// Animate or not the image .
        child: !settings.disableImageAnimations && !settings.disableAllAnimations ?
            BuildAnimatedImage(
              scale: delta,
              imgUrl: imgUrl,
              update: () {
                provider.changeImgPreview(update: true);
              }
            ) :
            BuildImage(
              imgUrl: imgUrl,
              scale: delta,
              height: size.height/4 ,
              width: size.width,
          ),
      )
    );
  }
}

