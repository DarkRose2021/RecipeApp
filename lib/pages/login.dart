import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/common/dialouge-box.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_app/pages/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  static const String backendUrl = 'http://192.168.1.8:5050/login';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to handle login
  Future<void> login() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final Map<String, String> body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body), 
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData.user.name);

        final String userName = responseData['name']; // Adjust if key is different
        await saveUserName(userName);

        // Navigate to the main app screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainApp()),
        );
      } else {
        final responseData = json.decode(response.body);
        showErrorDialog(context, 'Error ${response.statusCode}', responseData['message']);
      }
    } catch (e) {
      showErrorDialog(context, 'Error but success', 'An error occurred: $e');
    }
  }

  // Function to save user name
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
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
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
                    onPressed: login,
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.teal),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      minimumSize: WidgetStatePropertyAll(Size(200, 25)),
                    ),
                    child: const Text(
                      'Login',
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
