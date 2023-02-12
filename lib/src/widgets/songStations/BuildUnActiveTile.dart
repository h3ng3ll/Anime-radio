
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildUnActiveTile extends StatelessWidget {

  const BuildUnActiveTile({Key? key, required this.loading}) : super(key: key);

  final bool loading ;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    if(loading){
      return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: theme == ThemeMode.dark ? ColorService.dGrey :    const Color(0xFFF4F4F4)  ,
              borderRadius:  BorderRadius.circular(17.5),
            ),
            child: Row(
              children: [
                SizedBox(width: size.width/20,),
                Container(
                  height: 50,
                  width:  size.width/4,
                  decoration: BoxDecoration(
                    color:   theme == ThemeMode.dark ? ColorService.grey : const Color(0xFFEBEBF4) ,
                    borderRadius: BorderRadius.circular(17.5),
                    // border: Border.all(color: ColorService.black , width: 1 )
                  ),
                ),
                SizedBox(width: size.width/7,),
                Container(
                  height: 20,
                  width: size.width/3,
                  decoration: BoxDecoration(
                    color: theme == ThemeMode.dark ? ColorService.grey : const Color(0xFFEBEBF4) ,
                    borderRadius: BorderRadius.circular(17.5),
                    // border: Border.all(color: ColorService.black , width: 1 )
                  ),
                ),
                const Spacer(),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: theme == ThemeMode.dark ? ColorService.grey : const Color(0xFFEBEBF4) ,
                    borderRadius: BorderRadius.circular(12.5),
                    // border: Border.all(color: ColorService.black , width: 1 )
                  ),
                ),
                SizedBox(width: size.width/20,),

              ],
            ),
          )
      );
    }

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color:  ColorService.red ,
            borderRadius: BorderRadius.circular(17.5),
        ),
        padding: const  EdgeInsets.symmetric(vertical: 5 , horizontal: 5),
        child: loading ? null :  Center(
          child: Text(
            "${AppLocalizations.of(context)!.failed_to_load_station} !",
            style: const TextStyle(
                color:  ColorService.white,
                fontSize: 24
            ),
          ),
        ),
      ),
    );
  }
}

