import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _MyAppState();
}

class _MyAppState extends State<PostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

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

  Future<void> uploadNote(String title, String body) async {
    final payload = {
      "title": title,
      "body": body,
    };

    const String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6InVzZXItMk9aTVVWbTZTZ0ZoanlGTyIsImVtYWlsIjoicXdlcnR5MTIzNDU2NzhAZ21haWwuY29tIiwibmFtZSI6InVkaW4iLCJpYXQiOjE2Njg1NzQ4ODl9.4a-vEUvmWCbZrix7-NTjesjQwXUkw0GUcUmgE1ievw0";

    const url = 'https://notes-api.dicoding.dev/v1/notes';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(payload), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      showSuccessMessage('Success add Note');
    } else {
      showErrorMessage('Failed add Note');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter Title",
                labelText: "Title",
                suffixIcon: const Padding(
                    padding: EdgeInsets.all(15.0), child: Icon(Icons.person)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value != "" || value != " ") {
                  return "Field cannot be empety";
                }
                return null;
              },
            ),
            const SizedBox(width: 20, height: 20),
            TextFormField(
              controller: bodyController,
              decoration: InputDecoration(
                hintText: "Enter Note",
                labelText: "Note",
                suffixIcon: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(Icons.home_work)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value != "" || value != " ") {
                  return "Field cannot be empety";
                }
                return null;
              },
            ),
            const SizedBox(width: 20, height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  minimumSize: const Size(300, 50),
                ),
                onPressed: () {
                  String title = titleController.text.toString();
                  String body = bodyController.text.toString();

                  uploadNote(title, body);
                  // Upload(name, address, desc);
                },
                child: const Text("Post Data"))
          ],
        ),
      ),
    );
  }
}
