
import 'package:anime_radio/src/models/MusicGenre.dart';
import 'package:anime_radio/src/providers/FilterStationProvider.dart';
import 'package:anime_radio/src/widgets/searchStationFilter/BuildChoicerFilter/BuildChoicerFilterItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildChoicerFilterList extends StatelessWidget {

  final Color textColor;
  final Color dropDownBackground;
  final Color underline;
  final Color iconDropDownEnabled;

  const BuildChoicerFilterList({
    Key? key,
    required this.textColor,
    required this.dropDownBackground,
    required this.underline,
    required this.iconDropDownEnabled
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<FilterStationProvider>(context , listen:  false);



    return Column(
        children: [
          // BuildChoicerGenreFilter(setState: setState, titleColor: titleColor,),
          // BuildChoicerCountryFilter(setState: setState, titleColor: titleColor,),
          /// Genre
          BuildChoicerFilterItem(
              textColor: textColor,
              addFunction: () {
                provider.filter.addGenre(provider.genre);
                provider.update();
              },
              items: MusicGenre.values,
              title: "${AppLocalizations.of(context)!.by_genre}\t\t",
              onChangeItem: (dynamic newGenre) {
                provider.genre = newGenre;
              },
              initialValue: provider.genre,
            dropDownBackground: dropDownBackground,
            underline: underline,
            iconDropDownEnabled: iconDropDownEnabled,
          ),
          /// Location
          BuildChoicerFilterItem(
            dropDownBackground: dropDownBackground,
            textColor: textColor,
            addFunction: () {
              provider.filter.addCounty(provider.countryIndex);
              provider.update();
            },
            items: provider.countriesList(context),
            title: "${AppLocalizations.of(context)!.location}\t\t" ,
            onChangeItem: (dynamic safs) {
              provider.countryIndex =
                  provider.countriesList(context).indexOf(safs);

            }, initialValue: provider.countriesList(context)[provider.countryIndex],
            underline: underline,
            iconDropDownEnabled: iconDropDownEnabled,
          )
        ]
    );
  }
}
