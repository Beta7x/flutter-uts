import 'package:fluter_article_app/models/source_model.dart';

class News {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  // News constructor
  News({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      source: Source.fromJson(json['source']),
      author: json['author'].toString(),
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'].toString(),
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}
