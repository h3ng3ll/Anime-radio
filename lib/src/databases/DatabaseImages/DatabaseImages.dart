

import 'dart:math';

enum DatabaseImagesGenres {
  anime ,
  metal ,
}

abstract class DatabaseImages {

  final  List<String> images;
  final   DatabaseImagesGenres genre;

  DatabaseImages( this.genre , this.images,);


  String randomImage () => images[Random().nextInt(images.length-1)];
}