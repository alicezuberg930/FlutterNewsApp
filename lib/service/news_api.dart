import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/common/constants.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/service/data.dart';

class NewsAPI {
  Future<List<Article>> getAllArticles(String option, String query) async {
    return FakeData.data.map((dynamic item) => Article.fromJson(item)).toList();
    Response res = await get(Uri.parse("https://newsapi.org/v2/$option?apiKey=${Constants.apiKey}$query"));
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return body['articles'].map((dynamic item) => Article.fromJson(item)).toList();
    } else {
      throw Exception(jsonDecode(res.body)["message"]);
    }
  }

  List<Article> searchArticles(String query) {
    List<Article> articles = FakeData.data.map((dynamic item) => Article.fromJson(item)).toList();
    List<Article> foundArticles = [];
    for (var element in articles) {
      if (element.title!.toLowerCase().contains(query.toLowerCase())) {
        foundArticles.add(element);
      }
    }
    return foundArticles;
  }
}
