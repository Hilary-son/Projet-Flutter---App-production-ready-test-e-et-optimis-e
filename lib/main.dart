import 'package:flutter/material.dart';
import 'package:mes_lectures/app.dart';
import 'package:mes_lectures/data/book_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyReadsApp(repository: SharedPrefsBookRepository(prefs)));
}
