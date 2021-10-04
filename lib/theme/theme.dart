import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeProvider = ChangeNotifierProvider<AppDynamicTheme>((ref) {
  return AppDynamicTheme();
});

class AppDynamicTheme extends ChangeNotifier {
  AppDynamicTheme();

  static bool isDark = true;

  void toggle() {
    isDark = !isDark;
    notifyListeners();
  }

  ThemeData getTheme() {
    // return isDark ? darkTheme : lightTheme;
    return lightTheme;
  }

  /// DARK
  static final ThemeData lightTheme = ThemeData(
    // primarySwatch: Colors.grey,
    // backgroundColor: Colors.black,
    // disabledColor: Colors.white30,
    colorScheme: ColorScheme(
      primary: Color(0xFFF4F4F2),
      primaryVariant: Color(0xFFE8E8E8),
      onPrimary: Colors.black,
      secondary: Color(0xFFBBBFCA),
      secondaryVariant: Color(0xFF495464),
      onSecondary: Colors.black,
      surface: Color(0xFF4B6587),
      onSurface: Colors.black,
      background: Colors.white,
      onBackground: Colors.black,
      error: Colors.redAccent.shade400,
      onError: Colors.red,
      brightness: Brightness.light,
    ),
    primaryTextTheme: const TextTheme(

      /// Titles (Extremely Large text)
      headline1: TextStyle(fontSize: 48, color: Colors.black), // title
      /// Subtitles (Very Large Text)
      headline2: TextStyle(fontSize: 36, color: Colors.black), // description
      
      headline3: TextStyle(fontSize: 24, color: Colors.black), // description

      /// Standard text for small screen
      bodyText1: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ), // normal
      /// Standard text for large screen
      bodyText2: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ), // normal
    ),
  );

  /// LIGHT
  // static final ThemeData lightTheme = ThemeData(
  //   primarySwatch: Colors.blueGrey,
  //   backgroundColor: Colors.white.withOpacity(0.35),
  //   disabledColor: Colors.black38,
  //   appBarTheme: const AppBarTheme(
  //       iconTheme: IconThemeData(color: Colors.black),
  //       color: Colors.white,
  //       shadowColor: Colors.grey,
  //       brightness: Brightness.light,
  //       elevation: 50),
  //   accentColor: Colors.blueAccent,
  //   cardColor: Colors.lightBlueAccent.withOpacity(0.75),
  //   primaryTextTheme: TextTheme(
  //     button: TextStyle(
  //       color: Colors.blueGrey,
  //       decorationColor: Colors.blueGrey[300],
  //     ),

  //     /// Default to large screen
  //     /// AdaptableText handles fontsize for other screen sizes
  //     ///
  //     /// Titles (Extremely Large text)
  //     headline1:
  //         const TextStyle(fontSize: 48, color: Colors.black), // description
  //     /// Subtitles (Very Large Text)
  //     headline2: const TextStyle(fontSize: 36, color: Colors.black), // title
  //     bodyText1: const TextStyle(
  //       fontSize: 20,
  //       color: Colors.black,
  //     ), // normal
  //     /// Default text (normal body text)
  //     bodyText2: const TextStyle(
  //       fontSize: 18,
  //       color: Colors.black,
  //     ), // normal
  //   ),
  //   textButtonTheme: TextButtonThemeData(
  //       style: TextButton.styleFrom(
  //           primary: Colors.lightBlueAccent, elevation: 30)),
  //   bottomAppBarColor: Colors.blueGrey[900],
  //   iconTheme: const IconThemeData(color: Colors.blueGrey),
  //   brightness: Brightness.light,
  // );
}
