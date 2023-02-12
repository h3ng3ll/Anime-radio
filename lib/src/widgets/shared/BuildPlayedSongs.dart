import 'package:anime_radio/src/models/Song.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class BuildPlayedSongs extends StatelessWidget {

  final List<SavedSong> songs ;
  const BuildPlayedSongs({Key? key, required this.songs}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ListWheelScrollView(
        physics: const FixedExtentScrollPhysics(),
        itemExtent: 60.0,
        squeeze: 0.6,
        children: songs.map((song) =>
            BuildPlayedSongItem(song: song)).toList(),
        // itemCount: songs.length,
      ),
    );
  }
}

class BuildPlayedSongItem extends StatelessWidget {

  final SavedSong song ;
  const BuildPlayedSongItem({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final theme = Provider.of<ThemeProvider>(context , listen:  false).currentTheme;
    final borderColor = theme == ThemeMode.dark ? ColorService.white :  ColorService.black;

    BoxDecoration decoration ({bool leftSide = false }) => BoxDecoration(
        border: Border(
            right: BorderSide(color:  borderColor),
            top: BorderSide(color: borderColor),
            bottom: BorderSide(color: borderColor),
            left: leftSide ? BorderSide(color: borderColor) : BorderSide.none
        )
    );


    Widget buildTextField (String text , {bool leftSide = false}) => Expanded(
      child: Container(
        height: 40,
        decoration: decoration(leftSide: true) ,
        child: Align(
            alignment: Alignment.center,
            child: Text(text , textAlign: TextAlign.center,)
        )
      ),
    );

     return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0 , horizontal: 8.0),
      child: Row(
        children: [
          buildTextField(song.name , leftSide: true),
          buildTextField(song.compositor),
          buildTextField(DateFormat("hh:mm").format(song.whenPlayed))
        ],
      ),
    );
  }
}
