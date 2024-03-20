import 'package:flutter/material.dart';

class CustomStyles {
  static TextStyle blackAndBoldTextStyleM = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15);

  static TextStyle blackAndBoldTextStyleL = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  static TextStyle blackTextStyleS = const TextStyle(
    color: Colors.black,
    fontSize: 15.0,
  );

  static TextStyle blackAndBoldTextStyleXl = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24);


  static TextStyle blackAndBoldTextStyleXXl = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 48);

  static final ButtonStyle customButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.white,
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
    ),
  );

  static final ButtonStyle customMenuItemButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
    ),
  );

  static final ButtonStyle transparentButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.transparent,
    padding: const EdgeInsets.all(16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
