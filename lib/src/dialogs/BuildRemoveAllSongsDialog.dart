
import 'package:anime_radio/src/providers/playerViewPage/PlayedSongsProvider.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BuildRemoveAllSongsDialog extends StatelessWidget {
  const BuildRemoveAllSongsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.remove_songs_alert ,
            style: const TextStyle(fontSize: 18) ,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(AppLocalizations.of(context)!.no)
              ),
              ElevatedButton(
                onPressed: () {
                  LocalStorageService.resetSongsListWithFilter();
                  Provider.of<PlayedSongsProvider>(context , listen:  false).clearSongs; 
                  Navigator.of(context).pop("yes");
                },
                child: Text(AppLocalizations.of(context)!.yes)
              ),
            ],
          )
        ],
      ),
    );
  }
}
