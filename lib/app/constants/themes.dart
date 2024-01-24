import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pasuhisab/app/constants/size_cofig.dart';

class Themes {
  static Color pIMARYCOLOR = HexColor('025A4C'); //0B2545
  static Color pRIMARYCOLORLIGHT = HexColor('025A4C');
  static const Color PRIMARY_COLOR_DARK = Color(0xFF0D3656);
  static const Color accentColor = Colors.white;
  static const Color WHITE = Color(0xFFFFFFFF);
  static Color textColor = HexColor('414143');

  //background 025A4C
  //textcolor 414143
  // static const Color BLACK = Color(0xFF000000);
  // static const Color GREY = Color(0xFF9F9F9F);
  // static const Color GREY50 = Color(0xFFFAFAFA);
  // static const Color RED = Color(0xFFFF0000);

  ///light theme data
  static final light = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: pIMARYCOLOR,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Themes.pRIMARYCOLORLIGHT, // background
        onPrimary: Themes.WHITE, // foreground/text
        onSurface: Themes.pRIMARYCOLORLIGHT, // disabled
        textStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: SizeConfig.textMultiplier,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white, // foreground/text
        backgroundColor: pIMARYCOLOR, // background
        textStyle: TextStyle(
          fontSize: SizeConfig.textMultiplier,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: Colors.white, // foreground
        onSurface: Colors.grey, // disabled
        backgroundColor: Colors.teal, // background
      ),
    ),
  );

  static Color darkBackgroundColor = const Color(0xFF0D3656);
  static Color darkPrimaryColor = const Color(0xFF0D3656);
  static Color darkAccentColor = Colors.blueGrey.shade600;
  static Color darkParticlesColor = const Color(0x441C2A3D);

  ///dark theme data
  static final dark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
