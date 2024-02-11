import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const profileButton = Icon(
      Icons.person_rounded,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Recipe App"),
          actions: const [profileButton],
        ),
        body: ListView(
          children: <Widget>[
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              physics: const ScrollPhysics(),
              children: List.generate(
                6,
                (index) {
                  String imagePath = 'assets/images/recipe.png';
                  switch (index) {
                    case 0:
                      imagePath = 'assets/images/burger.png';
                      const Text("Fast Food");
                      break;
                    case 1:
                      imagePath = 'assets/images/save.png';
                      break;
                    case 2:
                      imagePath = 'assets/images/heart_outline.png';
                      break;
                    case 3:
                      imagePath = 'assets/images/heart_outline.png';
                      break;
                    case 4:
                      imagePath = 'assets/images/heart_outline.png';
                      break;
                    case 5:
                      imagePath = 'assets/images/heart_outline.png';
                      break;
                  }

                  return GestureDetector(
                      onTap: () {
                        print('Box $index clicked');
                      },
                      child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: ImageIcon(
                              AssetImage(
                                  imagePath),
                              size: 70,
                              color: Colors.black,
                            ),
                          )));
                },
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
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
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
                AssetImage("assets/images/recipes.png"),
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
