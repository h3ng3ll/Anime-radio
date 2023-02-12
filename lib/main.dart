
import 'package:anime_radio/l10n/l10n.dart';
import 'package:anime_radio/src/models/AutoSettings.dart';
import 'package:anime_radio/src/pages/HomePage.dart';
import 'package:anime_radio/src/providers/LocaleProvider.dart';
import 'package:anime_radio/src/providers/ThemeProvider.dart';
import 'package:anime_radio/src/services/ColorService.dart';

import 'package:anime_radio/src/services/LocalStorageService.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'package:provider/provider.dart';



void main() async {

    WidgetsFlutterBinding.ensureInitialized();
    /// run app only vertical
    await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp ,
        DeviceOrientation.portraitDown
    ]);


   return runApp( ChangeNotifierProvider(
       create: (_) => ThemeProvider(),        /// theme
       child: ChangeNotifierProvider(
           create: (_) => LocaleProvider(),   /// locale
           child: const MyApp()))
   );
} 


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  /// InheritedWidget style accessor to our State object.
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
            home: const HomePage() ,//HomePage(),
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
