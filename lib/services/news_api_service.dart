import 'dart:convert';

import 'package:fluter_article_app/models/news_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // end point for articles about linux
  final linuxEndPointUrl =
      "https://newsapi.org/v2/everything?q=linux&apiKey=943d2e7920ca4b84a2fba53f1f835ace";

  Future<List<News>> getArticle() async {
    var response = await http.get(Uri.parse(linuxEndPointUrl));

    if (response.statusCode == 200) {
      // Mapping response body into JSON object
      Map<String, dynamic> json = jsonDecode(response.body);
      // Get articles and Listing them
      List<dynamic> body = json['articles'];
      // Get different articles from 'body' and putting them into a List
      List<News> articles =
          body.map((dynamic item) => News.fromJson(item)).toList();

      return articles;
    } else {
      // If the function cannot get the list of articles
      throw ("Cannot get the articles");
    }
  }
}
