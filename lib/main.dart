import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(const MyApp());
}

enum AccountItems { profile, settings, logout }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Splash Screen',
      home: Splash2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const Login(),
      duration: 3000,
      imageSize: 130,
      imageSrc: 'assets/images/logo.png',
      text: 'Recipe App',
      textType: TextType.TyperAnimatedText,
      textStyle: const TextStyle(
        fontSize: 30.0,
        color: Colors.white,
      ),
      backgroundColor: Colors.teal,
    );
  }
}

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

AppBar bar(String title, profileBtn) {
  return AppBar(
    centerTitle: true,
    title: Text(title),
    actions: [profileBtn],
  );
}

Divider hr() {
  return const Divider(
    height: 20,
    thickness: 3,
    color: Color(0xFFADD3CF),
  );
}

Container recipeCard(String imagePath, String name) {
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(0),
    height: 150,
    width: 390,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
      color: Colors.white,
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
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
          child: Image.asset(
            imagePath,
            width: 390,
            height: 65,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 15,
          bottom: 35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(),
              const Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/icons/forkFilled.png'),
                  ),
                  ImageIcon(
                    AssetImage('assets/icons/fork.png'),
                  ),
                  ImageIcon(
                    AssetImage('assets/icons/fork.png'),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainApp();
}

class AllRecipes extends StatefulWidget {
  const AllRecipes({Key? key}) : super(key: key);

  @override
  State<AllRecipes> createState() => _AllRecipes();
}

class SavedRecipes extends StatefulWidget {
  const SavedRecipes({Key? key}) : super(key: key);

  @override
  State<SavedRecipes> createState() => _SavedRecipes();
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _MainApp extends State<MainApp> {
  Padding profileButton() {
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

class _AllRecipes extends State<AllRecipes> {
  Padding profileButton() {
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
              const ImageIcon(AssetImage('assets/icons/recipe.png')),
              const ImageIcon(AssetImage('assets/icons/recipe.png')),
              const ImageIcon(AssetImage('assets/icons/recipe.png')),
              const ImageIcon(AssetImage('assets/icons/recipe.png')),
              const ImageIcon(AssetImage('assets/icons/recipe.png')),
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

class _SavedRecipes extends State<SavedRecipes> {
  Padding profileButton() {
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

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 150, left: 10, right: 10),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    obscureText: false,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                        final Color color =
                            states.contains(MaterialState.focused)
                                ? Colors.teal
                                : Colors.black;
                        return TextStyle(color: color);
                      }),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    obscureText: true,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                        final Color color =
                            states.contains(MaterialState.focused)
                                ? Colors.teal
                                : Colors.black;
                        return TextStyle(color: color);
                      }),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () => {print('Button Pressed')},
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.teal),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        minimumSize: MaterialStatePropertyAll(Size(200, 25))),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
