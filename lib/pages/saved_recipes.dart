import 'package:flutter/material.dart';
import 'package:recipe_app/common/bottom-nav.dart';
import 'package:recipe_app/common/drawer.dart';
import 'package:recipe_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AccountItems { profile, settings, logout }

class SavedRecipes extends StatefulWidget {
  const SavedRecipes({super.key});

  @override
  State<SavedRecipes> createState() => _SavedRecipes();
}

class _SavedRecipes extends State<SavedRecipes> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadDarkModePreference();
  }

  void loadDarkModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  void saveDarkModePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  Padding profileButton() {
    // ignore: unused_local_variable
    AccountItems? selectedItem;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MenuAnchor(
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(
              Icons.person_rounded,
              size: 40,
            ),
            tooltip: 'Show menu',
          );
        },
        menuChildren: List<MenuItemButton>.generate(
          3,
          (index) {
            dynamic onPress = '';
            String label = '';
            switch (index) {
              case 0:
                onPress = () =>
                    setState(() => selectedItem = AccountItems.values[index]);
                label = 'Profile';
                break;
              case 1:
                onPress = () =>
                    setState(() => selectedItem = AccountItems.values[index]);
                label = 'Settings';
                break;
              case 2:
                onPress = () =>
                    setState(() => selectedItem = AccountItems.values[index]);
                label = 'Logout';
                break;
            }

            return MenuItemButton(
              onPressed: onPress,
              child: Text(label),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: RichText(
            text: const TextSpan(
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 32,
                  fontFamily: 'Nexus',
                ),
                children: [
                  TextSpan(
                      text: 'Neu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                    text: 'Foods',
                  ),
                ]),
          ),
          actions: [
            // profileButton(),
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
                saveDarkModePreference(value);
              },
              activeColor: Colors.teal,
            ),
          ],
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Page is currently a work in progress',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              )
            ],
          ),
        ),
        drawer: appDraw(context),
        bottomNavigationBar: appNav(1, context),
      ),
      theme: isDarkMode ? darkTheme : lightTheme,
    );
  }
}
