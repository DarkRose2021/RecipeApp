import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/common/dialouge-box.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_app/pages/home.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _Signup();
}

class _Signup extends State<Signup> {
  static const String backendUrl = 'http://192.168.1.8:5050/signup';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future<void> signup() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String name = nameController.text;

    final Map<String, String> body = {
      'email': email,
      'password': password,
      'name': name,
    };

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body), 
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);

        final String userName = responseData['user']['name'];
        print(userName);
        await saveUserName(userName);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainApp()),
        );
      } else {
        final responseData = json.decode(response.body);
        showErrorDialog(context, 'Error ${response.statusCode}', responseData['message']);
      }
    } catch (e) {
      showErrorDialog(context, 'Error', 'An error occurred: $e');
    }
  }

  Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 150, left: 10, right: 10),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                ),
                const Text(
                  'Signup',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: nameController,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: emailController,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: signup,
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.teal),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      minimumSize: WidgetStatePropertyAll(Size(200, 25)),
                    ),
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
