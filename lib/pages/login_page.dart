import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:fluter_article_app/pages/home_page.dart';
import 'package:fluter_article_app/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class HeadClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var txtEditEmail = TextEditingController();
  var txtEditPasswd = TextEditingController();

  Widget inputEmail() {
    return TextFormField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? 'Masukan email yang valid'
          : null,
      controller: txtEditEmail,
      onSaved: (String? val) {
        txtEditEmail.text = val!;
      },
      decoration: InputDecoration(
        hintText: 'example@mail.com',
        hintStyle: const TextStyle(color: Colors.black),
        labelText: 'Masukan email',
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: Colors.black,
        ),
        fillColor: Colors.black,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.black),
    );
  }

  Widget inputPassword() {
    return TextFormField(
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: true,
      validator: (String? args) {
        if (args == null || args.isEmpty) {
          return 'Password harus diisi';
        } else {
          return null;
        }
      },
      controller: txtEditPasswd,
      onSaved: (String? val) {
        txtEditPasswd.text = val!;
      },
      decoration: InputDecoration(
        hintText: 'Masukan password',
        hintStyle: const TextStyle(color: Colors.black),
        labelText: 'Masukan password',
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Colors.black,
        ),
        fillColor: Colors.black,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.black),
    );
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      doLogin(txtEditEmail.text, txtEditPasswd.text);
    }
  }

  doLogin(email, password) async {
    final GlobalKey<State> keyLoader = GlobalKey<State>();
    Dialogs.loading(context, keyLoader, 'Proses...');

    try {
      final response = await http.post(
          Uri.parse("https://api.sobatcoding.com/testing/login"),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            "email": email,
            "password": password,
          }));

      final output = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.of(keyLoader.currentContext!, rootNavigator: false).pop();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            output['message'],
            style: const TextStyle(fontSize: 16),
          )),
        );

        if (output['success'] == true) {
          saveSession(email);
        }
        //debugPrint(output['message']);
      } else {
        Navigator.of(keyLoader.currentContext!, rootNavigator: false).pop();
        //debugPrint(output['message']);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            output.toString(),
            style: const TextStyle(fontSize: 16),
          )),
        );
      }
    } catch (e) {
      Navigator.of(keyLoader.currentContext!, rootNavigator: false).pop();
      Dialogs.popUp(context, '$e');
      debugPrint('$e');
    }
  }

  saveSession(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("email", email);
    await pref.setBool("is_login", true);

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
      ),
      (route) => false,
    );
  }

  void ceckLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");
    if (islogin != null && islogin) {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ClipPath(
                clipper: HeadClipper(),
                child: Container(
                  margin: const EdgeInsets.all(0),
                  width: double.infinity,
                  height: 230,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(161, 71, 71, 71),
                    image: DecorationImage(
                      image: AssetImage('assets/images/Saly-16.png'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text(
                  "LOGIN APP",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      inputEmail(),
                      const SizedBox(height: 20.0),
                      inputPassword(),
                      const SizedBox(height: 5.0),
                    ],
                  )),
              Container(
                padding:
                    const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 10,
                        minimumSize: const Size(200, 58)),
                    // onPressed: () => _validateInputs(),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_right_alt),
                    label: const Text(
                      "MASUK",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
