import 'package:anime_radio/main.dart';
import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/services/LocalStorageService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  static final  darkTheme =  ThemeData(

    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: ColorService.lilac,
        brightness: Brightness.dark
    ),
    progressIndicatorTheme: const  ProgressIndicatorThemeData(
      // circularTrackColor: ColorService.lilac,
      linearMinHeight: 20.0,
      color: ColorService.lilac
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark
      ),
      color: ColorService.lilac
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(ColorService.grey),
      thumbColor: MaterialStateProperty.all<Color>(ColorService.lilac),
    ),
    sliderTheme:  SliderThemeData(

      activeTrackColor: ColorService.white,
      inactiveTrackColor:  ColorService.grey,
      thumbColor:    ColorService.lilac,
      overlayColor:  ColorService.white.withOpacity(0.3),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:  MaterialStateProperty.all<Color>( ColorService.lilac)
        )
    ),
    brightness: Brightness.dark,
    canvasColor: ColorService.darkGrey ,
    textTheme: const TextTheme(
        bodyMedium: TextStyle(color: ColorService.white) /// text color
    ),
    // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorService.lilac),

  );
  static final lightTheme = ThemeData(
      progressIndicatorTheme: const  ProgressIndicatorThemeData(
        // circularTrackColor: ColorService.lilac,
        //   linearMinHeight: 20.0,

          color: ColorService.violet
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ColorService.violet,
          brightness: Brightness.light
      ),
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light
          ),
        color: ColorService.violet
      ),
      sliderTheme:   SliderThemeData(
         activeTrackColor:  ColorService.violet,
         inactiveTrackColor: ColorService.lilac,
         thumbColor: ColorService.white,
         overlayColor: ColorService.violet.withOpacity(0.3),
         thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14)
      ),
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all<Color>(ColorService.grey),
        thumbColor: MaterialStateProperty.all<Color>(ColorService.violet),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(ColorService.violet)
        )
      ),
      brightness: Brightness.light
  );

  late ThemeData _themeData ;
  ThemeData get themeData => _themeData;

  /// show what theme is using now
  ThemeMode  _currentTheme = ThemeMode.system ;
  ThemeMode get  currentTheme => _currentTheme;

  ThemeProvider()   {
    LocalStorageService.getTheme().then((themeMode) {
      _currentTheme = themeMode;
      switch (themeMode) {
          case ThemeMode.light: _themeData = lightTheme;
                        break;
          case ThemeMode.dark:  _themeData = darkTheme;
                        break;
        }
      notifyListeners();
    });

  }

  Future setDarkMode (BuildContext context) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString("themeMode", "dark");
    _currentTheme = ThemeMode.dark;
    MyApp.of(context).reload();
    notifyListeners();
  }

  Future setLightMode (BuildContext context) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString("themeMode", "light");
    _currentTheme = ThemeMode.light;
    MyApp.of(context).reload();
    notifyListeners();
  }
}