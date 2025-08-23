import 'dart:io';

class Globals {
  // Navigator delay
  static int navigatorDelay = 200;
  static int navigatorLongDelay = 400;
  // Share feature enabled only on Android
  static bool isShareEnabled = (Platform.isAndroid) ? true : false;
}
