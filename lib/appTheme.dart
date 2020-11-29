import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constance/constance.dart' as constance;

class AppTheme {
  static bool isLightTheme = true;

  //static Color primaryLightColors = HexColor("#EB1165");
  // static Color primaryDarkColors = HexColor("#1F1F1F");

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      title: GoogleFonts.openSans(
          textStyle: TextStyle(
              color: base.title.color,
              fontSize: 20,
              fontWeight: FontWeight.w500)),
      subhead: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.subhead.color, fontSize: 16)),
      subtitle: GoogleFonts.openSans(
          textStyle: TextStyle(
              color: base.subtitle.color,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      body1: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.body1.color, fontSize: 16)),
      body2: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.body2.color, fontSize: 14)),
      button: GoogleFonts.openSans(
          textStyle: TextStyle(
              color: base.button.color,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      caption: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.caption.color, fontSize: 12)),
      display1: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.display1.color, fontSize: 34)),
      display2: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.display2.color, fontSize: 48)),
      display3: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.display3.color, fontSize: 60)),
      display4: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.display4.color, fontSize: 96)),
      headline: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.headline.color, fontSize: 24)),
      overline: GoogleFonts.openSans(
          textStyle: TextStyle(color: base.overline.color, fontSize: 10)),
    );
  }

  static ThemeData getTheme() {
    if (isLightTheme) {
      return lightTheme();
    } else {
      return darkTheme();
    }
  }

  static ThemeData lightTheme() {
    Color primaryColor = HexColor(constance.primaryColorString);
    Color secondaryColor = HexColor(constance.secondaryColorString);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: Colors.black,
      secondary: Colors.black,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFEEECEB),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
      cursorColor: primaryColor,
    );
  }

  static ThemeData darkTheme() {
    Color primaryColor = HexColor(constance.primaryColorString);
    Color secondaryColor = HexColor(constance.secondaryColorString);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: Colors.grey[850],
      scaffoldBackgroundColor: Colors.black,
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      cursorColor: primaryColor,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
