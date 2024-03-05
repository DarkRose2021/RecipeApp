import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
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
                    obscureText: false,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                        final Color color =
                            states.contains(MaterialState.focused)
                                ? Colors.teal
                                : Colors.black;
                        return TextStyle(color: color);
                      }),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    obscureText: true,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                        final Color color =
                            states.contains(MaterialState.focused)
                                ? Colors.teal
                                : Colors.black;
                        return TextStyle(color: color);
                      }),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () => {print('Button Pressed')},
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.teal),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        minimumSize: MaterialStatePropertyAll(Size(200, 25))),
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
