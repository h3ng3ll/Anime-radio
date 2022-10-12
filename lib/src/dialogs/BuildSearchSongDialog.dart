import 'package:anime_radio/src/models/Song.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:url_launcher/url_launcher.dart';

class BuildSearchSongDialog extends StatelessWidget {

  final SavedSong song;

  const BuildSearchSongDialog({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.find_song , style: const TextStyle(fontSize: 24) , textAlign: TextAlign.center,),
          Text("${song.name} - ${song.compositor}" , textAlign: TextAlign.center,),
          ElevatedButton(
              onPressed: () async {
                final url = Uri.parse("https://www.google.com/search?q=${song.compositor} ${song.name}");
                launchUrl(url);
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.find)
          )
        ],
      ),
    );
  }
}
