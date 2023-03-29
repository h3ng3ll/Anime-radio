


import 'package:anime_radio/src/providers/FilterStationProvider.dart';
import 'package:anime_radio/src/widgets/searchStationFilter/BuildListFilters/BuildFilterFrame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildFilters extends StatelessWidget {

  final Color textColor;
  final Color buttonBackground;
  const BuildFilters({
    Key? key,
    required this.textColor,
    required this.buttonBackground
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<FilterStationProvider>(context );

    final filter = provider.filter;
    final countriesList = provider.countriesList(context);

    return Wrap(
      children: [
        /// Genres
        ...filter.genres.map(
                (genreBuild) {
              return BuildFilterFrame(
                  onPressed: () {
                    filter.genres.remove(genreBuild);
                    provider.update();
                  },
                  iconColor: textColor,
                  buttonBackground: buttonBackground,
                  child: Text(
                  "${AppLocalizations.of(context)!.genre}:   ${genreBuild.name} ",
                   style:  TextStyle(color: textColor),
                  )
              );
            }
        ).toList(),
        /// countries
        ...filter.countryIndexes.map(
                (index) {
              return BuildFilterFrame(
                  buttonBackground: buttonBackground,
                  onPressed: () {
                    filter.countryIndexes.remove(index);
                    provider.update();
                  },
                  iconColor: textColor,
                  child: Text(
                      "${AppLocalizations.of(context)!.location}:   ${countriesList[index]}" ,
                      style:  TextStyle(color: textColor),

              )
              );
            }
        ).toList(),

      ],
    );
  }
}

