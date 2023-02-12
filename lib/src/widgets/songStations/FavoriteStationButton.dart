

import 'package:anime_radio/src/models/MusicStation.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteStationButton extends StatefulWidget {
  
  final MusicStation songStation;
  const FavoriteStationButton({Key? key, required this.songStation}) : super(key: key);

  @override
  State<FavoriteStationButton> createState() => _FavoriteStationButtonState();
}

class _FavoriteStationButtonState extends State<FavoriteStationButton> {
  @override
  Widget build(BuildContext context) {

    final  themeProvider = Provider.of<ThemeProvider>(context , listen:  false);
    bool lightTheme = themeProvider.currentTheme == ThemeMode.light;


    return      IconButton(
        onPressed: () async {
          widget.songStation.favorite = !widget.songStation.favorite;
          Provider.of<Function(MusicStation)>(context , listen:  false)(widget.songStation) ;
          setState(() { });
        },
        icon:  Icon(
          !lightTheme || widget.songStation.favorite ? Icons.favorite  : Icons.favorite_border ,
          color: widget.songStation.favorite ? ColorService.red :
          !lightTheme ? ColorService.white :  null,
        )
    );

  }
}
