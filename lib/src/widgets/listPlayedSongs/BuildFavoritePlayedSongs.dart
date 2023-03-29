

import 'package:anime_radio/src/models/Song.dart';
import 'package:anime_radio/src/pages/ListPlayedSongsPage.dart';
import 'package:anime_radio/src/providers/playerViewPage/PlayedSongsProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:anime_radio/src/widgets/listPlayedSongs/painting/TrianglePainter.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildPlayedSongsTable.dart';
import 'package:anime_radio/src/widgets/playerViewPage/PlayingSongTitle.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

class BuildFavoritePlayedSongs extends StatefulWidget {


  const BuildFavoritePlayedSongs({Key? key,}) : super(key: key);

  @override
  State<BuildFavoritePlayedSongs>  createState() => _BuildFavoritePlayedSongsState();
}

class _BuildFavoritePlayedSongsState extends State<BuildFavoritePlayedSongs> {

  late ScrollController controller ;

  List<DateTime> unVisibleFilter = [];

  
  @override
  void initState() {
    super.initState();

    final provider = Provider.of<PlayedSongsProvider>(context , listen:  false);

    controller = ScrollController(initialScrollOffset: provider.offsetFavoriteSongs);

    unVisibleFilter = provider.unVisibleFilter ;

    controller.addListener(() {
      provider.offsetFavoriteSongs = controller.offset;
      LocalStorageService.saveScrollPositionAllFvrtSongs
        (controller.offset);
    });
  }

@override
  void dispose() {

    controller.removeListener(() { });
    controller.dispose();

    LocalStorageService.saveUnVisibleFilter(unVisibleFilter);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final provider = Provider.of<PlayedSongsProvider>(context , listen:  false);

    return   Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height*0.02),
        const BuildPlayingTitle(),
        SizedBox(height: MediaQuery.of(context).size.height*0.02),
        Expanded(
          child: GroupedListView<SavedSong , DateTime>(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            elements:  provider.favoriteSongs ,
            groupBy: (element) => DateTime(
                element.whenPlayed.year,
                element.whenPlayed.month,
                element.whenPlayed.day
            ),
            groupSeparatorBuilder: (date) => buildSeparateBuilder(date , size) ,
            indexedItemBuilder: (context , song  , index) {
              if(unVisibleFilter.contains(DateTime(song.whenPlayed.year , song.whenPlayed.month , song.whenPlayed.day))){
                return Container();
              } else {
                return BuildPlayedSongTableItem(
                  song: song  ,
                  useFaviriteSongColor: false,
                  colorInvertor: false,
                );
              }
            },
          ),
        ),

      ],
    );
  }

  Widget buildSeparateBuilder (DateTime date , Size size) {
    final using = unVisibleFilter.contains(date);
    return InkWell(
      onTap: () {
        if(using){
          unVisibleFilter.remove(date);
        } else {
          unVisibleFilter.add(date);
        }
        setState(() { });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height*0.025),
        child: Column(
          children: [
            Text(
              ListPlayedSongs.formatTime(date , context),
              style:  const TextStyle(
                fontSize: 24,
              ) ,
              textAlign: TextAlign.center,
            ),
            Align(
              alignment: const Alignment(0.9, 1.0),
              child: CustomPaint(
                painter: TrianglePainter(
                    flipped: using,
                    strokeColor: using ? ColorService.violet : ColorService.red
                ),
                child: const SizedBox(
                  height: 20,
                  width: 20,
                  // color: Colors.pink,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
