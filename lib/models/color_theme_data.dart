import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ColorThemeData with ChangeNotifier {

  ThemeData greenTheme =  ThemeData(
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.green,
    accentColor: Colors.green,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),),);
  ThemeData redTheme =  ThemeData(
    primaryColor: Colors.red,
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: Colors.red,
    accentColor: Colors.red,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),),);
  ThemeData _selectedThemeData = ThemeData(
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.green,
    accentColor: Colors.green,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),),);//ilk olarak green açılmasını, initialize etmesini sağlar.
  static SharedPreferences? _sharedPreferences;
  bool _isGreen= true;

  void switchTheme(bool selected) {
    _isGreen = selected;
    saveThemetoSharedPref(selected);
    notifyListeners();
  }

  bool get isGreen=>_isGreen;
  ThemeData get selectedThemeData => _isGreen?greenTheme:redTheme;

  Future<void> createPrefObject () async {
    _sharedPreferences = await SharedPreferences.getInstance();

  }
  
  void saveThemetoSharedPref(bool value) {
    _sharedPreferences!.setBool('themeData', value);
  }

  void loadThemeFromSharedPreferences() {
    _isGreen = _sharedPreferences!.getBool('themeData')??true;
  }


}

