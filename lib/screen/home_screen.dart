import 'package:flutter/material.dart';
import 'package:news_app/screen/article_search_screen.dart';
import 'package:news_app/service/news_api.dart';
import 'package:news_app/widget/article_list_tile.dart';
import 'package:news_app/widget/article_slider_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  NewsAPI news = NewsAPI();
  List<Tab> tabList = const [
    Tab(
      child: Text("Everything"),
    ),
    Tab(
      child: Text("Fashion"),
    ),
    Tab(
      child: Text("Sport"),
    ),
    // Tab(
    //   child: Text("Entertainment"),
    // ),
    // Tab(
    //   child: Text("Politics"),
    // ),
    // Tab(
    //   child: Text("Economy"),
    // )
  ];
  TabController? tabController;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    tabController = TabController(length: tabList.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News app'),
          leading: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArticleSearchScreen(),
                ),
              );
            },
          ),
          elevation: 8,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              isScrollable: true,
              controller: tabController,
              tabs: tabList,
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  newsSlider("top-headlines", "&q=all news"),
                  newsBody("everything", "&q=all news"),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  newsSlider("top-headlines", "&q=fashion"),
                  newsBody("everything", "&q=fashion"),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  newsSlider("top-headlines", "&q=sport"),
                  newsBody("everything", "&q=sport"),
                ],
              ),
            ),
            // SingleChildScrollView(
            //   padding: const EdgeInsets.all(5),
            //   child: Column(
            //     children: [
            //       newsSlider("top-headlines", "&q=entertainment"),
            //       newsBody("everything", "&q=entertainment"),
            //     ],
            //   ),
            // ),
            // SingleChildScrollView(
            //   padding: const EdgeInsets.all(5),
            //   child: Column(
            //     children: [
            //       newsSlider("top-headlines", "&q=politics"),
            //       newsBody("everything", "&q=politics"),
            //     ],
            //   ),
            // ),
            // SingleChildScrollView(
            //   padding: const EdgeInsets.all(5),
            //   child: Column(
            //     children: [
            //       newsSlider("top-headlines", "&q=economy"),
            //       newsBody("everything", "&q=economy"),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  newsSlider(String option, String query) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 5),
      // child: SizedBox(
      //   height: MediaQuery.of(context).size.height * 0.3,
      //   child: ListView.builder(
      //     shrinkWrap: true,
      //     scrollDirection: Axis.horizontal,
      //     itemCount: Article.articles.length,
      //     itemBuilder: (context, index) =>
      //         articleSliderTile(Article.articles[index], context),
      //   ),
      // ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: FutureBuilder(
          future: news.getAllArticles(option, query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ArticleSliderTile(article: snapshot.data![index]),
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
        ),
      ),
    );
  }

  newsBody(String option, String query) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Trending",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 3),
          ),
        ),
        const SizedBox(height: 15),
        FutureBuilder(
          future: news.getAllArticles(option, query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
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
        ),
      ],
    );
  }

  // newsBody(String option, String query) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         "Trending",
  //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 15),
  //       ListView.builder(
  //         physics: const NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: Article.articles.length,
  //         itemBuilder: (context, index) =>
  //             articleListTile(Article.articles[index], context),
  //       ),
  //     ],
  //   );
  // }
}
