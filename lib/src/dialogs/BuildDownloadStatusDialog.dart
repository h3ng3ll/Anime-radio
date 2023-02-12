
import 'package:anime_radio/src/models/SaveStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildDownloadStatusDialog extends StatelessWidget {

  final SaveStatus status ;

  const BuildDownloadStatusDialog({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(status.isSaved){
      return  Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.image_successfully_has_been_saved_to,
              style: const TextStyle(fontSize: 18) ,
              textAlign: TextAlign.center,
            ),
            Text(
              status.path,
              style: const TextStyle(fontSize: 24) ,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)!.okay)
            ),
          ],
        ),
      );
    }
    else {
      return Dialog(
        child:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                status.error!,
                style: const TextStyle(fontSize: 18) ,
                textAlign: TextAlign.center,
              ),
              Text(
                status.path,
                style: const TextStyle(fontSize: 18) ,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.exit)
              ),
            ],
          ),
        ),
      );
    }
  }
}
