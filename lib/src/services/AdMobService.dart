

import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';

/// IOS not suported yet
/// SingleTon class
class AdMobService {

  AdMobService._();


  static final _instance = AdMobService._();
  static AdMobService  get instance => _instance;


   final  AdmobInterstitial  interstitialAdBanner = AdmobInterstitial(
       adUnitId: AdMobService.getBannerAdUnitId()!,
       listener: (AdmobAdEvent event , Map<String , dynamic>? args){
         if (event == AdmobAdEvent.closed) AdMobService.instance.interstitialAdBanner.load();
       }
   )..load();

  final  AdmobInterstitial  interstitialAd = AdmobInterstitial(
      adUnitId: AdMobService.getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event , Map<String , dynamic>? args){
        if (event == AdmobAdEvent.closed) AdMobService.instance.interstitialAd.load();
      }
  )..load();
  
   final AdmobReward rewardAd = AdmobReward(
       adUnitId: AdMobService.getRewardBasedVideoAdUnitId()!,
       listener: (event , args) {
         if(event == AdmobAdEvent.closed) AdMobService.instance.rewardAd.load();
       }
   )..load();


  static String? getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2487920139507635/9775167642';
      // return 'ca-app-pub-3940256099942544/6300978111'; /// test
    }
    return null;
  }

  static String? getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2487920139507635/8404028610';
      // return 'ca-app-pub-3940256099942544/1033173712';  /// test
    }
    return null;
  }

  static String? getRewardBasedVideoAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2487920139507635/5969436968';
      // return 'ca-app-pub-3940256099942544/5224354917';    /// test

    }
    return null;
  }

  // AdMobService._internal();
  //
  // factory AdMobService() => _singleton;





}