import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(66, 187, 255, 1);
const kPrimaryLightColor = Color.fromARGB(255, 237, 237, 237);
const kBackgroundColor = Color.fromRGBO(255, 240, 239, 239);
const black = Color.fromRGBO(44, 44, 44, 1);
const double defaultPadding = 16.0;

class AppBoxShadows {
  static final boxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    spreadRadius: 0,
    blurRadius: 1,
    offset: Offset(0.9, 0.9),
  );

  // Jika Anda membutuhkan box shadow lain, tambahkan di sini
}
