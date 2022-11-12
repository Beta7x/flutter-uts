import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluter_article_app/pages/about_page.dart';
import 'package:fluter_article_app/pages/add_page.dart';
import 'package:fluter_article_app/pages/more_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;
  final screens = [const MorePage(), const AddPage(), const AboutPage()];

  @override
  Widget build(BuildContext context) {
    // List of page
    final items = <Widget>[
      const Icon(Icons.playlist_add_rounded, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.person, size: 30),
    ];

    return Container(
      color: Colors.blue,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.blue,
            body: screens[index],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  iconTheme: const IconThemeData(color: Colors.white)),
              child: CurvedNavigationBar(
                // set duration in animation
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 300),
                // setting background color
                color: Colors.black87,
                // setting button hover background color
                buttonBackgroundColor: Colors.black,
                items: items,
                height: 55,
                index: index,
                backgroundColor: Colors.transparent,
                onTap: (index) => setState(() => this.index = index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
