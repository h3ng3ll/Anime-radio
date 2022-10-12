import 'dart:async';

import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';

class BuildUpdateSettingsButton extends StatefulWidget {
  /// a bit crap code
  final void Function () updateParent;
  final Future<void> Function () updateSettings;

  const BuildUpdateSettingsButton({
    Key? key,
    required this.updateParent,
    required this.updateSettings
  }) : super(key: key);

  @override
  State<BuildUpdateSettingsButton> createState() => _BuildUpdateSettingsButtonState();
}

class _BuildUpdateSettingsButtonState extends State<BuildUpdateSettingsButton> {



  bool canUpdate = true;

  Future<void> timerCycle () async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(timer.tick == 5) {
        timer.cancel();
        if(mounted) {
          setState(() => canUpdate = true );
        }
      }
    });
  }
  updateSettings () async {
    /// show inactive button
    setState(() => canUpdate = false );
    /// save settings to LocalStorage
    await widget.updateSettings();
    widget.updateParent();
    /// run timer 5 sec after allow press again
    timerCycle();

  }
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
        onPressed: canUpdate ? updateSettings : null,
        child:  Icon(Icons.save , color: canUpdate ?  null : ColorService.grey ,)
    );
  }
}