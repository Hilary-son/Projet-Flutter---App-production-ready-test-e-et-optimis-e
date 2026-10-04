import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  Locale? _locale;

  /// null = on suit la langue du téléphone.
  Locale? get locale => _locale;

  void setLocale(Locale? locale) {
    _locale = locale;
    notifyListeners();
  }
}
