import 'dart:convert';

import 'package:mes_lectures/models/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BookRepository {
  Future<List<Book>> load();
  Future<void> save(List<Book> books);
}

/// Stockage réel : les livres sont sauvegardés en JSON sur le téléphone.
class SharedPrefsBookRepository implements BookRepository {
  SharedPrefsBookRepository(this._prefs);

  static const _key = 'books';
  final SharedPreferences _prefs;

  @override
  Future<List<Book>> load() async {
    final raw = _prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => Book.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> save(List<Book> books) async {
    await _prefs.setString(
      _key,
      jsonEncode(books.map((b) => b.toJson()).toList()),
    );
  }
}

/// Stockage en mémoire, pratique pour les tests.
class InMemoryBookRepository implements BookRepository {
  InMemoryBookRepository([List<Book> initial = const []])
      : _books = List.of(initial);

  List<Book> _books;

  @override
  Future<List<Book>> load() async => List.of(_books);

  @override
  Future<void> save(List<Book> books) async => _books = List.of(books);
}
