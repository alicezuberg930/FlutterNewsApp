import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/common/shared_preferences.dart';
import 'package:news_app/common/ui_helpers.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/widget/article_list_tile.dart';

class FavoriteArticlesScreen extends StatefulWidget {
  const FavoriteArticlesScreen({super.key});

  @override
  State<FavoriteArticlesScreen> createState() => _FavoriteArticlesScreenState();
}

class _FavoriteArticlesScreenState extends State<FavoriteArticlesScreen> {
  List<Article> articles = [];
  @override
  void initState() {
    articles = SharedPreference.getArticleList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('Favorite articles'),
        elevation: 8,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            articles = SharedPreference.getArticleList();
          });
        },
        child: articles.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context, index) => ArticleListTile(
                  article: articles[index],
                  isFavorite: true,
                  onDeletePress: () async {
                    articles.removeAt(index);
                    await SharedPreference.saveArticleList(jsonEncode(articles));
                    if (context.mounted) UIHelpers.showSnackBar(context, Colors.blue, "Removed from favorite article");
                    setState(() {
                      articles = SharedPreference.getArticleList();
                    });
                  },
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: const Text(
                  'No articles found',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
      ),
    );
  }
}
