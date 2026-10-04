import 'package:flutter_test/flutter_test.dart';
import 'package:mes_lectures/data/book_repository.dart';
import 'package:mes_lectures/models/book.dart';
import 'package:mes_lectures/providers/book_provider.dart';

void main() {
  late InMemoryBookRepository repository;
  late BookProvider provider;

  setUp(() {
    repository = InMemoryBookRepository();
    provider = BookProvider(repository);
  });

  Future<String> addDune() async {
    await provider.add(title: 'Dune', author: 'Herbert', totalPages: 100);
    return provider.books.last.id;
  }

  test('la liste est vide au départ', () {
    expect(provider.books, isEmpty);
  });

  test('add ajoute un livre', () async {
    await addDune();
    expect(provider.books, hasLength(1));
    expect(provider.books.first.title, 'Dune');
  });

  test('add sauvegarde dans le repository', () async {
    await addDune();
    expect(await repository.load(), hasLength(1));
  });

  test('updateProgress met à jour la page courante', () async {
    final id = await addDune();
    await provider.updateProgress(id, 40);
    expect(provider.byId(id)!.currentPage, 40);
  });

  test('updateProgress ne dépasse pas le nombre de pages', () async {
    final id = await addDune();
    await provider.updateProgress(id, 500);
    expect(provider.byId(id)!.currentPage, 100);
  });

  test('remove supprime le livre', () async {
    final id = await addDune();
    await provider.remove(id);
    expect(provider.books, isEmpty);
  });

  test('finishedCount compte les livres terminés', () async {
    final id = await addDune();
    await provider.add(title: 'B', author: 'X', totalPages: 10);
    await provider.updateProgress(id, 100);
    expect(provider.finishedCount, 1);
  });

  test('pagesRead additionne les pages lues', () async {
    final id = await addDune();
    await provider.add(title: 'B', author: 'X', totalPages: 10);
    await provider.updateProgress(id, 30);
    await provider.updateProgress(provider.books.last.id, 5);
    expect(provider.pagesRead, 35);
  });

  test('init charge les livres déjà enregistrés', () async {
    const saved = Book(id: 'a', title: 'T', author: 'A', totalPages: 10);
    final p = BookProvider(InMemoryBookRepository([saved]));
    await p.init();
    expect(p.books.single.id, 'a');
  });
}
