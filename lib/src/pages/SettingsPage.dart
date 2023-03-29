
import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/src/providers/LocaleProvider.dart';
import 'package:anime_radio/src/providers/SettingsProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:anime_radio/src/widgets/settings/BuildSwitchSettingItem.dart';
import 'package:anime_radio/src/widgets/settings/DisableAnimations/BuildDisableAnimationsWidget.dart';
import 'package:anime_radio/src/widgets/settings/BuildImageConfigurations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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


  late Settings settings;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }


  Future<void> onWillPop (SettingsProvider provider) async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    await provider.saveSettings();
  }


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

    return BuildSwitchSettingItem(
        lightTheme ?
              AppLocalizations.of(context)!.light_theme :
              AppLocalizations.of(context)!.dark_theme,
        icon: Icons.remove_red_eye,
        switchValue:  !lightTheme,
        callBack: (lightTheme) async {
          lightTheme ?  await themeProvider.setDarkMode(context) :
                      await themeProvider.setLightMode(context) ;

                      // setState(() {});
                      widget.update();
        }
    );
  }




  Widget showTableWithSongs () => BuildSwitchSettingItem(
      AppLocalizations.of(context)!.show_table_with_songs ,
      icon: Icons.table_rows_rounded,
      switchValue: settings.showSongsTable,
      callBack: (bool switchStatus) => settings.showSongsTable = switchStatus
  );

  Widget showUnloadedStations () => BuildSwitchSettingItem(
      AppLocalizations.of(context)!.show_unsuccessfully_loaded_stations,
      icon: Icons.error,
      switchValue: settings.showUnloadedStations,
      callBack: (bool switchStatus) =>  settings.showUnloadedStations = switchStatus
  );

  /// Sound Slider was removed at this version
  // Widget showSoundSliderOrNot () => _buildItem(
  //   title: Row(
  //     children: [
  //       Text(AppLocalizations.of(context)!.remove_slider),
  //       Switch(
  //           value: settings.removeSoundSlider,
  //           onChanged: (value) {
  //             setState(() {
  //               settings.removeSoundSlider = value;
  //             });
  //           }
  //       ),
  //     ],
  //   ),
  //   icon: Icons.music_off_rounded,
  // );

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


  Widget resetSettingsButton (SettingsProvider provider) =>  ElevatedButton(
      onPressed: () async {

        await provider.resetSettings();
        provider.update();
        widget.update;
        setState(() {   });

      },
      child: Text(AppLocalizations.of(context)!.reset)
  );

  @override
  Widget build(BuildContext ctx) {

    final provider = Provider.of<SettingsProvider>(context , listen:  false) ;
     settings = provider.settings;

    final size = MediaQuery.of(context).size;

    /// using for   widgets are depend from their parent .
    const double leftPadding = 40.0 ;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () async{
              await onWillPop(provider);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          ),
          actions: [
            const Spacer(),
            Center(child: title(AppLocalizations.of(context)!.settings)),
            const Spacer(),
            // BuildUpdateSettingsButton(
            //   updateParent: widget.update,
            // )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                  children: [

                    /// Image configurations
                    const BuildImageConfigurations(leftPadding: leftPadding,),

                    /// show table with songs
                    showTableWithSongs(),

                    /// show unsuccessfully loaded stations
                    showUnloadedStations(),

                    /// Animations

                    const BuildDisableAnimationsWidgets(),

                    /// AUTO SETTINGS

                    // title(AppLocalizations.of(context)!.auto_settings),

                    SizedBox(height: size.height*0.05,),

                    /// dark or light theme
                    changeTheme(),

                    changeLocale(),

                  ],
                )
            ),

            resetSettingsButton(provider),
            SizedBox(height: size.height*0.015)
          ],
        ),
      ),
      onWillPop: () async {
         await onWillPop(provider);
         return true;
      },
    );
  }
}



