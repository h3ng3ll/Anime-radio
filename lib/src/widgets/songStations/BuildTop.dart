import 'package:admob_flutter/admob_flutter.dart';
import 'package:anime_radio/src/services/AdMobService.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildOnlineStatus.dart';
import 'package:flutter/material.dart';

class BuildTop extends StatelessWidget {
  const BuildTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Row(
      children:  [
          const BackButton(),
          Expanded(
            child: AdmobBanner(
                adUnitId: AdMobService.getBannerAdUnitId()!,
                adSize: AdmobBannerSize.ADAPTIVE_BANNER(width: size.width~/1.3)
            ),
          ),

          const Padding(
            padding:  EdgeInsets.only(left: 15.0),
            child:  BuildOnlineStatus(),
          ),
      ],
    );
  }
}
