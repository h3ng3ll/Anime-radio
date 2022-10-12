
import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/src/providers/LocaleProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:anime_radio/src/widgets/settings/BuildUpdateSettingsButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:anime_radio/src/models/Settings.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  /// a bit crap code
  final void Function () update;
  const SettingsPage({Key? key, required this.update}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Settings settings = Settings(false, false, false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalStorageService.getSettings().then(
            (value) => setState(() =>  settings = value)
    );
  }

 
      
  
  Widget _buildItem ({required Widget title, required  IconData icon}) => ListTile(
    leading: Icon(icon),
    title: title,
  );



  Widget title (String title) => Align(
    alignment: Alignment.center,
    child: Text(
       title,
      style: const TextStyle(fontSize: 32),
      textAlign: TextAlign.center,
    ),
  );

  Widget changeTheme () {
    final  themeProvider = Provider.of<ThemeProvider>(context , listen:  false);

    bool lightTheme = themeProvider.currentTheme == ThemeMode.light;

    return _buildItem(
      icon: Icons.remove_red_eye,
      title: Row(
        children: [
          Text(
              lightTheme ?
              AppLocalizations.of(context)!.light_theme :
              AppLocalizations.of(context)!.dark_theme
          ),
          Switch(
              value: !lightTheme,
              onChanged: (lightTheme) async {
                lightTheme ?  await themeProvider.setDarkMode(context) :
                await themeProvider.setLightMode(context) ;
                setState(() {});
              }),
        ],
      ),
    );
  }

  Widget showOrNotImage() => _buildItem(
    title: Row(
      children: [
        Text(AppLocalizations.of(context)!.remove_image_while_playing , textAlign: TextAlign.center,),
        Switch(
            value: settings.removeImage,
            onChanged: (value) => setState(() => settings.removeImage = value)
        ),
      ],
    ),
    icon: Icons.image,
  );

  Widget showPlayedMusicOrNot () => _buildItem(
    title: Row(
      children: [
        Text(AppLocalizations.of(context)!.do_not_show_last_song_table , textAlign: TextAlign.center,),
        Switch(
            value: settings.removeListLastSongs,
            onChanged: (value) =>
              setState(() {
                settings.removeListLastSongs = value;
              })
        ),
      ],
    ),
    icon: Icons.table_rows_rounded,
  );

  Widget showSoundSliderOrNot () => _buildItem(
    title: Row(
      children: [
        Text(AppLocalizations.of(context)!.remove_slider),
        Switch(
            value: settings.removeSoundSlider,
            onChanged: (value) {
              setState(() {
                settings.removeSoundSlider = value;
              });
            }
        ),
      ],
    ),
    icon: Icons.music_off_rounded,
  );

  Widget changeLocale () => Row(
    children:[
      SizedBox(width: MediaQuery.of(context).size.width*0.035,),
      const Icon(Icons.language),
      SizedBox(width: MediaQuery.of(context).size.width*0.08,),
      DropdownButton(
          value:  L10n.nameLanguages[L10n.nameLanguages.indexOf(AppLocalizations.of(context)!.language)],
          items:  L10n.nameLanguages.map((country) => DropdownMenuItem(
              value: country,
              child: Text( country))

          ).toList() ,
          onChanged: (country) {
            if(country == null ) return ;
            final index = L10n.nameLanguages.indexOf(country);
            /// save to local storage
            LocalStorageService.saveLocale(L10n.all[index]);
            /// update primary widget
            Provider.of<LocaleProvider>(context , listen:  false)
                .setLocale(L10n.all[index], context);
          }
    ),

   ]
  );

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(actions: [ BuildUpdateSettingsButton(
          updateParent: widget.update,
          updateSettings: () async => await LocalStorageService.saveSettings(settings),
      )],),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
      children: [
        title(AppLocalizations.of(context)!.settings),
          /// switch images
        showOrNotImage(),
          /// switch last music
        showPlayedMusicOrNot(),
          /// switch sound slider
        showSoundSliderOrNot(),
        title(AppLocalizations.of(context)!.auto_settings),
          /// dark or light theme
        changeTheme(),

        changeLocale()
      ],
    ),
    );
  }
}



