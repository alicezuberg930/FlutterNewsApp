import 'dart:convert';

import 'package:news_app/model/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static String userloggedinKeys = "LOGGEDINKEY";
  static String usernameKey = "USERNAMEKEY";
  static String useremailKey = "USEREMAILKEY";
  static String avatarKey = "AVATARKEY";
  static String userDataKey = "USERDATA";
  static String articleListKey = "ARTICLELISTKEY";

  static late SharedPreferences pref;

  static initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  //Lưu dữ liệu vào shared prefrences
  static saveUserLoggedInStatus(bool isUserLoggedIn) async {
    await pref.setBool(userloggedinKeys, isUserLoggedIn);
  }

  static saveUserData(String data) async {
    await pref.setString(userDataKey, data);
  }

  static saveArticleList(String data) async {
    await pref.setString(articleListKey, data);
  }

  //Đọc dữ liệu từ shared preferences
  static clearAllData() async {
    await pref.clear();
  }

  static clearKeyData(String key) async {
    await pref.remove(key);
  }

  // static getUserData() {
  //   String? userData = pref.getString(userDataKey);
  //   if (userData == null) return null;
  //   Map<String, dynamic> userMap = json.decode(userData);
  //   return ChatUser.fromJson(userMap);
  // }

  static List<Article> getArticleList() {
    String? articleListString = pref.getString(articleListKey);
    if (articleListString == null) return [];
    List<dynamic> dynamicArticles = json.decode(articleListString);
    return dynamicArticles.map((dynamic item) => Article.fromJson(item)).toList();
  }
}
