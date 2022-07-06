import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chat_app/utils/constants.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  static final darkThemeData = ThemeData(
    fontFamily: 'LBC',
    brightness: Brightness.dark,
    backgroundColor: AppDarkConstant.APP_DARK_COLOR,
    canvasColor: AppDarkConstant.APP_DARK_COLOR,
      scaffoldBackgroundColor:AppDarkConstant.APP_DARK_COLOR,
      textTheme: TextTheme
        (headline1:TextStyle(color:Colors.white),
        headline2:TextStyle(color:Colors.white),
        headline3:TextStyle(color:Colors.white),
        headline4:TextStyle(color:Colors.white),
        headline5:TextStyle(color:Colors.white),
        headline6:TextStyle(color:Colors.white),
         bodyText1: TextStyle(color:Colors.white),
        bodyText2: TextStyle(color:Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),
       visualDensity:VisualDensity.adaptivePlatformDensity

  );

  static final lightThemeData = ThemeData(
      fontFamily: 'LBC',
      brightness: Brightness.light,
      backgroundColor: Colors.white,
     scaffoldBackgroundColor:AppLightConstant.APP_LIGHT_COLOR,
    canvasColor: AppLightConstant.APP_LIGHT_COLOR,
    textTheme: TextTheme
      (headline1:TextStyle(color:Colors.black),
      headline2:TextStyle(color:Colors.black),
      headline3:TextStyle(color:Colors.black),
      headline4:TextStyle(color:Colors.black),
      headline5:TextStyle(color:Colors.black),
      headline6:TextStyle(color:Colors.black),
      bodyText1: TextStyle(color:Colors.black),
      bodyText2: TextStyle(color:Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
      visualDensity:VisualDensity.adaptivePlatformDensity
   );


  final _key = Keys.THEMING_KEY;
  RxBool _isDark = false.obs;

  bool get darkTheme => _isDark.value;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  ThemeController() {
    var b = _loadThemeFromBox();
    updateTheme(b);
  }

  Future<void> updateTheme(bool v) async {
    _isDark.value = v;
    Get.changeTheme(v ? darkThemeData : lightThemeData);
    _saveThemeToBox(v);
  }
}
