import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/service/news_api.dart';
import 'package:news_app/widget/article_list_tile.dart';
import 'package:news_app/widget/article_slider_tiles.dart';
import 'package:news_app/widget/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  NewsAPI news = NewsAPI();
  List<Tab> tabList = const [
    Tab(
      child: Text("All news"),
    ),
    Tab(
      child: Text("Fashion"),
    ),
    Tab(
      child: Text("Sport"),
    ),
    Tab(
      child: Text("Entertainment"),
    ),
    Tab(
      child: Text("Politics"),
    ),
    Tab(
      child: Text("Economy"),
    )
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
    super.dispose();
  }

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                newsSlider("top-headlines", "&q=entertainment"),
                newsBody("everything", "&q=entertainment"),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                newsSlider("top-headlines", "&q=politics"),
                newsBody("everything", "&q=politics"),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                newsSlider("top-headlines", "&q=economy"),
                newsBody("everything", "&q=economy"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  newsSlider(String option, String query) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 8, bottom: 15),
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
        height: MediaQuery.of(context).size.height * 0.3,
        child: FutureBuilder(
          future: news.getAllArticles(option, query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      articleSliderTile(snapshot.data![index], context));
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
        const Text(
          "Trending",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        FutureBuilder(
          future: news.getAllArticles(option, query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      articleListTile(snapshot.data![index], context));
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
