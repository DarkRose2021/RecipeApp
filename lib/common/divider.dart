import 'package:flutter/material.dart';

Divider hr(bool darkMode) {
  return Divider(
    height: 20,
    thickness: 3,
    color: darkMode? const Color(0xFF286B64): const Color(0xFFADD3CF),
  );
}
