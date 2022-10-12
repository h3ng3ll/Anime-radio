import 'package:flutter/material.dart';

class BuildPlayButton extends StatefulWidget {

  bool isPlaying ;
  final Future<void> Function () playOrPause;
  BuildPlayButton({
    Key? key,
    required this.playOrPause,
    required this.isPlaying
  }) : super(key: key);

  @override
  State<BuildPlayButton> createState() => _BuildPlayButtonState();
}

class _BuildPlayButtonState extends State<BuildPlayButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async  {
        await widget.playOrPause();
        setState(() {
          widget.isPlaying = !widget.isPlaying;
        });
      },
      style: ElevatedButton.styleFrom(shape: const CircleBorder()),
      child:  Icon(widget.isPlaying ?    Icons.pause_outlined : Icons.play_arrow )   ,
    );
  }
}
