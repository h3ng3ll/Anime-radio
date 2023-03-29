
import 'package:anime_radio/src/widgets/searchStationFilter/BuildActions/BuildSearchStationFilterActions.dart';
import 'package:anime_radio/src/widgets/searchStationFilter/BuildChoicerFilter/BuildChoicerFilterList.dart';
import 'package:anime_radio/src/widgets/searchStationFilter/BuildListFilters/BuildListFilters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';


Widget searchStationFilterDialog ({required BuildContext context, required ThemeMode theme})   {

  final height = AppBar().preferredSize.height +   MediaQuery.paddingOf(context).top ;
  final size = MediaQuery.of(context).size;
  final bool lightTheme = theme == ThemeMode.light;

  /// define colors
  const white = ColorService.white;
  const lilac = ColorService.lilac;
  const black = ColorService.black;
  const violet = ColorService.violet;
  final  grey8 = ColorService.grey8;
  const  ddGrey = ColorService.ddGrey;

  return StatefulBuilder(
      builder: (context , setState) {
        return Stack(
          children: [
            Positioned(
                top: height,
                left: 0,
                right: 0,
                child: Material(
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.all(10),
                    decoration:    BoxDecoration(
                        color: theme == ThemeMode.light ? white : grey8,
                        border: const Border.fromBorderSide(BorderSide(color: black , width: 2.5)),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25))
                    ) ,
                    child: Column(
                      children: [
                        ///   Add
                        ///  Genres
                        ///  Country
                        ///  * most active station
                        ///  together or separate .


                        /// decoration line
                        Container(
                          decoration: const  BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: black,
                          ),
                          width: size.width,
                          height: 2,
                        ),
                        SizedBox(height: size.height*0.02,),

                        /// Sort by
                        Text("${AppLocalizations.of(context)!.sort_by.toUpperCase()}:" ,
                          style: const TextStyle(fontSize: 32 ),
                        ),
                        SizedBox(height: size.height*0.02,),

                        /// Genre - Anime +
                        /// Location - England +
                        BuildChoicerFilterList(
                          textColor: lightTheme ? black : white,
                          dropDownBackground: lightTheme ? white : ddGrey,
                          underline:  lightTheme ? black : white,
                          iconDropDownEnabled: lightTheme ? black : lilac,
                        ),

                        SizedBox(height: size.height*0.02,),

                        /// Location: England
                        BuildFilters(
                          textColor: ColorService.white,
                          buttonBackground: lightTheme ? lilac : ddGrey ,
                        ),
                        SizedBox(height: size.height*0.02,),


                        /// Apply , Reset , Exit Buttons
                        BuildSearchStationFilterActions(
                          titleColor: lightTheme  ? white : null,
                          buttonBackground: lightTheme  ? violet : lilac,
                        ),
                        SizedBox(height: size.height*0.02,),
                      ],
                    ),
                  ),
                )
            )

          ],
        );
      }
  );

}