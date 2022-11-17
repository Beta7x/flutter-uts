import 'package:flutter/material.dart';

class DetailVisitorPage extends StatefulWidget {
  final Map? visitor;
  const DetailVisitorPage({
    super.key,
    this.visitor,
  });

  @override
  State<DetailVisitorPage> createState() => _AddVisitorPageState();
}

class _AddVisitorPageState extends State<DetailVisitorPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final visitor = widget.visitor;
    if (visitor != null) {
      final name = visitor['name'];
      final phone = visitor['phone'];
      final address = visitor['address'];
      final message = visitor['message'];
      nameController.text = name;
      phoneController.text = phone;
      addressController.text = address;
      messageController.text = message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Visitor"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: nameController,
            enabled: false,
            decoration: InputDecoration(
              labelText: "Nama Visitor",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: phoneController,
            enabled: false,
            decoration: InputDecoration(
              labelText: "Phone Visitor",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: addressController,
            enabled: false,
            decoration: InputDecoration(
              labelText: "Address Visitor",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: messageController,
            enabled: false,
            decoration: InputDecoration(
              labelText: "Message Visitor",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 10,
          ),
        ],
      ),
    );
  }
}
