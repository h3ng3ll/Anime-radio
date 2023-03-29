
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart' as shim;

class BuildUnActiveTile extends StatelessWidget {

  const BuildUnActiveTile({
    Key? key,
    required this.loading,
    required this.height,
    this.offAnimation = false,
  }) : super(key: key);

  final bool loading ;
  final double height;
  final bool offAnimation;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    final darkTheme = theme == ThemeMode.dark;
    final  color = darkTheme ? ColorService.grey :    const Color(0xFFF4F4F4);

    if(loading && !offAnimation){
      return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height,
            padding: const  EdgeInsets.symmetric(vertical: 5 , horizontal: 5),
            decoration: BoxDecoration(
              color:  theme == ThemeMode.dark ? ColorService.dGrey :   const Color(0xFFF4F4F4),
                borderRadius:  BorderRadius.circular(17.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 8,
                  child: shim.Shimmer.fromColors(
                    baseColor:  ColorService.grey,
                    highlightColor: darkTheme ?  ColorService.grey2 : ColorService.whiteShimmer,
                    child: Container(
                      height: height,
                      width:  size.width/4,
                      decoration: BoxDecoration(
                        color:   color ,
                        borderRadius: BorderRadius.circular(17.5),
                        // border: Border.all(color: ColorService.black , width: 1 )
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 3,),

                /// Name station
                Expanded(
                  flex: 8,
                  child: shim.Shimmer.fromColors(
                    baseColor:  ColorService.grey,
                    highlightColor: darkTheme ?  ColorService.grey2 : ColorService.whiteShimmer ,
                    child: Container(
                      height: 20,
                      width: size.width/3,
                      decoration: BoxDecoration(
                        color: color ,
                        borderRadius: BorderRadius.circular(17.5),
                        // border: Border.all(color: ColorService.black , width: 1 )
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2,),

                /// The like button
                shim.Shimmer.fromColors(
                  baseColor: darkTheme ? ColorService.lightPink : ColorService.red3,
                  highlightColor: darkTheme ?  ColorService.grey2 : ColorService.whiteShimmer ,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: ColorService.red,
                      borderRadius: BorderRadius.circular(12.5),
                      // border: Border.all(color: ColorService.black , width: 1 )
                    ),
                  ),
                ),
                // SizedBox(width: size.width/20,),
                const Spacer(),

              ],
            ),
          )
      );
    }
    else if(offAnimation) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height,
            padding: const  EdgeInsets.symmetric(vertical: 5 , horizontal: 5),
            decoration: BoxDecoration(
              color:  theme == ThemeMode.dark ? ColorService.dGrey :   const Color(0xFFF4F4F4),
              borderRadius:  BorderRadius.circular(17.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    height: height,
                    width:  size.width/4,
                    decoration: BoxDecoration(
                      color:   color ,
                      borderRadius: BorderRadius.circular(17.5),
                      // border: Border.all(color: ColorService.black , width: 1 )
                    ),
                  ),
                ),
                const Spacer(flex: 3,),

                /// Name station
                Expanded(
                  flex: 8,
                  child: Container(
                    height: 20,
                    width: size.width/3,
                    decoration: BoxDecoration(
                      color: color ,
                      borderRadius: BorderRadius.circular(17.5),
                      // border: Border.all(color: ColorService.black , width: 1 )
                    ),
                  ),
                ),
                const Spacer(flex: 2,),

                /// The like button
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: ColorService.lightPink,
                    borderRadius: BorderRadius.circular(12.5),
                    // border: Border.all(color: ColorService.black , width: 1 )
                  ),
                ),
                // SizedBox(width: size.width/20,),
                const Spacer(),

              ],
            ),
          )
      );
    }

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height,
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
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

