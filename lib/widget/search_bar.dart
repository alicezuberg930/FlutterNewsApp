import 'package:flutter/material.dart';
import 'package:news_app/screen/article_search_screen.dart';

searchBar(BuildContext context, TextEditingController searchController) {
  return TextField(
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
      if (searchController.text != "") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchScreen(
              query: "&q=$value",
            ),
          ),
        );
      }
    },
  );
}
