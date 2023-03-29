


import 'package:anime_radio/src/models/Settings.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  
  Settings settings = Settings();
  
  SettingsProvider() {
    LocalStorageService.getSettings()
        .then((settings) {
            if(this.settings != settings ) {
              this.settings = settings;
              update();
            }
        });
  }
  
  void update() => notifyListeners();
  
  Future<void> saveSettings () async {
    await  LocalStorageService.saveSettings(settings);
    update();
  }


  Future<Settings> resetSettings () async {
    settings.resetSettings();
    await LocalStorageService.saveSettings(settings);
    await LocalStorageService.saveScaleImagePosition(20);

    return settings;
  }
}