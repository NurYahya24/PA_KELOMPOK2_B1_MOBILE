import 'package:flutter/material.dart';

class Tema extends ChangeNotifier {
  ThemeMode _tema = ThemeMode.light;
  ThemeMode get modeTema => _tema;
  bool get DarkMode => _tema == ThemeMode.dark;
  void gantiTema(ThemeMode modeTema) {
    _tema = modeTema;
    notifyListeners();
  }
}
