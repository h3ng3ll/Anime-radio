import 'package:anime_radio/src/widgets/searchStationFilter/BuildActions/BuildNeumorphismButton.dart';
import 'package:flutter/material.dart';

class BuildButtonContent extends StatelessWidget {
  const BuildButtonContent({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.title,
    this.titleColor,
    required this.buttonBackground
  }) : super(key: key);

  final void Function () onPressed;
  final IconData icon ;
  final String title  ;

  final Color? titleColor ;
  final Color buttonBackground;



  @override
  Widget build(BuildContext context) {

    const  size = 20.0 ;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: BuildNeumorphismButton(
        onPressed: onPressed,
        buttonBackground: buttonBackground,
        child: Row(
          children: [
            SizedBox(
                width: size,
                height: size,
                child: Icon(icon , size: size, color: titleColor,)
            ),
            Text(title , style:  TextStyle(color:  titleColor),)
          ],
        ),
      ),
    );
  }
}
