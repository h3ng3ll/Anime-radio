import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BuildPlayingTitle extends StatelessWidget {
  const BuildPlayingTitle({Key? key}) : super(key: key);

  Widget myText (String text ) => Expanded(
      child: Text(
        text ,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18)
      )
  );

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Row(
      children: [
        myText(l.song),
        myText(l.compositor),
        myText(l.when_played),
        myText(l.station),
      ],
    );
  }
}
