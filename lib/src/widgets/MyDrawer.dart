
import 'package:anime_radio/src/pages/ListPlayedSongs.dart';
import 'package:anime_radio/src/pages/SettingsPage.dart';
import 'package:anime_radio/src/providers/LocaleProvider.dart';


import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  final void Function () update;
  const MyDrawer({Key? key, required this.update}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>{

  @override
  Widget build(BuildContext context) {

    Widget title (String text)=> Center(
      child: Text(text , style:   const TextStyle(
          fontSize: 24 ,
          fontWeight: FontWeight.bold
      )),
    );

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: ListView(
        children: [
          /// title
           SizedBox(height: size.height*0.02,),
          title("Animeradio.su"),
          SizedBox(height: size.height*0.05,),

          title(AppLocalizations.of(context)!.app_sources),
          Center(child: Text(AppLocalizations.of(context)!.unofficial_app.toUpperCase())),
          SizedBox(height: size.height*0.02,),
          /// created by
          ListTile(
            title: Column(
              children: [
                Text(AppLocalizations.of(context)!.created_by , style:  const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) , textAlign: TextAlign.center),
                const Text(
                    "Hengell" ,
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
          /// where broadcast
          ListTile(
            title: Column(
              children: [
                Text(
                    AppLocalizations.of(context)!.radio_broadcasting ,
                    style:  const TextStyle(
                        fontSize: 18 ,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center
                ),
                const Text("http://animeradio.su:8000" , style:TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: ColorService.grey)  , textAlign: TextAlign.center),
              ],
            ),
            leading: const Icon(Icons.audiotrack),
          ),
          SizedBox(height: size.height*0.03,),
          /// navigation
          title(AppLocalizations.of(context)!.navigation),
          SizedBox(height: size.height*0.03),

          /// savedSongs
           ListTile(
            title:  ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ListPlayedSongs())),
                child: Text(
                    AppLocalizations.of(context)!.show_all_played_songs  ,
                    textAlign: TextAlign.center)
            ), leading: const  Icon(Icons.queue_music),
          ),

          /// settings
          ListTile(
            title: ElevatedButton(
              child: Text(AppLocalizations.of(context)!.go_to_settings),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SettingsPage(update: widget.update,);
                }))
            ),
            leading: const  Icon(Icons.settings),
          ),
          SizedBox(height: size.height*0.03),
          /// feedback
          title(AppLocalizations.of(context)!.feedBack),
          Center(child: Text(AppLocalizations.of(context)!.send_bugs_and_errors)),
          SizedBox(height: size.height*0.02,),
          const ListTile(
            title: Text("@hengell" , style:   TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) ),
            leading:  Icon(Icons.telegram),
          ),
          const ListTile(
            title: Text("h3ng3ll@gmail.com" , style:   TextStyle(fontSize: 18 , fontWeight: FontWeight.bold) ),
            leading:  Icon(Icons.mail),
          ),
        ],

      ),
    );
  }
}
