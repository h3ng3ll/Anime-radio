import 'package:flutter/material.dart';

class BuildSoundSlider extends StatefulWidget {

  final Future<void> Function (double) updateSlider;
  const BuildSoundSlider({Key? key, required this.updateSlider}) : super(key: key);

  @override
  State<BuildSoundSlider> createState() => _BuildSoundSliderState();
}

class _BuildSoundSliderState extends State<BuildSoundSlider> {

  double volume = 0.8;
  bool move = false ;

  @override
  Widget build(BuildContext context) {

    return   Column(
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Slider(
              onChangeStart: (_) => setState(() => move = true ),
              onChangeEnd: (_)  =>  Future.delayed(const Duration(seconds: 3))
                  .then((_) => setState(() => move = false )),
              value: volume,
              onChanged: (newVolume) {
                setState(() {
                  volume = newVolume;
                  widget.updateSlider(volume);
                });
              }
          ),
        ),
        AnimatedOpacity(
            opacity: move ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: Text("${(volume*100).round()}")
        )
      ],
    );
  }
}
