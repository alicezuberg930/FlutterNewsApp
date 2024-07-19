import 'package:flutter/material.dart';
import 'package:news_app/common/shared_preferences.dart';
import 'package:news_app/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference.initPref();
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
      title: 'Application for newspaper',
      theme: ThemeData(primaryColor: Colors.blue[300], scaffoldBackgroundColor: Colors.white),
      home: const HomePage(),
    );
  }
}
