import 'dart:convert';

import 'package:fluter_article_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<List<String>> getSessionProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var key = pref.getString('key');
    var uri = "http://192.168.43.28:3000/users/$key";
    var userDetail = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    var profile = json.decode(userDetail.body) as Map;
    List<String> list = [
      profile['imageUrl'],
      profile["name"],
      profile['email'],
      profile["address"],
      profile['about'],
    ];
    return list;
  }

  void loginPageRoute() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("is_login");
      preferences.remove('key');
    });
    loginPageRoute();
    showSuccessMessage("Logout");
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blue,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
