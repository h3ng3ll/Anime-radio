

import 'package:flutter/cupertino.dart';

class AdMobProvider extends ChangeNotifier {

  int _showedBanner = 0 ;

  int get  showedBanner => _showedBanner ;


  bool increment () {

    _showedBanner++;

    /// we give ad to user
    if(showedBanner == 5) {
      _reset();
      return true;
    }
    /// still early give it to user
    else {
      return false ;
    }

  }

  void _reset () => _showedBanner = 0 ;
}