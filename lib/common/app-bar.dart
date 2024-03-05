import 'package:flutter/material.dart';

AppBar bar(String title, profileBtn) {
  return 
  AppBar(
    centerTitle: true,
    title: Text(title),
    actions: [profileBtn],
    
  );
}
