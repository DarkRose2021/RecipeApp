import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_app/common/bottom-nav.dart';
import 'package:recipe_app/common/divider.dart';
import 'package:recipe_app/common/drawer.dart';
import 'package:recipe_app/pages/search_recipes.dart';
import 'package:recipe_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AccountItems { profile, settings, logout }

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadDarkModePreference();
  }

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
        appBar: AppBar(
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
                    ),
                  ),
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
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        children: const [
                          TextSpan(text: 'Welcome back, '),
                          TextSpan(
                              text: '[Name]',
                              style: TextStyle(color: Colors.teal)),
                          TextSpan(text: '!'),
                        ]),
                  ),
                ),
              ),
              hr(isDarkMode),
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
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                                "This action currently doesn't do anything"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isDarkMode
                                ? Colors.grey.shade900
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: isDarkMode
                                    ? Colors.grey.shade800.withOpacity(0.5)
                                    : Colors.grey.withOpacity(0.5),
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
                  gradient: LinearGradient(
                      colors: isDarkMode
                          ? [
                              const Color(0xFF015C53),
                              const Color(0xFF009688),
                            ]
                          : [
                              const Color(0xFF009688),
                              const Color(0xFF80CBC4),
                            ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
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
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    "This action currently doesn't do anything"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
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
              hr(isDarkMode),
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
              // SizedBox(
              //   height: 500,
              //   width: 390,
              //   child: Column(
              //     children: List.generate(
              //       3,
              //       (index) {
              //         return recipeCard(context, 644848, 'assets/images/tempRecipeImg.jpg',
              //             'Pepperoni Grilled Cheese');
              //       },
              //     ),
              //   ),
              // ),
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
                        backgroundColor: isDarkMode
                            ? MaterialStateProperty.all<Color>(
                                Colors.grey.shade900)
                            : MaterialStateProperty.all(
                                const Color(0xFFEEEEEE)),
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
      theme: isDarkMode ? darkTheme : lightTheme,
    );
  }
}
