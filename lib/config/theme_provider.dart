import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  late Box _themeBox;
  int _themeIndex = 0;

  ThemeProvider() {
    _themeBox = Hive.box('themeBox');
    _themeIndex = _themeBox.get('themeIndex', defaultValue: 0);
  }

  int get themeIndex => _themeIndex;

  setTheme(int value) {
    _themeIndex = value;
    _themeBox.put('themeIndex', value);
    notifyListeners();
  }
}

final themeProvider =
    ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());
