import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/common/app-bar.dart';
import 'package:recipe_app/common/bottom-nav.dart';
import 'package:recipe_app/common/drawer.dart';
import 'package:recipe_app/common/recipe-card.dart';
import 'package:recipe_app/theme.dart';

class AllRecipes extends StatefulWidget {
  const AllRecipes({super.key});

  @override
  State<AllRecipes> createState() => _AllRecipes();
}

enum AccountItems { profile, settings, logout }

class _AllRecipes extends State<AllRecipes> {
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
        appBar: bar('All Recipes', profileButton()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
                child: SearchBar(
                  hintText: 'Search Recipes',
                  leading: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
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
              SvgPicture.asset(
                'assets/icons/recipe.png',
                width: 40.0,
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
