import 'package:flutter/material.dart';
import 'package:news_app/screen/home.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng xem tin tức',
      theme: ThemeData(
          primaryColor: Colors.blue[300],
          scaffoldBackgroundColor: Colors.white),
      home: const HomePage(),
    );
  }
}
