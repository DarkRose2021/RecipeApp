import 'package:flutter/material.dart';
import 'package:recipe_app/pages/search_recipes.dart';
import 'package:recipe_app/pages/home.dart';
import 'package:recipe_app/pages/saved_recipes.dart';

BottomNavigationBar appNav(int index, context) {
  return BottomNavigationBar(
    currentIndex: index,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/icons/recipe.png'),
        ),
        label: 'Saved Recipes',
      ),
    ],
    onTap: (index) => {
      if (index == 0)
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainApp()),
          )
        }
      else if (index == 1)
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AllRecipes()),
          )
        }
      else if (index == 2)
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SavedRecipes()),
          )
        }
    },
  );
}