import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProvider with ChangeNotifier {
  int _themeIndex = 0;

  int get themeIndex => _themeIndex;

  setTheme(int value) {
    _themeIndex = value;
    notifyListeners();
  }
}

final themeProvider =
    ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());
