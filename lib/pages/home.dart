import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/common/app-bar.dart';
import 'package:recipe_app/common/bottom-nav.dart';
import 'package:recipe_app/common/divider.dart';
import 'package:recipe_app/common/drawer.dart';
import 'package:recipe_app/common/recipe-card.dart';
import 'package:recipe_app/pages/all-recipes.dart';
import 'package:recipe_app/theme.dart';
enum AccountItems { profile, settings, logout }

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  Padding profileButton() {
    // ignore: unused_local_variable
    AccountItems? selectedItem;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // child: Icon(
      //   Icons.person_rounded,
      //   size: 40,
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
        appBar: bar('Recipe App', profileButton()),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: RichText(
                    text: const TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(text: 'Welcome back, '),
                          TextSpan(
                              text: '[Name]',
                              style: TextStyle(color: Colors.teal)),
                          TextSpan(text: '!'),
                        ]),
                  ),
                ),
              ),
              hr(),
              SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  physics: const ScrollPhysics(),
                  children: List.generate(
                    6,
                    (index) {
                      String imagePath = '';
                      String label = '';
                      switch (index) {
                        case 0:
                          imagePath = 'assets/icons/fastFood.svg';
                          label = 'Fast Food';
                          break;
                        case 1:
                          imagePath = 'assets/icons/fruits.svg';
                          label = 'Fruits';
                          break;
                        case 2:
                          imagePath = 'assets/icons/mainDish.svg';
                          label = 'Main Dish';
                          break;
                        case 3:
                          imagePath = 'assets/icons/dessert.svg';
                          label = 'Dessert';
                          break;
                        case 4:
                          imagePath = 'assets/icons/vegetable.svg';
                          label = 'Vegetables';
                          break;
                        case 5:
                          imagePath = 'assets/icons/pasta.svg';
                          label = 'Pasta';
                          break;
                      }

                      return GestureDetector(
                        onTap: () {
                          print('Box $index clicked');
                        },
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                imagePath,
                                width: 40.0,
                              ),
                              Text(
                                label,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(0),
                height: 150,
                width: 390,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                      colors: [
                        Color(0xFF009688),
                        Color(0xFF80CBC4),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1.5,
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Image.asset('assets/images/foodImg.png'),
                    const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 8, right: 20),
                        child: Text(
                          'Add your own Meal Plan',
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 20),
                        // ignore: avoid_print
                        child: ButtonTheme(
                          minWidth: 100.0,
                          child: OutlinedButton(
                            onPressed: () {
                              print('Create Meal Plan Button Clicked');
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(color: Colors.white),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                const Size(200, 40),
                              ),
                            ),
                            child: const Text('Create Meal Plan'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              hr(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8, top: 8),
                  child: Text(
                    'Popular Recipes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 500,
                width: 390,
                child: Column(
                  children: List.generate(
                    3,
                    (index) {
                      return recipeCard('assets/images/tempRecipeImg.jpg',
                          'Pepperoni Grilled Cheese');
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  // ignore: avoid_print
                  child: ButtonTheme(
                    minWidth: 100.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllRecipes()),
                        );
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.teal),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFEEEEEE)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: Colors.teal),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(390, 40),
                        ),
                      ),
                      child: const Text('View all Recipes'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: appDraw(context),
        bottomNavigationBar: appNav(0, context),
      ),
      theme: customTheme,
    );
  }
}
