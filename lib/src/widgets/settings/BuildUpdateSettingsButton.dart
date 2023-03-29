import 'dart:async';

import 'package:anime_radio/src/providers/SettingsProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildUpdateSettingsButton extends StatefulWidget {
  final void Function () updateParent;

  const BuildUpdateSettingsButton({
    Key? key,
    required this.updateParent,
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
    // await widget.updateSettings();
    // widget.updateParent();
    
    /// save settings  via Provider 
    // ignore: use_build_context_synchronously
    Provider.of<SettingsProvider>(context , listen: false).saveSettings();
    /// run timer 5 sec after allow press again
    timerCycle();

  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: canUpdate ? updateSettings : null,
        icon: Icon(
          Icons.save , color: canUpdate ?  null : ColorService.grey
        ),
    );
  }
}