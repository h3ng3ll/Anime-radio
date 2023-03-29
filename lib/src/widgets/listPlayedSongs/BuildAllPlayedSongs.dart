


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

class BuildAllPlayedSongs extends StatefulWidget {


  const BuildAllPlayedSongs({Key? key}) : super(key: key);



  @override
  State<BuildAllPlayedSongs> createState() => _BuildAllPlayedSongsState();
}

class _BuildAllPlayedSongsState extends State<BuildAllPlayedSongs> {

  late final ScrollController controller ;

  List<SavedSong> songs = [];

  late List<DateTime> unVisibleFilter;

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<PlayedSongsProvider>(context , listen:  false);

    unVisibleFilter = provider.unVisibleFilter ;
    songs = provider.songs;


    controller =  ScrollController(initialScrollOffset:  provider.offsetAllSongs);
    controller.addListener(() {
      provider.offsetAllSongs = controller.offset;

      LocalStorageService.saveScrollPositionAllPlayedSongs
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height*0.02),
        const BuildPlayingTitle(),
        SizedBox(height: MediaQuery.of(context).size.height*0.02),

        buildGroupedList()
      ],
    );
  }

  Widget buildGroupedList () {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: GroupedListView<SavedSong , DateTime>(
        controller: controller ,
        physics: const BouncingScrollPhysics(),
        elements:  songs ,
        groupBy: (element) => DateTime(
            element.whenPlayed.year,
            element.whenPlayed.month,
            element.whenPlayed.day
        ),
        groupSeparatorBuilder: (date) => buildSeparateBuilder(date , size),
        indexedItemBuilder: (context , song  , index) {
          if(unVisibleFilter.contains(DateTime(song.whenPlayed.year , song.whenPlayed.month , song.whenPlayed.day))){
            return Container();
          } else {
            return InkWell(
                onTap:  ()  async  {
                  songs[index].favoriteSong  = !songs[index].favoriteSong;
                  await LocalStorageService.changeLikeStatusOfSongLocally(songs[index].favoriteSong, index);
                  setState(() {});
                },
                child: BuildPlayedSongTableItem(song: songs[index])
            );
          }
        },
      ),
    );
  }
}
