import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/src/models/Song.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/providers/playerViewPage/PlayerDesignProvider.dart';
import 'package:anime_radio/src/providers/playerViewPage/SongsProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildPlayedSongsTable extends StatefulWidget {

  const BuildPlayedSongsTable({Key? key}) : super(key: key);

  @override
  State<BuildPlayedSongsTable> createState() => _BuildPlayedSongsTableState();
}

class _BuildPlayedSongsTableState extends State<BuildPlayedSongsTable> {

  List<SavedSong> songs = [];
  int index = 0;

  @override
  Widget build(BuildContext context) {

    final designProvider = Provider.of<PlayerDesignProvider>(context , listen:  true);

    final songs = Provider.of<SongsProvider>(context , )
        .haveBeenPlayingSongs.reversed.toList();

    if (!designProvider.showSongPreview){
      return Container();
    }

    return Expanded(
      child: InkWell(
        onTap: songs.isEmpty ? null  :  () {
                          /// same as reversed
          final index = (songs.length - this.index -1);
          Provider.of<SongsProvider>(context , listen:  false).changeLikeStatus(index);
          setState(() {});
        },
        child: ListWheelScrollView(
          onSelectedItemChanged: (index ) => this.index = index,
          physics: const FixedExtentScrollPhysics(),
          itemExtent: 90.0,
          squeeze: 0.9,
          children: songs.map((song) => BuildPlayedSongTableItem(song: song)).toList(),
          // itemCount: songs.length,
        ),
      ),
    );
  }
}

class BuildPlayedSongTableItem extends StatefulWidget {

  final SavedSong song ;

  final bool useFaviriteSongColor ;

  /// used only to set up specific decoration style .
  final bool colorInvertor;
  const BuildPlayedSongTableItem({
    Key? key,
    required this.song,
    this.useFaviriteSongColor = true,
    this.colorInvertor =  true ,

  }) : super(key: key);

  @override
  State<BuildPlayedSongTableItem> createState() => _BuildPlayedSongTableItemState();
}

class _BuildPlayedSongTableItemState extends State<BuildPlayedSongTableItem> {
  TableRow table (SavedSong song , bool lightTheme)  {

    const  alignment =  TextAlign.center;

    final style = TextStyle(
      /// null - default . If light theme - black color else - black
      color:
      song.favoriteSong && lightTheme && widget.colorInvertor ?
      ColorService.white :
      song.favoriteSong && lightTheme && !widget.colorInvertor ?
      ColorService.black : null
    );


    return TableRow(
        decoration: BoxDecoration(
            color: song.favoriteSong && widget.useFaviriteSongColor ?
            ColorService.violet : null
        ),
        children:  [
          Text(song.name  , textAlign: alignment , style: style,),
          Text(song.compositor , textAlign: alignment , style: style,),
          Text(
              DateFormat("HH:mm").format(song.whenPlayed) ,
              style: style,
              textAlign: alignment,
              locale: L10n.all[L10n.nameLanguages.indexOf(AppLocalizations.of(context)!.language)]
          ),
          Text(song.musicStation , textAlign: TextAlign.center, style: style,),
        ].map((child) => Padding(
          padding: const EdgeInsets.all(15),
          child: child,
        )).toList()
    );

  }

  @override
  Widget build(BuildContext context) {

    final lightTheme = Provider.of<ThemeProvider>(context , listen:  false)
        .currentTheme == ThemeMode.light;

    final borderColor = lightTheme && !widget.song.favoriteSong ||
             !widget.colorInvertor &&  lightTheme ?
                                      ColorService.black :
                                      ColorService.white;

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(color: borderColor),
      children: <TableRow>[ table(widget.song , lightTheme)  ],
    );

  }
}
