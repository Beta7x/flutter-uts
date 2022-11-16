import 'dart:convert';

import 'package:fluter_article_app/pages/visitor_add.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VisitorList extends StatefulWidget {
  const VisitorList({super.key});

  @override
  State<VisitorList> createState() => _VisitorPageState();
}

class _VisitorPageState extends State<VisitorList> {
  List data = [];

  @override
  void initState() {
    super.initState();
    fetchAllVisitor();
  }

  void navigateVisitorAdd() {
    final route =
        MaterialPageRoute(builder: (context) => const AddVisitorPage());
    Navigator.push(context, route);
  }

  Future<void> fetchAllVisitor() async {
    // GET data visitor from server
    const url = 'https://lrg2ak.deta.dev/visitors';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    // controlling data form server
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        data = result;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Visitor",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      // Show all Data using List View
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index] as Map;
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(item['name']),
            onTap: () {
              debugPrint(item['key']);
            },
            subtitle: Text(item['address']),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 55.0),
        child: FloatingActionButton(
          onPressed: navigateVisitorAdd,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
