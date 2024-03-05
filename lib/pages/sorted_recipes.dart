import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/common/recipe_card.dart';
import 'package:recipe_app/theme.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SortRecipes extends StatefulWidget {
  const SortRecipes({super.key, required this.type});
  final String type;
  @override
  State<SortRecipes> createState() => _SortRecipes();
}

enum AccountItems { profile, settings, logout }

class _SortRecipes extends State<SortRecipes> {
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

  TextEditingController searchController = TextEditingController();
  Map<String, dynamic> recipeData = {};

  Future<void> _searchRecipes(String? query) async {
    await dotenv.load();

    final String accessToken = dotenv.env['API_KEY'] ?? '';
    Uri uri = Uri.parse(
        'https://api.spoonacular.com/recipes/complexSearch?query=${widget.type}&number=10');

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

      if (decoded is Map<String, dynamic> && decoded.containsKey('results')) {
        return decoded;
      } else {
        print('Unexpected response format: $decoded');
        return {'results': []};
      }
    } catch (e) {
      print('Error parsing recipe data: $e');
      return {'results': []};
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
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: isDarkMode ? Colors.white : Colors.teal,
          ),
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
                      itemCount:
                          (recipeData['results'] as List<dynamic>?)?.length ??
                              0,
                      itemBuilder: (context, index) {
                        return recipeCard(
                          context,
                          recipeData['results']?[index]['id'],
                          recipeData['results']?[index]['image'],
                          recipeData['results']?[index]['title'],
                          isDarkMode,
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      theme: isDarkMode ? darkTheme : lightTheme,
    );
  }
}
