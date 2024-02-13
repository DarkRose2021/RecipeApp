import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      home: Splash2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const MainApp(),
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

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const profileButton =  Padding(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        Icons.person_rounded,
        size: 40,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Recipe App'),
          actions: const [profileButton],
        ),
        body: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8, top: 8),
                child: Text(
                  'Promo Recipe',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  4,
                  (index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(0),
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1.5,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/tempRecipeImg.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 500,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Pepperoni Grilled Cheese',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
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
                                color: Colors.black,
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
                      Color.fromRGBO(0, 150, 136, 1),
                      Color.fromRGBO(128, 203, 196, 1),
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
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
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
          ],
        ),
        drawer: Drawer(
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
                  print('Favorites Clicked');
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_circle_rounded),
                title: const Text('Add Recipe'),
                onTap: () {
                  print('Add Recipe Clicked');
                },
              ),
              ListTile(
                leading: const Icon(Icons.bookmark),
                title: const Text('Saved Recipes'),
                onTap: () {
                  print('Saved Recipes Clicked');
                },
              ),
              ListTile(
                leading: const ImageIcon(
                  AssetImage('assets/icons/recipe.png'),
                ),
                title: const Text('Your Recipes'),
                onTap: () {
                  print('Your Recipes Clicked');
                },
              ),
              ListTile(
                title: const Text('Your Meal Plans'),
                onTap: () {
                  print('Meal Plans Clicked');
                },
              ),
              ListTile(
                title: const Text('Create Meal Plans'),
                onTap: () {
                  print('Create Meal Plans Clicked');
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart_outlined),
                title: const Text('Shopping Lists'),
                onTap: () {
                  print('Shopping Lists Clicked');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  print('Settings Clicked');
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
        ),
      ),
      theme: customTheme,
    );
  }
}
