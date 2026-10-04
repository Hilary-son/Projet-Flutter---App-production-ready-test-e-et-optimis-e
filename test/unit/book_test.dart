import 'package:flutter_test/flutter_test.dart';
import 'package:mes_lectures/models/book.dart';

void main() {
  const book = Book(
    id: '1',
    title: 'Dune',
    author: 'Frank Herbert',
    totalPages: 200,
    currentPage: 50,
  );

  test('progress vaut la fraction de pages lues', () {
    expect(book.progress, 0.25);
  });

  test('un livre est terminé quand toutes les pages sont lues', () {
    expect(book.isFinished, isFalse);
    expect(book.copyWith(currentPage: 200).isFinished, isTrue);
  });

  test('toJson puis fromJson redonne le même livre', () {
    final copy = Book.fromJson(book.toJson());
    expect(copy.id, book.id);
    expect(copy.title, book.title);
    expect(copy.author, book.author);
    expect(copy.totalPages, book.totalPages);
    expect(copy.currentPage, book.currentPage);
  });
}
