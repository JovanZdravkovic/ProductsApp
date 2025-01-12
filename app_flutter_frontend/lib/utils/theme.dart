import 'package:flutter/material.dart';

var cardTextTheme = TextTheme(
  bodySmall: TextStyle(color: Colors.white),
  bodyMedium: TextStyle(color: Colors.white),
  bodyLarge: TextStyle(color: Colors.white),
);

var cardTheme = CardTheme(
  color: Colors.blue.shade800,
);

var elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    backgroundColor: WidgetStateProperty.all(Colors.blue.shade800),
    textStyle: WidgetStateProperty.all(TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    )),
  ),
);

var switchTheme = SwitchThemeData(
  overlayColor: WidgetStateProperty.all(Colors.blue.shade800),
);

var appTheme = ThemeData(
  cardTheme: cardTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  switchTheme: switchTheme,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue.shade800, 
    primary: Colors.blue.shade800, 
    onPrimary: Colors.white, 
    secondary: Colors.orange.shade800,
    onSecondary: Colors.white
  ),
);