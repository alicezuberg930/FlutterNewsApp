import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/service/news_api.dart';
import 'package:news_app/widget/article_list_tile.dart';

class ArticleSearchScreen extends StatefulWidget {
  const ArticleSearchScreen({Key? key}) : super(key: key);

  @override
  State<ArticleSearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<ArticleSearchScreen> {
  NewsAPI news = NewsAPI();
  TextEditingController searchController = TextEditingController();
  List<Article> articles = [];

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
        title: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            isCollapsed: true,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: 'Tìm kiếm',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            if (searchController.text.length > 3) {
              setState(() {
                articles = news.searchArticles(searchController.text);
              });
            }
          },
        ),
        elevation: 8,
        centerTitle: true,
      ),
      body: articles.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) => ArticleListTile(article: articles[index]),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: const Text(
                'No articles found',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
    );
  }

  searchResultWidget() {
    return FutureBuilder(
      future: news.getAllArticles("everything", searchController.text),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            // physics: const AlwaysScrollableScrollPhysics(),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => ArticleListTile(article: snapshot.data![index]),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // searchResultWidget() {
  //   return ListView.builder(
  //     physics: const NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemCount: Article.articles.length,
  //     itemBuilder: (context, index) => ArticleListTile(article: Article.articles[index]),
  //   );
  // }
}
