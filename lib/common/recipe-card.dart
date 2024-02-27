import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nexus',
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'Difficulty (Random): ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nexus',
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/forkFilled.svg',
                    width: 30.0,
                  ),
                  SvgPicture.asset(
                    'assets/icons/forkFilled.svg',
                    width: 30.0,
                  ),
                  SvgPicture.asset(
                    'assets/icons/fork.svg',
                    width: 30.0,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
