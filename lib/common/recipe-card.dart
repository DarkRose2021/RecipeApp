import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/pages/view_recipe.dart';

GestureDetector recipeCard(dynamic context, int recipeId, String imagePath,
    String name, bool darkMode) {
  int randomNum = Random().nextInt(5) + 1;
  return GestureDetector(
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Recipe(
            id: recipeId,
            isDarkMode: darkMode,
          ),
        ),
      )
    },
    child: Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(0),
      height: 150,
      width: 390,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: darkMode ? Colors.grey.shade900 : Colors.grey.shade800),
        color: darkMode ? Colors.grey.shade900 : Colors.white,
        boxShadow: [
          BoxShadow(
            color: darkMode
                ? Colors.grey.shade800.withOpacity(0.5)
                : Colors.grey.withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            child: Image.network(
              imagePath,
              width: 390,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 15,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nexus',
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        'Difficulty (Random): ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nexus',
                          color: darkMode ? Colors.grey.shade300 : Colors.black,
                        ),
                      ),
                    ),
                    // Generate filled or unfilled fork icons based on randomNum
                    for (int i = 0; i < 5; i++)
                      SvgPicture.asset(
                        i < randomNum
                            ? 'assets/icons/forkFilled.svg'
                            : 'assets/icons/fork.svg',
                        width: 30.0,
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
