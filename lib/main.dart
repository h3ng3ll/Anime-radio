
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/src/models/AutoSettings.dart';
import 'package:anime_radio/src/pages/HomePage/HomePage.dart';
import 'package:anime_radio/src/providers/AdMobProvider.dart';
import 'package:anime_radio/src/providers/FilterStationProvider.dart';
import 'package:anime_radio/src/providers/LocaleProvider.dart';
import 'package:anime_radio/src/providers/SettingsProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';

import 'package:anime_radio/src/services/LocalStorageService.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'package:provider/provider.dart';

import 'src/providers/playerViewPage/PlayerDesignProvider.dart';
import 'src/providers/playerViewPage/SongsProvider.dart';



void main() async {

    WidgetsFlutterBinding.ensureInitialized();

    /// initialize google ads

    Admob.initialize();

    /// add certificate in order to load images on old android devices .
    ByteData data = await PlatformAssetBundle().load("assets/ca/imgCertificate.pem");
    SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

    /// run app only vertical
    await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp ,
        DeviceOrientation.portraitDown
    ]);


   return runApp(
       MultiProvider(
         providers: [
           /// theme
            ChangeNotifierProvider(
              create: (_) => ThemeProvider(),
            ),

            /// locale
            ChangeNotifierProvider(
             create: (_) => LocaleProvider(),
            ),

           /// filter station
            ChangeNotifierProvider(
               create: (_) => FilterStationProvider(),
             ),

              /// Responds for  shaping image forms
             ChangeNotifierProvider<PlayerDesignProvider>(
               create: (BuildContext context) => PlayerDesignProvider(),
             ),

             /// Provide songs to user
             ChangeNotifierProvider<SongsProvider>(
               create: (BuildContext context) => SongsProvider( context),
             ),
             /// watch situation when ad will appeared .
             ChangeNotifierProvider<AdMobProvider>(
               create: (BuildContext  context) => AdMobProvider(),
             ),
              /// global settings
             ChangeNotifierProvider(
              create: (BuildContext context) => SettingsProvider(),
             )
         ],
         child: const RootRestorationScope(
             restorationId: "root",
             child:  MyApp()
         )
       )
   );
} 


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  /// InheritedWidget style accessor to our State object.

  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {



   AutoSettings settings = AutoSettings(ThemeMode.system, L10n.all.first);

  Future<AutoSettings> initializeSettings () async {

    final  locale = await LocalStorageService.getLocale();
    final  mode = await LocalStorageService.getTheme();

    return AutoSettings(mode, locale);
  }


  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<AutoSettings>(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          settings.mode = snapshot.data!.mode;
          settings.locale =  snapshot.data!.locale;

          return MaterialApp(
            // debugShowCheckedModeBanner: false,
            // showPerformanceOverlay: true,
            darkTheme: ThemeProvider.darkTheme,
            theme: ThemeProvider.lightTheme,
            themeMode: settings.mode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: settings.locale,
            supportedLocales: L10n.all,
             home: const HomePage() ,
          );
        }
        else {
          return const MaterialApp();
        }
      }
    );
  }

  void reload() => setState(() {  });
  void updateLocale (Locale? locale) => setState(() => settings.locale = locale);
}
