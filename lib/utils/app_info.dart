import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_configuration.dart';

class AppInfo{
  static String sharedKeyLocalLanguage = "motogp_live_sharedKeyLocalLanguage";

  static String getLocale(BuildContext context){
    try{
      var locale = Platform.localeName.split("_")[0];
      return locale;
    }catch(ex){
      var locale = Localizations.localeOf(context).toString();
      return locale;
    }
  }

  static Future<AppConfiguration> getAppInfo() async{
    var sp = await SharedPreferences.getInstance();
    return AppConfiguration(
      sp.getString(sharedKeyLocalLanguage) ?? "",
    );
  }

  static Future<void> clearData() async{
    var sp = await SharedPreferences.getInstance();
    await sp.clear();
  }

  /*static Future<void> logout() async{
    var sp = await SharedPreferences.getInstance();
    await sp.remove(AppInfo.sharedKeyEmail);
    await sp.remove(AppInfo.sharedKeyPassword);
    await sp.remove(AppInfo.sharedKeyToken);
    await sp.remove(AppInfo.sharedKeyTokenRefresh);
  }*/

}