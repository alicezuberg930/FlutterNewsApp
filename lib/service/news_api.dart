import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/model/article.dart';

class NewsAPI {
  static const String apiKey = "0410f163c47845869a07e48477123729";

  Future<List<Article>> getAllArticles(String option, String query) async {
    String apiUrl =
        "https://newsapi.org/v2/$option?apiKey=0410f163c47845869a07e48477123729$query";
    Response res = await get(Uri.parse(apiUrl));
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> dynaRes = body['articles'];
      List<Article> articles =
          dynaRes.map((dynamic item) => Article.fromJson(item)).toList();
      // return articles;
      return articles;
    } else {
      throw ('API Bị lỗi');
    }
  }
}
