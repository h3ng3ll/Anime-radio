

import 'package:flutter/cupertino.dart';

class TrianglePainter extends CustomPainter {

  final Color strokeColor ;
  final bool flipped;
  TrianglePainter( {required this.flipped, required this.strokeColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = strokeColor;

        if(flipped) {
          canvas.drawPath(flippedTrianglePath(size.width, size.width), paint);
        }
        else {
          canvas.drawPath(trianglePath(size.width, size.width), paint);
        }

  }

  Path trianglePath (double x , double y) => Path()
        ..moveTo(0, y)
        ..lineTo(x/2, 0)
        ..lineTo(x, y)
        ..lineTo(0, y);


  Path flippedTrianglePath (double x , double y) => Path()
        ..lineTo(x/2, y)
        ..lineTo(x, 0)
        ..lineTo(0, 0);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}