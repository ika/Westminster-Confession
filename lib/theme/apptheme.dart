import 'package:flutter/material.dart';

part 'blue_delight.dart';
part 'aqua_blue.dart';
part 'pink_sakura.dart';
part 'green_forest.dart';
part 'sepia.dart';

// ThemeData lightTheme = ThemeData(
//   useMaterial3: true,
//   colorScheme: lightColorScheme,
// );
//
// ThemeData darkTheme = ThemeData(
//   useMaterial3: true,
//   colorScheme: darkColorScheme,
// );

ThemeData selectTheme(int themeNumber) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: getColorScheme(themeNumber),
  );
}

ColorScheme getColorScheme(int themeNumber) {
  switch (themeNumber) {
    case 0:
      return blueDelightLight;
    case 1:
      return blueDelightDark;
    case 2:
      return aquaBlueLight;
    case 3:
      return aquaBlueDark;
    case 4:
      return pinkSakuraLight;
    case 5:
      return pinkSakuraDark;
    case 6:
      return greenForestLight;
    case 7:
      return greenForestDark;
    case 8:
      return sepiaLight;
    case 9:
      return sepiaDark;
    default:
      return sepiaLight;
  }
}
