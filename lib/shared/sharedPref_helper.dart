
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

  // todo I think it's better to set it String and add System themeMode
  static Future<bool> setLanguage({@required bool lang}) async{
    return await sharedPreferences.setBool('isEng', lang);
  }
  static bool getLanguage(){
    return (sharedPreferences.getBool('isEng'))?? true;
  }


  // static Future<bool> setIsFirstTime({@required bool isFirst}) async{
  //   return await sharedPreferences.setBool('isFirstTime', isFirst);
  // }
  // static bool getIsFirstTime(){
  //   bool is1 =  (sharedPreferences.getBool('isFirstTime'))?? true;
  //   // if( is1 )
  //   //   setIsFirstTime(isFirst: false);
  //
  //   return is1;
  // }


}