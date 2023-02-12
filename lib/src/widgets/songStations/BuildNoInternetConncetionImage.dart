

import 'package:anime_radio/src/services/ColorService.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BuildNoInternetConnectionImage extends StatelessWidget {
  const BuildNoInternetConnectionImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/noInternetConnection.jpeg",
            )
        )
      ),
      child: Column(
        children: [
          const Spacer(),
          Text(
            AppLocalizations.of(context)!.no_internet_connection,
            style: const TextStyle(
                fontSize: 40,
                color: ColorService.white
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
