
import 'package:admob_flutter/admob_flutter.dart';
import 'package:anime_radio/src/pages/AppInfoPage.dart';
import 'package:anime_radio/src/pages/ListPlayedSongsPage.dart';
import 'package:anime_radio/src/pages/SettingsPage.dart';
import 'package:anime_radio/src/providers/SettingsProvider.dart';
import 'package:anime_radio/src/providers/playerViewPage/PlayedSongsProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/AdMobService.dart';
import 'package:anime_radio/src/services/ColorService.dart';


import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';


class MyDrawer extends StatelessWidget {

  final void Function () update;

   MyDrawer({Key? key, required this.update}) : super(key: key);

  final AdmobBannerSize bannerSize  = AdmobBannerSize.BANNER;

  final interestialAd = AdMobService.instance.interstitialAdBanner;

  @override
  Widget build(BuildContext context) {

    final settingsProvider =  Provider.of<SettingsProvider>(context , listen:  false) ;
    final theme = Provider.of<ThemeProvider>(context , listen:  false).currentTheme;

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [

          SizedBox(height: size.height*0.05),

          /// navigation
          title(AppLocalizations.of(context)!.navigation),
          SizedBox(height: size.height*0.03),

          /// savedSongs
           ListTile(
            title:  ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  //const ListPlayedSongs()
                        Provider<PlayedSongsProvider>(
                        create: (BuildContext context) => PlayedSongsProvider(),
                        child: const ListPlayedSongs())
                    )
                ),
                child: Text(
                    AppLocalizations.of(context)!.show_all_played_songs  ,
                    style:  TextStyle(color: theme == ThemeMode.dark ? null : ColorService.white),
                    textAlign: TextAlign.center
                )
            ), leading: const  Icon(Icons.queue_music),
          ),

          /// settings
          ListTile(
            title: ElevatedButton(
              child: Text(
                  AppLocalizations.of(context)!.go_to_settings,
                  // style:  TextStyle(color: theme == ThemeMode.dark ? null : ColorService.white),
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                            value: settingsProvider,
                            child: SettingsPage(update: update)
                          )))
            ),
            leading: const  Icon(Icons.settings),
          ),

          /// Metadata page
          ListTile(
            title: ElevatedButton(
                child: Text(
                    AppLocalizations.of(context)!.more_app_info,
                    // style:  TextStyle(color: theme == ThemeMode.dark ? null : ColorService.white),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const AppInfoPage();
                    }))
            ),
            leading: const  Icon(Icons.person),
          ),

          SizedBox(height: size.height*0.03),
          /// feedback
          title(AppLocalizations.of(context)!.feedBack),
          Center(child: Text(AppLocalizations.of(context)!.send_bugs_and_errors)),
          SizedBox(height: size.height*0.02,),
          const ListTile(
            //ignore_for_file:@hengell
            title: Text("@hengell" , style:   TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) ),
            leading:  Icon(Icons.telegram),
          ),
          const ListTile(
            title: Text("h3ng3ll@gmail.com" , style:   TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) ),
            leading:  Icon(Icons.mail),
          ),
           ListTile(
            title: const Text("hengell" , style:   TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) ),
            leading:  Image.asset(
              "assets/icons/vk.png"  ,
              width: 30,
              color:  theme == ThemeMode.dark ?  ColorService.white :   ColorService.grey8,
            ),
          ),

         ...adBanner()
        ],

      ),
    );
  }

  Widget title (String text)=> Center(
    child: Text(text , style:   const TextStyle(
        fontSize: 24 ,
        fontWeight: FontWeight.bold
    )),
  );

  List<Widget> adBanner () =>[
    const Spacer(),
    Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 52,
      child: AdmobBanner(
        adUnitId: AdMobService.getBannerAdUnitId()!,
        adSize: bannerSize,
      ),
    )
  ];
}
