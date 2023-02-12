
import 'dart:math';

import 'package:anime_radio/src/services/ImageService.dart';
import 'package:flutter/material.dart';

class BuildImagesDuringPlay extends StatefulWidget {

  final bool takeSizeLimit  ;

  const BuildImagesDuringPlay({super.key,  this.takeSizeLimit = false});


  @override
  State<BuildImagesDuringPlay> createState() => _BuildImagesDuringPlayState();


}

class _BuildImagesDuringPlayState extends State<BuildImagesDuringPlay> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.takeSizeLimit ? 0 : 25),
      child: SizedBox(
          width: widget.takeSizeLimit ? size.width : size.width/1.5,
          height: widget.takeSizeLimit ? size.height*0.7 :  size.height/2,
        child: Image.network(
          ImageService.images[Random().nextInt(ImageService.images.length)] ,
          fit: BoxFit.cover,
          frameBuilder: (context , child , frame , loaded) => child,
          loadingBuilder: (context , child , loadingProgress){
            if(loadingProgress == null) return child ;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

}
