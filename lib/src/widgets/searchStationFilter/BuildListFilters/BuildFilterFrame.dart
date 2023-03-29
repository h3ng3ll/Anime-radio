
import 'package:flutter/material.dart';

class BuildFilterFrame extends StatelessWidget {
  const BuildFilterFrame({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.iconColor, required this.buttonBackground
  }) : super(key: key);

  final Widget child;
  final Function () onPressed;


  final Color iconColor ;
  final Color buttonBackground;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration:  BoxDecoration(
            color: buttonBackground,
            borderRadius: BorderRadius.circular(25)
        ),
        child:  Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
            SizedBox(
                height: 17.5,
                width: 17.5,
                child: IconButton(
                  padding: const  EdgeInsets.all(0.0),
                  icon:  Icon(Icons.clear, size: 17.5 , color:  iconColor,),
                  onPressed: onPressed,
                )
            )
          ],
        ),
      ),
    );
  }
}
