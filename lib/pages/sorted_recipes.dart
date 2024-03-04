import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/common/bottom-nav.dart';
import 'package:recipe_app/common/drawer.dart';
import 'package:recipe_app/common/recipe-card.dart';
import 'package:recipe_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchRecipes extends StatefulWidget {
  const SearchRecipes({super.key});

  @override
  State<SearchRecipes> createState() => _SearchRecipes();
}

enum AccountItems { profile, settings, logout }

class _SearchRecipes extends State<SearchRecipes> {
  bool isDarkMode = false;

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
    Uri uri = Uri.parse('https://api.spoonacular.com/recipes/random?number=10');

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
      final dynamic decoded = json.decode(responseBody);

      if (decoded is List) {
        return {'recipes': decoded};
      } else if (decoded is Map<String, dynamic>) {
        return decoded;
      } else {
        print('Unexpected response format: $decoded');
        return {};
      }
    } catch (e) {
      print('Error parsing recipe data: $e');
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    loadDarkModePreference();
    _searchRecipes(null);
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
              recipeData.isEmpty
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: CircularProgressIndicator(
                          color: Colors.teal,
                        )),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipeData['recipes'].length,
                      itemBuilder: (context, index) {
                        return recipeCard(
                            context,
                            recipeData['recipes'][index]['id'],
                            recipeData['recipes'][index]['image'],
                            recipeData['recipes'][index]['title'],
                            isDarkMode);
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
