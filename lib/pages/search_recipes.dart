import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/common/bottom-nav.dart';
import 'package:recipe_app/common/drawer.dart';
import 'package:recipe_app/common/recipe_card.dart';
import 'package:recipe_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllRecipes extends StatefulWidget {
  const AllRecipes({super.key});

  @override
  State<AllRecipes> createState() => _AllRecipes();
}

enum AccountItems { profile, settings, logout }

class _AllRecipes extends State<AllRecipes> {
  bool isDarkMode = false;
  bool error = false;

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

  String query = '';
  TextEditingController searchController = TextEditingController();
  Map<String, dynamic> recipeData = {};

  Future<void> _searchRecipes(String? query) async {
    await dotenv.load();

    final String accessToken = dotenv.env['API_KEY'] ?? '';
    Uri uri;

    if (query != null && query.isNotEmpty) {
      uri = Uri.parse(
          'https://api.spoonacular.com/recipes/findByIngredients?ingredients=$query');
    } else {
      uri = Uri.parse('https://api.spoonacular.com/recipes/random?number=10');
    }

    final Map<String, String> headers = {
      'x-api-key': accessToken,
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        recipeData = parseRecipeData(response.body);
      });
    } else {
      print('Failed to fetch recipe data. Status code: ${response.statusCode}');
      error = true;
    }
  }

  Map<String, dynamic> parseRecipeData(String responseBody) {
    try {
      final dynamic decoded = json.decode(responseBody);

      if (decoded is List) {
        return {'recipes': decoded};
      } else if (decoded is Map<String, dynamic>) {
        return decoded;
      } else {
        print('Unexpected response format: $decoded');
        error = true;
        return {};
      }
    } catch (e) {
      print('Error parsing recipe data: $e');
      error = true;
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    loadDarkModePreference();
    _searchRecipes(null);
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 5, right: 5),
                child: SearchBar(
                  hintText: 'Search Recipes',
                  controller: searchController,
                  leading: Icon(
                    Icons.search,
                    color: isDarkMode ? Colors.grey : Colors.black,
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      query = value;
                    });
                    _searchRecipes(query);
                  },
                ),
              ),
              recipeData.isEmpty
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    )
                  : (recipeData['recipes'] == null ||
                          !(recipeData['recipes'] is List))
                      ? const Column(
                          children: [
                            Text(
                              'Error loading data. Please try again later',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            )
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (recipeData['recipes'] as List).length,
                          itemBuilder: (context, index) {
                            final recipe = recipeData['recipes'][index];
                            if (recipe != null &&
                                recipe['title'] != null &&
                                recipe['image'] != null) {
                              return recipeCard(
                                context,
                                recipe['id'],
                                recipe['image'],
                                recipe['title'],
                                isDarkMode,
                              );
                            } else {
                              return const Text('Error loading recipe');
                            }
                          },
                        ),
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
