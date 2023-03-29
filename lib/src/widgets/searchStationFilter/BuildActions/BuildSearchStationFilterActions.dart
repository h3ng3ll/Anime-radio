

import 'package:anime_radio/src/providers/FilterStationProvider.dart';
import 'package:anime_radio/src/widgets/searchStationFilter/BuildActions/BuildButtonContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BuildSearchStationFilterActions extends StatelessWidget {

  final Color? titleColor ;
  final Color buttonBackground;
  const BuildSearchStationFilterActions({
    Key? key,
    this.titleColor,
    required this.buttonBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final  provider = Provider.of<FilterStationProvider>(context);

    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        /// Apply button
        BuildButtonContent(
            titleColor: titleColor,
            onPressed: () => Navigator.of(context).pop(
              provider.isActiveFilter
            ),
            icon: Icons.check,
            title: AppLocalizations.of(context)!.apply,
          buttonBackground: buttonBackground,
        ),
        /// Clear Filter
        BuildButtonContent(
            buttonBackground: buttonBackground,
            titleColor: titleColor,
            onPressed: () {
             provider.resetFilter();

            },
            icon: provider.isActiveFilter ?
                  Icons.filter_alt_outlined :
                  Icons.filter_alt,
            title: AppLocalizations.of(context)!.clear
        ),
        /// just Exit
        BuildButtonContent(
            buttonBackground: buttonBackground,
            titleColor: titleColor,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icons.close,
            title: AppLocalizations.of(context)!.exit
        )
      ],
    );
  }
}
