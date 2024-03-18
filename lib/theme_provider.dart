import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isNightMode = false;

  bool get isNightMode => _isNightMode;

  void toggleNightMode() {
    _isNightMode = !_isNightMode;
    notifyListeners();
  }
}
