


import 'dart:math';

import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PazzlePainting extends CustomPainter {

  final bool  firstPazzle ;
  final bool lastPazzle ;

  PazzlePainting({this.firstPazzle = false , this.lastPazzle = false});

  factory PazzlePainting.firstPazzle() => PazzlePainting(firstPazzle: true);

  factory PazzlePainting.lastPazzle() => PazzlePainting(lastPazzle: true);



  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..strokeWidth  = 8
      ..style = PaintingStyle.stroke
      ..color = ColorService.violet;

    if(firstPazzle) {
      canvas.drawPath(drawFirstPazzle(size), paint);
    }
    else if (lastPazzle) {
      canvas.drawPath(drawBetweenPazzle(size), paint);

    }
    else {
      canvas.drawPath(drawBetweenPazzleMan(size), paint);
    }





  }

  Path drawFirstPazzle (Size size) {

    final rect = Rect.fromCenter(
        center: Offset(1.4* size.width/4, size.height/2),
        width: size.width/4,
        height: size.height/4
    );

   return  Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)

      ..lineTo(0, 5 * size.height/8)

      ..cubicTo(
          size.width/30, 18 * size.height/32,
          size.width/8, 15 * size.height/32,
          8.1*size.width/30,  19 * size.height/32)
      ..arcTo(
          rect,
          1.6 * pi/2,
          1.6 * -pi,
          // true
          false)
      ..cubicTo(
          size.width/8,  17 * size.height/32,
          size.width/30,  15 * size.height/32,
          0, 3 * size.height/8)
      ..lineTo(0, 0);
  }

  Path drawBetweenPazzle (Size size) {


    final rect = Rect.fromCenter(
        center: Offset(1.4* size.width/4, size.height/2),
        width: size.width/4,
        height: size.height/4
    );

    final rect2 = Rect.fromCenter(
        center: Offset(
            size.width - 1.4* size.width/4,
            size.height - size.height/2),
        width: size.width/4,
        height: size.height/4
    );

    return Path()
      ..moveTo(0, 5 * size.height/8)

      ..cubicTo(
          size.width/30, 18 * size.height/32,
          size.width/8, 15 * size.height/32,
          8.1*size.width/30,  19 * size.height/32)
      ..arcTo(
          rect,
          1.6 * pi/2,
          1.6 * -pi,
          // true
          false)
      ..cubicTo(
          size.width/8,  17 * size.height/32,
          size.width/30,  15 * size.height/32,
          0, 3 * size.height/8)

      ////////////////////

      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      /// paint until center
      ..lineTo(  size.width, 3 * size.height/8)

      ////////////////////

      ..cubicTo(

          size.width - size.width/30, size.height -  17 * size.height/32,
        size.width - size.width/8, size.height -  15 * size.height/32,
        size.width - 8.1*size.width/30, size.height - 19 * size.height/32,
      )
      ..arcTo(
          rect2,
          3 * pi/2,
          1.4 * -pi,
          // true
          false
      )
      ..cubicTo(


        size.width - size.width/8,   15 * size.height/32,
        size.width - size.width/30,  17 * size.height/32,

        size.width, 5 * size.height/8,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 5 * size.height/8)
    ;
  }

  Path drawBetweenPazzleMan (Size size) {
    return Path()
      ..moveTo(size.width/2, size.height)
      ..lineTo(size.width/2, 5 * size.height/8)
      ..cubicTo(
          27*size.width/30, 18 * size.height/32,
          5*size.width/8, 15 * size.height/32,
           21*size.width/30,  19 * size.height/32)    ;
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}