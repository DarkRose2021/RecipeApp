import 'package:flutter/material.dart';
import 'package:recipe_app/common/app-bar.dart';
import 'package:recipe_app/common/bottom-nav.dart';
import 'package:recipe_app/common/drawer.dart';
import 'package:recipe_app/common/recipe-card.dart';
import 'package:recipe_app/theme.dart';
enum AccountItems { profile, settings, logout }

class SavedRecipes extends StatefulWidget {
  const SavedRecipes({Key? key}) : super(key: key);

  @override
  State<SavedRecipes> createState() => _SavedRecipes();
}

class _SavedRecipes extends State<SavedRecipes> {
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
        appBar: bar('Saved Recipes', profileButton()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
              recipeCard('assets/images/tempRecipeImg.jpg', 'Recipe'),
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
