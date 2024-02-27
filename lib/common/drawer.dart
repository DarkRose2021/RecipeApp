import 'package:flutter/material.dart';
import 'package:recipe_app/pages/saved-recipes.dart';

Drawer appDraw(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF009688),
                Color(0xFF80CBC4),
              ],
              stops: [0.5, 1.0],
            ),
          ),
          child: RichText(
            text: const TextSpan(
                style: TextStyle(
                  color: Colors.white,
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
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Favorites'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedRecipes()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.add_circle_rounded),
          title: const Text('Add Recipes'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedRecipes()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.bookmark),
          title: const Text('Saved Recipes'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedRecipes()),
            );
          },
        ),
        ListTile(
          leading: const ImageIcon(
            AssetImage('assets/icons/recipe.png'),
          ),
          title: const Text('Your Recipes'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedRecipes()),
            );
          },
        ),
        ListTile(
          leading: const ImageIcon(
            AssetImage('assets/icons/mealPlan.png'),
          ),
          title: const Text('Your Meal Plans'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedRecipes()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.add_circle_rounded),
          title: const Text('Create Meal Plans'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedRecipes()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.shopping_cart_outlined),
          title: const Text('Shopping Lists'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedRecipes()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SavedRecipes()),
            );
          },
        ),
      ],
    ),
  );
}
