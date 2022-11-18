import 'package:fluter_article_app/models/news_model.dart';
import 'package:fluter_article_app/services/news_api_service.dart';
import 'package:fluter_article_app/widgets/custom_title.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   theme: ThemeData.fallback(),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: "News Page",
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Linux News",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: FutureBuilder(
          future: client.getArticle(),
          builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
            //let's check if we got a response or not
            if (snapshot.hasData) {
              //Now let's make a list of articles
              List<News>? articles = snapshot.data;
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 58,
                  right: 10,
                  left: 10,
                  top: 10,
                ),
                child: ListView.builder(
                  //Now let's create our custom List tile
                  itemCount: articles?.length,
                  itemBuilder: (context, index) =>
                      customListTile(articles![index], context),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
