// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/screen/article_details_screen.dart';

class ArticleListTile extends StatelessWidget {
  final Article article;
  void Function()? onDeletePress;
  bool isFavorite;
  ArticleListTile({super.key, required this.article, this.onDeletePress, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailsScreen(article: article),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: article.urlToImage != null
                      ? Image.network(
                          article.urlToImage!,
                          filterQuality: FilterQuality.none,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/error_not_found.jpg',
                              fit: BoxFit.cover,
                            );
                          },
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
                        )
                      : Image.asset(
                          'assets/images/error_not_found.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            article.source?.name ?? 'Anonymous',
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        if (isFavorite) ...[
                          IconButton(onPressed: onDeletePress, icon: const Icon(Icons.delete, color: Colors.red)),
                        ]
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(article.publishedAt?.split('T')[0] ?? 'Chưa xác định'),
                    const SizedBox(height: 15),
                    Text(
                      article.title ?? 'Tựa đề rỗng',
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
