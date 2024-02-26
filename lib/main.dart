import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Splash Screen',
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/logo.png'),
      title: const Text(
        'Recipe App',
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundImage: const AssetImage('assets/images/light-background.png'),
      showLoader: true,
      loadingText: const Text(
        'Loading...',
        style: TextStyle(color: Colors.white),
      ),
      navigator: const MainApp(),
      durationInSeconds: 5,
    );
  }
}
