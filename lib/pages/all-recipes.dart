import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/common/app-bar.dart';
import 'package:recipe_app/common/bottom-nav.dart';
import 'package:recipe_app/common/drawer.dart';
import 'package:recipe_app/common/recipe-card.dart';
import 'package:recipe_app/theme.dart';
import 'package:http/http.dart' as http;

class AllRecipes extends StatefulWidget {
  const AllRecipes({super.key});

  @override
  State<AllRecipes> createState() => _AllRecipes();
}

enum AccountItems { profile, settings, logout }

class _AllRecipes extends State<AllRecipes> {
  String query = '';
  TextEditingController searchController = TextEditingController();
  Map<String, dynamic> recipeData = {};

  Future<void> fetchRecipeData() async {
    await dotenv.load();

    final String accessToken = dotenv.env['API_KEY'] ?? '';
    final Uri uri =
        Uri.parse('https://api.spoonacular.com/recipes/random?number=10');
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
    }
  }

  Map<String, dynamic> parseRecipeData(String responseBody) {
    try {
      return json.decode(responseBody);
    } catch (e) {
      print('Error parsing recipe data: $e');
      return {}; // Return an empty map in case of parsing error
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecipeData();
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
    print('built');
    // print(recipeData);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: bar('All Recipes', profileButton()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 5, right: 5),
                child: SearchBar(
                    hintText: 'Search Recipes',
                    controller: searchController,
                    leading: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    }),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recipeData['recipes'].length,
                itemBuilder: (context, index) {
                  return recipeCard(
                    context,
                    recipeData['recipes'][index]['id'],
                    recipeData['recipes'][index]['image'],
                    recipeData['recipes'][index]['title'],
                  );
                },
              ),
            ],
          ),
        ),
        drawer: appDraw(context),
        bottomNavigationBar: appNav(1, context),
      ),
      theme: customTheme,
    );
  }
}
