import 'dart:convert';

import 'package:fluter_article_app/pages/about/button_widget.dart';
import 'package:fluter_article_app/pages/about/profile_widget.dart';
import 'package:fluter_article_app/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool isLoading = false;
  String name = '';
  String email = '';
  String imageUrl = '';
  String address = '';
  String about = '';

  Future<void> getSessionProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var key = pref.getString('key');
    debugPrint(key);

    try {
      var uri = "https://lrg2ak.deta.dev/users/$key";
      var userDetail = await http.get(Uri.parse(uri), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      // controlling response
      if (userDetail.statusCode == 200) {
        final profile = json.decode(userDetail.body) as Map;
        setState(() {
          name = profile['name'];
          email = profile['email'];
          imageUrl = profile['imageUrl'];
          address = profile['address'];
          about = profile['about'];
        });
        debugPrint(userDetail.statusCode.toString());
      }
      debugPrint(imageUrl);
    } catch (e) {
      debugPrint('$e');
    }

    setState(() {
      isLoading = true;
    });
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
  void initState() {
    getSessionProfile();
    super.initState();
    debugPrint(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoading,
        child: RefreshIndicator(
          onRefresh: getSessionProfile,
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 58),
              child: ListView(
                children: [
                  ProfileWidget(
                    imagePath: imageUrl,
                    onClicked: () {},
                  ),
                  const SizedBox(height: 24),
                  buildName(name, email),
                  const SizedBox(height: 24),
                  Center(child: buildUpgradeButton()),
                  const SizedBox(height: 48),
                  buildAbout(address, about),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName(String userName, String email) => Column(
        children: [
          Text(
            userName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Log Out',
        onClicked: logOut,
      );

  Widget buildAbout(String address, String about) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Address',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              address,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
