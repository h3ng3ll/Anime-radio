


import 'package:anime_radio/src/databases/DatabaseImages/DatabaseImages.dart';
import 'package:anime_radio/src/models/Settings.dart';
import 'package:anime_radio/src/providers/SettingsProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/widgets/settings/BuildSwitchSettingItem.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BuildImageConfigurations extends StatefulWidget {
  final double leftPadding;
  const BuildImageConfigurations({
    Key? key,
    required this.leftPadding
  }) : super(key: key);

  @override
  State<BuildImageConfigurations> createState() => _BuildImageConfigurationsState();
}

class _BuildImageConfigurationsState extends State<BuildImageConfigurations> {

  late Settings settings;

  Widget showSelectedImageGenres () {

    void onChipSelected(bool selected , DatabaseImagesGenres value) {

      /// try disable $selected genre
      if(!selected){
        final oldSnippet = List.generate(settings.selectedImageGenres!.length, (index) => false);

        oldSnippet[value.index] = true;

        /// compare lists to avoid any empty genre filters
        /// if user want to remove any of this genres
        /// It should turn off the option 'Show image during playing' as disabled.
        if(listEquals(settings.selectedImageGenres , oldSnippet)){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text( AppLocalizations.of(context)!.here_is_must_be_even_one_selected_item)
              )
          );
          return ;
        }

      }
      settings.selectedImageGenres![value.index] = selected;
      setState(() {   });
    }

    final hided = !settings.showImageDuringPlaying;

    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                AppLocalizations.of(context)!.show_genres_of_image ,
                style: TextStyle(
                    color: hided ? ColorService.grey : null
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: widget.leftPadding),
                child: Column(
                  children: [
                    Wrap(
                      children: DatabaseImagesGenres.values.map((value) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:5),
                          child: ChoiceChip(
                            labelStyle: TextStyle(
                              color: hided ? ColorService.grey : null
                            ),
                            disabledColor: hided ? ColorService.grey8 : null,
                            selectedColor:  hided ? ColorService.grey8 : null,
                            label: Text(value.name),
                            selected: settings.selectedImageGenres![value.index],
                            onSelected: (selected) => hided ? null : onChipSelected(selected , value) ,
                          ),
                        );
                      } ).toList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),

    );
  }

  Widget showImageDuringPlaying() => BuildSwitchSettingItem(
      AppLocalizations.of(context)!.show_image_during_playing ,
      icon: Icons.image,
      switchValue: settings.showImageDuringPlaying,
      callBack: (bool switchStatus) {
        setState(() => settings.showImageDuringPlaying = switchStatus );
      }
  );

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<SettingsProvider>(context , listen:  false) ;
    settings = provider.settings;

    return Column(
      children: [

        /// show images
        showImageDuringPlaying(),

        /// choice genre images.
        showSelectedImageGenres() ,
      ],
    );
  }
}
