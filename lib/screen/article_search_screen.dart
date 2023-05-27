import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/service/news_api.dart';
import 'package:news_app/widget/article_list_tile.dart';
import 'package:news_app/widget/search_bar.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  NewsAPI news = NewsAPI();
  TextEditingController searchController = TextEditingController();
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
        title: searchBar(context, searchController),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        elevation: 8,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: searchResultWidget(),
      ),
    );
  }

  // searchResultWidget() {
  //   return FutureBuilder(
  //     future: news.getAllArticles("everything", widget.query),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: snapshot.data!.length,
  //           itemBuilder: (context, index) =>
  //               articleListTile(snapshot.data![index], context),
  //         );
  //       } else if (snapshot.hasError) {
  //         return Center(
  //           child: Text(
  //             snapshot.error.toString(),
  //             style: const TextStyle(fontSize: 20, color: Colors.red),
  //           ),
  //         );
  //       } else {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }
  searchResultWidget() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: Article.articles.length,
      itemBuilder: (context, index) =>
          articleListTile(Article.articles[index], context),
    );
  }
}
