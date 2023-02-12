

import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:flutter/widgets.dart';

class PlayerDesignProvider extends ChangeNotifier {


  bool _showSongPreview = true;

  double _delta  = 1 ;

  /// Scale of height coefficient
  double get delta => _delta;

  /// show same as title and information
  /// about played songs
  bool get  showSongPreview => _showSongPreview ;

  PlayerDesignProvider (){
    LocalStorageService.getScaleImagePosition().then(
        (delta) {
          _delta = delta ?? 15;
          _showOrHideSongPreview(_delta);
        }
    );
  }



  void onPanUpdate (DragUpdateDetails details) {

    /// update coefficient
    const  alpha = 0.075 ;

    if(_delta + details.delta.dy*alpha >= 0.01 && _delta + details.delta.dy*alpha <= 40){

       _delta += details.delta.dy*alpha ;

       _showOrHideSongPreview(_delta)  ;

       saveToStorage();
    }
      notifyListeners();

  }

  void _showOrHideSongPreview (double delta) {
    if(delta >= 26 ) {
      _showSongPreview = false;
    } else {
      _showSongPreview = true;
    }
  }

  void saveToStorage () {
    LocalStorageService.saveScaleImagePosition(delta);
  }
}