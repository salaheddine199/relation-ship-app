import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static SharedPreferences sharedPreferences;

  static init() async{
     sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setDarkMode({@required bool darkMode}) async{
    return await sharedPreferences.setBool('darkMode', darkMode);
  }

  static bool getDarkMode(){
    return (sharedPreferences.getBool('darkMode'))?? false;
  }

}