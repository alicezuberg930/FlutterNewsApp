import 'package:flutter/material.dart';
import 'package:news_app/screen/article_search_screen.dart';
import 'package:news_app/screen/favorite_article_screen.dart';
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
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
        key: scaffoldKey,
        drawer: customDrawerWidget(),
        appBar: AppBar(
          title: const Text('News app'),
          elevation: 8,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ArticleSearchScreen()),
                );
              },
            ),
          ],
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

  toggleDrawer() async {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openEndDrawer();
    } else {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  customDrawerWidget() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          // Container(
          //   alignment: Alignment.center,
          //   child: Stack(
          //     children: [
          //       ClipRRect(
          //         borderRadius: BorderRadius.circular(100),
          //         child: Image(
          //           image: NetworkImage(widget.user.avatar!),
          //           height: 120,
          //           width: 120,
          //           fit: BoxFit.cover,
          //           filterQuality: FilterQuality.high,
          //         ),
          //       ),
          //       Positioned(
          //         bottom: 5,
          //         right: 5,
          //         child: Container(
          //           padding: const EdgeInsets.all(10),
          //           decoration: BoxDecoration(
          //             color: Colors.grey,
          //             borderRadius: BorderRadius.circular(50),
          //           ),
          //           child: InkWell(
          //             onTap: () => showImagePicker(context, chooseImage),
          //             child: const Icon(Icons.camera_alt, color: Constants.primaryColor, size: 20),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 15),
          // Text(
          //   widget.user.name!,
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 22,
          //     color: isDarkMode ? Colors.white : Colors.black,
          //   ),
          // ),
          // const SizedBox(height: 20),
          // Divider(height: 4, color: Colors.black),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteArticlesScreen()),
              );
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: const Text(
              "Favorite articles",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // ListTile(
          //   onTap: () async => {
          //     showDialog(
          //       barrierDismissible: false,
          //       context: context,
          //       builder: (context) {
          //         return AlertDialog(
          //           elevation: 5,
          //           title: const Row(
          //             children: [
          //               Icon(Icons.warning),
          //               SizedBox(width: 5),
          //               Text(
          //                 "Alert",
          //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //               ),
          //             ],
          //           ),
          //           content: const Text("Are you sure you want to log out?"),
          //           actions: [
          //             GestureDetector(
          //               child: ElevatedButton(
          //                 style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
          //                 onPressed: () => {Navigator.pop(context)},
          //                 child: const Text("No"),
          //               ),
          //             ),
          //             GestureDetector(
          //               child: ElevatedButton(
          //                 style: ElevatedButton.styleFrom(
          //                   padding: const EdgeInsets.all(10),
          //                   backgroundColor: Colors.yellow[700],
          //                 ),
          //                 onPressed: () async {
          //                   SharedPreference.clearAllData();
          //                   Navigator.of(Constants().navigatorKey.currentContext!).pushNamed(RouteGeneratorService.loginScreen);
          //                 },
          //                 child: const Text("Yes"),
          //               ),
          //             ),
          //           ],
          //         );
          //       },
          //     ),
          //   },
          //   contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          //   leading: const Icon(Icons.exit_to_app, color: Constants.primaryColor),
          //   title: Text(
          //     "Log out",
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: isDarkMode ? Colors.white : Colors.black,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
