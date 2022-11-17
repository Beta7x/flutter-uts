import 'dart:convert';

import 'package:fluter_article_app/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddVisitorPage extends StatefulWidget {
  const AddVisitorPage({super.key});

  @override
  State<AddVisitorPage> createState() => _AddVisitorPageState();
}

class _AddVisitorPageState extends State<AddVisitorPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Visitor"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Name',
              labelText: "Visitor Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              hintText: "Phone",
              labelText: "Visitor Phone",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              hintText: "Address",
              labelText: "Visitor Address",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: messageController,
            decoration: InputDecoration(
              hintText: 'Message',
              labelText: "Message",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 3, minimumSize: const Size(100, 50)),
            onPressed: submitAction,
            child: const Text("Add Visitor"),
          )
        ],
      ),
    );
  }

  Future<void> submitAction() async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    // GET the data form
    final name = nameController.text;
    final phone = phoneController.text;
    final address = addressController.text;
    final message = messageController.text;
    final body = {
      "name": name,
      "address": address,
      "phone": phone,
      "message": message,
    };

    try {
      // Submit data to the server
      const url = 'https://lrg2ak.deta.dev/visitors/add';
      final uri = Uri.parse(url);
      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

      // Show success or fail message based on status
      if (response.statusCode == 201) {
        nameController.text = '';
        phoneController.text = '';
        addressController.text = '';
        messageController.text = '';
        showSuccessMessage('Success add Visitor');
      } else {
        showErrorMessage('Failed add Visitor');
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: false).pop();
      Dialogs.popUp(context, '$e');
      debugPrint('$e');
    }
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
}
