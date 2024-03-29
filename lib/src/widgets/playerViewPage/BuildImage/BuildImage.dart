import 'package:anime_radio/src/services/ColorService.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({
    super.key,
    required this.imgUrl,
    this.width,
    this.height ,
    this.scale ,
    this.fit = BoxFit.fitWidth,
  });

  final String? imgUrl ;
  final double? height ;
  final double? width ;
  final double? scale;
  final BoxFit fit ;


  final alignment = const  Alignment(0.0 , -0.6);

  @override
  Widget build(BuildContext context) {

    if(imgUrl == null) {
      return  Align(
          alignment: alignment,
          child: const CircularProgressIndicator()
      );
    }

    return CachedNetworkImage(
        imageUrl: imgUrl!,
        imageBuilder: (BuildContext context , ImageProvider imageProvider) => ClipRRect(
          borderRadius: BorderRadius.circular( 25),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider ,
                    fit:  fit ,
                )
            ),
            // color: Colors.green,
            width: width ,
            height:  height,
          ),
        ),
        placeholder: (context, url) => Align(
            alignment: alignment,
            child: const CircularProgressIndicator()
        ),
        errorWidget: (context, url, error) => Container(

          width:  width,
          height: height ,
          decoration: const BoxDecoration(
              image:    DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/unableLoadImage.jpg",
                ),
              )
          ),
          child:  Align(
            alignment: const Alignment(0.0, -0.6),
            child: Text(error.toString() , style: const TextStyle(fontSize: 24 , color: ColorService.white),),
          ),
        )
    );
  }
}
