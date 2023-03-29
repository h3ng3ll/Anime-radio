
import 'package:anime_radio/src/databases/DatabaseImages/DatabaseImages.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildImage/BuildDownloadButton.dart';
import 'package:anime_radio/src/widgets/playerViewPage/BuildImage/BuildImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BuildImageViewPage extends StatefulWidget {

  final String imageURL ;
  final DatabaseImages db ;

   const BuildImageViewPage({
      Key? key,
     required this.imageURL,
     required this.db
  }) : super(key: key);

  @override
  State<BuildImageViewPage> createState() => _BuildImageViewPageState();
}

class _BuildImageViewPageState extends State<BuildImageViewPage> {

  bool visibleNavigation = true;

  late double y;
  late double x ;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    y = size.width /10;
    x = size.width /20;

    return Scaffold(
      body: Stack(
        children: [
          InkWell(
            onTap: ( ) {
              visibleNavigation = !visibleNavigation;

              visibleNavigation ?
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge) :
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

              setState(() {});
            },
            child: InteractiveViewer(
                maxScale: 5,
                child: BuildImage(imgUrl: widget.imageURL)
            ),
          ),

          if(visibleNavigation ) ...visibleNavigationWidgets()


        ],
      ),
    );
  }

  List<Widget> visibleNavigationWidgets () {

    final lightTheme = Provider.of<ThemeProvider>(context , listen:  false)
        .currentTheme == ThemeMode.light;

    return [
      /// Back Button
      Positioned(
          top: y,
          left: x,
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon:  Icon(
                Icons.arrow_back ,
                shadows: [Shadow(color: lightTheme ?  ColorService.white : ColorService.black , blurRadius: 25.0) ],
                size: 40,
              )
          )
      ),
      /// Download button
      Positioned(
          top: y,
          right: x,
          child: BuildDownloadButton(
            lightTheme: lightTheme,
            imageURL: widget.imageURL,
            databaseImages: widget.db,
          )
      )
    ];
  }
}


