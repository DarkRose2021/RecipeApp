import 'package:flutter/material.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _Recipe();
}

Padding dishTypes(String type) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
      ),
      child: Text(type),
    ),
  );
}

class _Recipe extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 10),
                      child: Image.asset(
                        'assets/images/tempRecipeImg.jpg',
                        width: 180,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '[Recipe Name]',
                        style: TextStyle(
                          fontFamily: 'Nexus',
                          fontSize: 30,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => dishTypes('test'),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ingredients:',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nexus',
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Directions:',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nexus',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
