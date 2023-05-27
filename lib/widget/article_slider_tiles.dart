import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/screen/article_details_screen.dart';

Widget articleSliderTile(Article article, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArticleDetailsScreen(article: article),
        ),
      );
    },
    child: SizedBox(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(article.urlToImage ??
                    "https://t3.ftcdn.net/jpg/05/01/98/72/360_F_501987255_kb5LZcBmlcz00IejLlxpklpTbJ9ys5i8.jpg"),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 18, bottom: 8),
            height: 80,
            width: MediaQuery.of(context).size.height * 0.7,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      article.source?.name ?? 'Anonymous',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.title ?? 'Chưa xác định',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          )
        ],
      ),
    ),
  );
}
