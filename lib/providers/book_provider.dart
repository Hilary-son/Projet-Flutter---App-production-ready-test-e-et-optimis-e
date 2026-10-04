import 'package:flutter/foundation.dart';
import 'package:mes_lectures/data/book_repository.dart';
import 'package:mes_lectures/models/book.dart';

class BookProvider extends ChangeNotifier {
  BookProvider(this._repository);

  final BookRepository _repository;
  List<Book> _books = [];
  int _counter = 0;

  /// La liste n'est jamais modifiée en place : on la remplace à chaque
  /// changement, ce qui permet à `context.select` de bien détecter les updates.
  List<Book> get books => _books;

  int get finishedCount => _books.where((b) => b.isFinished).length;

  int get pagesRead => _books.fold(0, (sum, b) => sum + b.currentPage);

  Future<void> init() async {
    _books = await _repository.load();
    notifyListeners();
  }

  Book? byId(String id) {
    for (final book in _books) {
      if (book.id == id) return book;
    }
    return null;
  }

  Future<void> add({
    required String title,
    required String author,
    required int totalPages,
    String? coverUrl,
  }) async {
    final book = Book(
      id: '${DateTime.now().microsecondsSinceEpoch}-${_counter++}',
      title: title,
      author: author,
      totalPages: totalPages,
      coverUrl: coverUrl,
    );
    _books = [..._books, book];
    notifyListeners();
    await _repository.save(_books);
  }

  Future<void> updateProgress(String id, int page) async {
    final book = byId(id);
    if (book == null) return;
    final clamped = page.clamp(0, book.totalPages);
    _books = [
      for (final b in _books) b.id == id ? b.copyWith(currentPage: clamped) : b,
    ];
    notifyListeners();
    await _repository.save(_books);
  }

  Future<void> remove(String id) async {
    _books = _books.where((b) => b.id != id).toList();
    notifyListeners();
    await _repository.save(_books);
  }
}
