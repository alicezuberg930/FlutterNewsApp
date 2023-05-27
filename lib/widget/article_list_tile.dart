import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/screen/article_details_screen.dart';

Widget articleListTile(Article art, BuildContext context) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
    elevation: 5,
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(article: art),
          ),
        );
      },
      // child: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(20),
      //     boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
      //   ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 110,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(art.urlToImage ??
                    "https://t3.ftcdn.net/jpg/05/01/98/72/360_F_501987255_kb5LZcBmlcz00IejLlxpklpTbJ9ys5i8.jpg"),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(7),
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        art.source?.name ?? 'Anonymous',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(art.publishedAt?.split('T')[0] ?? 'Chưa xác định'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  art.title ?? 'Tựa đề rỗng',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    // ),
  );
}
