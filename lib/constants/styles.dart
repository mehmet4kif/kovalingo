import 'package:flutter/material.dart';

class CustomStyles {
  static TextStyle blackAndBoldTextStyleM = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15);

  static TextStyle blackAndBoldTextStyleL = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  static TextStyle whiteAndBoldTextStyleL = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static TextStyle blackTextStyleS = const TextStyle(
    color: Colors.black,
    fontSize: 24.0,
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

  static final customCircularBorderContainerStyle = BoxDecoration(
    color: Colors.grey.shade600,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 4,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  );

  static const TextStyle headerStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins',
  );

  static InputDecoration inputDecoration(
  {required String labelText, required IconData icon}) {
  return InputDecoration(
  labelText: labelText,
  contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
  icon: Icon(icon),
  border: const OutlineInputBorder(
  borderSide: BorderSide(color: Colors.teal, width: 40)),
  enabledBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(20),
  borderSide: BorderSide(color: Colors.teal.shade200, width: 1.5)),
  );
  }

  static const TextStyle buttonTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'Poppins',
  );



}
