import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';

class BuildNeumorphismButton extends StatelessWidget {

  const BuildNeumorphismButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.buttonBackground
  }) : super(key: key);

  final Widget child;
  final  Function () onPressed;
  final Color buttonBackground;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding:  const EdgeInsets.all(15),
        decoration:  BoxDecoration (
            borderRadius: BorderRadius.circular(17.5),
            color: buttonBackground,
            boxShadow: const [
              BoxShadow(
                  color: ColorService.violet,
                  offset: Offset(3, 3),
                  blurRadius: 15,
                  spreadRadius: 1
              ),
              BoxShadow(
                  color: ColorService.black,
                  offset: Offset(-3, -3),
                  blurRadius: 15,
                  spreadRadius: 1
              )

            ]
        ),
        child: child,
      ),
    );
  }
}
