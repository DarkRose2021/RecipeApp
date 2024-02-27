import 'package:flutter/material.dart';
import 'package:recipe_app/common/app-bar.dart';
import 'package:recipe_app/common/bottom-nav.dart';
import 'package:recipe_app/common/drawer.dart';
import 'package:recipe_app/common/recipe-card.dart';
import 'package:recipe_app/theme.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _Recipe();
}

class _Recipe extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 10),
                      child: Image.asset(
                        'assets/images/tempRecipeImg.jpg',
                        width: 180,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '[Recipe Name]',
                        style: TextStyle(
                          fontFamily: 'Nexus',
                          fontSize: 30,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ingredients:',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nexus',
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Directions:',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nexus',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
