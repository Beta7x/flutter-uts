import 'dart:convert';

import 'package:fluter_article_app/pages/visitor_add.dart';
import 'package:fluter_article_app/pages/visitor_detail.dart';
import 'package:fluter_article_app/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VisitorList extends StatefulWidget {
  const VisitorList({super.key});

  @override
  State<VisitorList> createState() => _VisitorPageState();
}

class _VisitorPageState extends State<VisitorList> {
  bool isLoading = true;
  List data = [];

  @override
  void initState() {
    super.initState();
    fetchAllVisitor();
  }

  void navigateDetailPage(Map item) {
    final route = MaterialPageRoute(
        builder: (context) => DetailVisitorPage(visitor: item));
    Navigator.push(context, route);
  }

  Future<void> navigateVisitorAdd() async {
    final route =
        MaterialPageRoute(builder: (context) => const AddVisitorPage());
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchAllVisitor();
  }

  Future<void> fetchAllVisitor() async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();

    try {
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
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: false).pop();
      Dialogs.popUp(context, '$e');
      debugPrint('$e');
    }

    setState(() {
      isLoading = false;
    });
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 65),
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
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 65),
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
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> deleteByKey(String key) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    final url = 'https://lrg2ak.deta.dev/visitors/$key';
    final uri = Uri.parse(url);
    try {
      final response = await http.delete(uri);
      if (response.statusCode == 200) {
        final filtered =
            data.where((element) => element['key'] != key).toList();
        setState(() {
          data = filtered;
        });
        showSuccessMessage("Delete successfully");
      } else {
        showErrorMessage("Error when deleting visitor");
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: false).pop();
      Dialogs.popUp(context, '$e');
      debugPrint('$e');
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
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchAllVisitor,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index] as Map;
              final key = item['key'] as String;
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(item['name']),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'detail') {
                      navigateDetailPage(item);
                    } else if (value == 'delete') {
                      deleteByKey(key);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'detail',
                        child: Text("Detail"),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text("Delete"),
                      ),
                    ];
                  },
                ),
                onTap: () {
                  debugPrint(item['key']);
                },
                subtitle: Text(item['address']),
              );
            },
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
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
