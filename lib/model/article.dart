import 'package:news_app/model/source.dart';

class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        source: Source.fromJson(json['source']),
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content']);
  }
  static List<Article> articles = [
    Article(
        source: Source(id: "", name: "Google"),
        author: "IHBFWIUFIUW",
        title: "Kotlin la con cac cut cmm di kotlin",
        description: "kotlin rach cut cho t",
        url: "http://cwohce.com/eiojerie",
        urlToImage:
            "https://f7-zpc.zdn.vn/4864748304646068276/6fc58e7ac65e1800414f.jpg",
        publishedAt: "12-12-2020T12:19",
        content: "wdndw"),
    Article(
        source: Source(id: "", name: "Google"),
        author: "IHBFWIUFIUW",
        title: "Kotlin la con cac cut cmm di kotlin",
        description: "kotlin rach cut cho t",
        url: "http://cwohce.com/eiojerie",
        urlToImage:
            "https://f7-zpc.zdn.vn/4864748304646068276/6fc58e7ac65e1800414f.jpg",
        publishedAt: "12-12-2020T12:19",
        content: "wdndw"),
    Article(
        source: Source(id: "", name: "Google"),
        author: "IHBFWIUFIUW",
        title: "Kotlin la con cac cut cmm di kotlin",
        description: "kotlin rach cut cho t",
        url: "http://cwohce.com/eiojerie",
        urlToImage:
            "https://f7-zpc.zdn.vn/4864748304646068276/6fc58e7ac65e1800414f.jpg",
        publishedAt: "12-12-2020T12:19",
        content: "wdndw"),
    Article(
        source: Source(id: "", name: "Google"),
        author: "IHBFWIUFIUW",
        title: "Kotlin la con cac cut cmm di kotlin",
        description: "kotlin rach cut cho t",
        url: "http://cwohce.com/eiojerie",
        urlToImage:
            "https://f7-zpc.zdn.vn/4864748304646068276/6fc58e7ac65e1800414f.jpg",
        publishedAt: "12-12-2020T12:19",
        content: "wdndw"),
    Article(
        source: Source(id: "", name: "Google"),
        author: "IHBFWIUFIUW",
        title: "Kotlin la con cac cut cmm di kotlin",
        description: "kotlin rach cut cho t",
        url: "http://cwohce.com/eiojerie",
        urlToImage:
            "https://f7-zpc.zdn.vn/4864748304646068276/6fc58e7ac65e1800414f.jpg",
        publishedAt: "12-12-2020T12:19",
        content: "wdndw"),
    Article(
        source: Source(id: "", name: "Google"),
        author: "IHBFWIUFIUW",
        title: "Kotlin la con cac cut cmm di kotlin",
        description: "kotlin rach cut cho t",
        url: "http://cwohce.com/eiojerie",
        urlToImage:
            "https://f7-zpc.zdn.vn/4864748304646068276/6fc58e7ac65e1800414f.jpg",
        publishedAt: "12-12-2020T12:19",
        content: "wdndw"),
    Article(
        source: Source(id: "", name: "Google"),
        author: "IHBFWIUFIUW",
        title: "Kotlin la con cac cut cmm di kotlin",
        description: "kotlin rach cut cho t",
        url: "http://cwohce.com/eiojerie",
        urlToImage:
            "https://f7-zpc.zdn.vn/4864748304646068276/6fc58e7ac65e1800414f.jpg",
        publishedAt: "12-12-2020T12:19",
        content: "wdndw"),
  ];
}
