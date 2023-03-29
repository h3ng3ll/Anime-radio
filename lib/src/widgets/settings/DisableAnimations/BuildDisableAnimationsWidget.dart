

import 'package:anime_radio/src/models/Settings.dart';
import 'package:anime_radio/src/providers/SettingsProvider.dart';
import 'package:anime_radio/src/widgets/settings/BuildSwitchSettingItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BuildDisableAnimationsWidgets extends StatefulWidget {

  const BuildDisableAnimationsWidgets({Key? key}) : super(key: key);

  @override
  State<BuildDisableAnimationsWidgets> createState() => _BuildDisableAnimationsWidgetsState();
}

class _BuildDisableAnimationsWidgetsState extends State<BuildDisableAnimationsWidgets> {

  late Settings settings ;

  final paddingWidth = 40.0 ;

  Widget disableAnimation (BuildContext context )  => BuildSwitchSettingItem(
      AppLocalizations.of(context)!.disable_all_animations,
      icon:  Icons.animation,
      switchValue: settings.disableAllAnimations,
      callBack: (bool switchStatus) {
        settings.disableAllAnimations = switchStatus;
        setState(() { });
      }
  );

  Widget disableImageAnimation (BuildContext context ) => BuildSwitchSettingItem.customIcon(
      AppLocalizations.of(context)!.disable_image_animation,
      iconWidget:  SizedBox(width: paddingWidth,),
      switchValue: settings.disableImageAnimations,
      callBack: (bool switchStatus) => settings.disableImageAnimations = switchStatus,
      switchDisabled: settings.disableAllAnimations,
  );

  Widget disableLoadingStationAnimation (BuildContext context ) => BuildSwitchSettingItem.customIcon(
    AppLocalizations.of(context)!.disable_loading_station_animations,
    iconWidget:  SizedBox(width: paddingWidth,),
    switchValue: settings.disableLoadingStationAnimations,
    callBack: (bool switchStatus) => settings.disableLoadingStationAnimations = switchStatus,
    switchDisabled: settings.disableAllAnimations,
  );

  @override
  Widget build(BuildContext context) {

    settings = Provider.of<SettingsProvider>(context ).settings;

    return Column(
      children: [

        /// Global Turn off Animation

        disableAnimation(context ),

        /// image animation

        disableImageAnimation(context ),

        /// station loading animation

        disableLoadingStationAnimation(context)
      ],
    );
  }
}
