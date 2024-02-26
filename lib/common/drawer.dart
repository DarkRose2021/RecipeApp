import 'package:flutter/material.dart';
import 'package:recipe_app/pages/saved-recipes.dart';

Drawer appDraw(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.teal,
          ),
          child: Text(
            'Recipe App',
            style: TextStyle(color: Colors.white),
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
