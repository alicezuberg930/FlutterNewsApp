import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/common/shared_preferences.dart';
import 'package:news_app/common/ui_helpers.dart';
import 'package:news_app/model/article.dart';
import 'package:share_plus/share_plus.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final Article article;

  const ArticleDetailsScreen({Key? key, required this.article}) : super(key: key);

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    List<Article> articles = SharedPreference.getArticleList();
    final check = articles.where((item) => item.url == widget.article.url && item.title == widget.article.title);
    if (check.isNotEmpty) isFavorite = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomRight,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                        child: widget.article.urlToImage != null
                            ? Image.network(
                                widget.article.urlToImage!,
                                filterQuality: FilterQuality.none,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.blue,
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/error_not_found.jpg',
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/error_not_found.jpg',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: -23,
                      right: MediaQuery.of(context).size.width * 0.5 - 25,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 5)],
                        ),
                        padding: const EdgeInsets.all(5),
                        child: IconButton(
                          hoverColor: Colors.cyan,
                          icon: const Icon(Icons.person, color: Colors.black),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -23,
                      right: 30,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 5)],
                            ),
                            padding: const EdgeInsets.all(5),
                            child: IconButton(
                              icon: const Icon(Icons.share, color: Colors.black),
                              onPressed: () async {
                                await Share.share('Bài báo này thật tuyệt: ${widget.article.url!}', subject: "Share article");
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            margin: const EdgeInsets.only(top: 0),
                            decoration: BoxDecoration(
                              color: isFavorite ? Colors.red : Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 5)],
                            ),
                            padding: const EdgeInsets.all(5),
                            child: IconButton(
                              icon: Icon(Icons.favorite, color: isFavorite ? Colors.white : Colors.red),
                              onPressed: () async {
                                List<Article> articles = SharedPreference.getArticleList();
                                if (isFavorite) {
                                  articles.removeWhere((item) => item.url == widget.article.url && item.title == widget.article.title);
                                  await SharedPreference.saveArticleList(jsonEncode(articles));
                                  if (context.mounted) UIHelpers.showSnackBar(context, Colors.blue, "Removed from favorite article");
                                  setState(() => isFavorite = false);
                                } else {
                                  final check = articles.where((item) => item.url == widget.article.url && item.title == widget.article.title);
                                  if (check.isEmpty) articles.add(widget.article);
                                  await SharedPreference.saveArticleList(jsonEncode(articles));
                                  if (context.mounted) UIHelpers.showSnackBar(context, Colors.blue, "Added to favorite article");
                                  setState(() => isFavorite = true);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        widget.article.author ?? "Không tác giả",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.article.source?.name ?? 'Anonymous',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.article.title ?? 'Tựa đề rỗng',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Ngày đăng: ${widget.article.publishedAt?.split('T')[0] ?? 'Chưa xác định'}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          widget.article.content ?? 'Chưa có bình luận',
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
