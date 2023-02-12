

import 'dart:io';

/// IOS not suported yet
class AdMobService {

  String? getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2487920139507635/9775167642';
      // return 'ca-app-pub-3940256099942544/6300978111'; /// test
    }
    return null;
  }

  String? getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2487920139507635/8404028610';
      // return 'ca-app-pub-3940256099942544/1033173712';  /// test
    }
    return null;
  }

  String? getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2487920139507635/5969436968';
      // return 'ca-app-pub-3940256099942544/5224354917';    /// test

    }
    return null;
  }




}