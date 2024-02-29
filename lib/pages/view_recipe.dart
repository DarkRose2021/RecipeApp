import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Recipe extends StatefulWidget {
  const Recipe({super.key, required this.id});
  final int id;
  @override
  State<Recipe> createState() => _Recipe();
}

Padding dishTypes(String type) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: const Color(0xFF80CBC4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
      ),
      child: Text(type),
    ),
  );
}

class _Recipe extends State<Recipe> {
  RegExp exp = RegExp(r'(?<=<li>).+?(?=</li>)');
  List<String?> instructionsList = [];
  Map<String, dynamic> recipeData = {};

  Future<void> fetchRecipeData() async {
    await dotenv.load();

    final String accessToken = dotenv.env['API_KEY'] ?? '';
    final Uri uri = Uri.parse(
        'https://api.spoonacular.com/recipes/${widget.id}/information');
    final Map<String, String> headers = {
      'x-api-key': accessToken,
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        recipeData = parseRecipeData(response.body);
        Iterable<RegExpMatch> matches =
            exp.allMatches(recipeData['instructions']);
        instructionsList = matches.map((match) => match[0]).toList();
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 55, right: 10, left: 10, bottom: 10),
            child: recipeData.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BackButton(
                        onPressed: () => Navigator.pop(context),
                        color: Colors.black,
                      ),
                      const Center(
                        child: Text(
                          'Error loading recipe data.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: BackButton(
                          onPressed: () => Navigator.pop(context),
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 10),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                width: 190,
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(15)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        48), // Image radius
                                    child: Image.network(
                                      recipeData['image'] ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  recipeData['title'] ?? '',
                                  style: const TextStyle(
                                    fontFamily: 'Nexus',
                                    fontSize: 30,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              for (var dishType
                                  in (recipeData['dishTypes'] ?? []))
                                dishTypes(dishType.toString()),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ingredients',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Nexus',
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          for (var ingredient
                              in (recipeData['extendedIngredients'] ?? []))
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  ingredient['original'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nexus',
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Directions',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Nexus',
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: instructionsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                instructionsList[index] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Nexus',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
