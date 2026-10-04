import 'package:flutter_test/flutter_test.dart';
import 'package:mes_lectures/data/book_repository.dart';
import 'package:mes_lectures/models/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('load renvoie une liste vide quand rien n\'est sauvegardé', () async {
    final repo =
        SharedPrefsBookRepository(await SharedPreferences.getInstance());
    expect(await repo.load(), isEmpty);
  });

  test('save puis load redonne les livres', () async {
    final repo =
        SharedPrefsBookRepository(await SharedPreferences.getInstance());
    await repo.save(const [
      Book(id: '1', title: 'Dune', author: 'Herbert', totalPages: 100),
    ]);
    final loaded = await repo.load();
    expect(loaded.single.title, 'Dune');
  });
}
