import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({Key? key}) : super(key: key);

  final double appVersion = 1.1;

  Widget title (String text)=> Text(
      text , style:   const TextStyle(
      fontSize: 24 ,
      fontWeight: FontWeight.bold
  ));

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar:  AppBar(),
      body: Column(
        children: [
          // title("Animeradio.su"),
          SizedBox(height: size.height*0.05,),

          title(AppLocalizations.of(context)!.about_app),
          // Center(child: Text(AppLocalizations.of(context)!.unofficial_app.toUpperCase())),
          SizedBox(height: size.height*0.05,),
          /// created by
          ListTile(
            title: Column(
              children: [
                Text(AppLocalizations.of(context)!.created_by , style:  const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) , textAlign: TextAlign.center),
                const Text(
                    'Hengell' ,
                    style:   TextStyle(
                        fontSize: 18 ,
                        fontWeight: FontWeight.bold ,
                        color: ColorService.red
                    )
                ),
              ],
            ),
            leading: const Icon(Icons.person),
          ),
          /// images taken from
          ListTile(
            title: Column(
              children: [
                Text(AppLocalizations.of(context)!.img_taken_from , style:  const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) , textAlign: TextAlign.center,),
                const Text("pinterest.com" , style:TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: ColorService.grey)),
              ],
            ),
            leading: const Icon(Icons.image),
          ),
          /// github
          ListTile(
            title: const Column(
              children: [
                Text("GitHub", style:   TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) , textAlign: TextAlign.center,),
                 Text("github.com/h3ng3ll/Anime-radio" , style:TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: ColorService.grey)),
              ],
            ),
            leading: Container(
                width: 30,
                decoration: const BoxDecoration(
                  image:  DecorationImage(image: AssetImage("assets/icons/github.png" )),
                  shape: BoxShape.circle,
                  color:   ColorService.white,
                ),
            ),
          ),
          /// Version
          ListTile(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.version, style:   const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) , textAlign: TextAlign.center,),
                Text(appVersion.toString() , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: ColorService.grey)),
              ],
            ),
            leading: const Icon(Icons.api),
          ),
        ],
      ),
    );
  }
}
