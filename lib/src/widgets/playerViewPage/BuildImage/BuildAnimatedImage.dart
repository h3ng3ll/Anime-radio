
import 'package:anime_radio/src/widgets/playerViewPage/BuildImage/BuildImage.dart';
import 'package:flutter/material.dart';


class BuildAnimatedImage extends StatefulWidget {
  const BuildAnimatedImage({
    Key? key,
    required this.scale,
    required this.update,
    required this.imgUrl
  }) : super(key: key);

  final String? imgUrl;
  final double scale;
  final Function () update;

  @override
  State<BuildAnimatedImage> createState() => _BuildAnimatedImageState();
}

class _BuildAnimatedImageState extends State<BuildAnimatedImage> with TickerProviderStateMixin{
  late AnimationController transformController;

  late AnimationController opacityController ;
  late Animation<double> splashAnimation ;

  /// cycle of image animation .
  int cycle = 1;




  @override
  void initState() {
    super.initState();

    // widget.update();

    transformController  = AnimationController(
      vsync: this ,
      duration: const Duration(seconds: 16),
    )..repeat();

    opacityController  = AnimationController(
      vsync: this ,
      duration: const Duration(seconds: 1),
    )..forward();

    splashAnimation = CurveTween(curve: Curves.elasticOut ).animate(opacityController);



    transformController.addListener(() {

      if(transformController.isDismissed) {

        ///  the last sign of  frame is the splash animation
        cycle ++; if(cycle == 5 ) {
          cycle = 1 ;
          opacityController..reset()..forward();
          widget.update();
        }

        transformController.forward();
      }
    });
  }



  /// paint 8 pattern
  Offset movingLogicTheEight () {

    // print(opacityController.value);
    late Offset offset ;

    switch (cycle){
      case 1:  offset = Offset(
          -50 * transformController.value ,
          -100 * transformController.value + 100
      ); break ;
      case 2: offset = Offset(
          -40 * transformController.value,
          200 * transformController.value - 100
      );  break ;
      case 3: offset = Offset(
          50 * transformController.value,
          -100 * transformController.value
      ); break ;
      case 4 : offset = Offset (
          40 * transformController.value,
          200 * transformController.value - 100
      ); break ;
    }

    if(transformController.value >= 0.99 ){
      transformController.reset();
    }

    return offset;
  }
  @override
  void dispose() {
    transformController.dispose();
    opacityController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    // final imgUrl  = Provider.of<SongsProvider>(context ).imgUrl;
    final size = MediaQuery.of(context).size;


    // print(imgUrl);


    return ClipRect(
      child: Transform.scale(
        scale: 1.7,
        child: AnimatedBuilder(
          animation: transformController,
          builder: (context , child ) => Transform.translate(
              offset: movingLogicTheEight(),
              child: FadeTransition(
                opacity: opacityController,

                child: BuildImage(
                    imgUrl: widget.imgUrl,
                    scale: widget.scale,
                    height: size.height/4 ,
                    width: size.width,

                    // fit: BoxFit.fill,
                ),
              ),
          ),
        ),
      ),
    );
  }
}
