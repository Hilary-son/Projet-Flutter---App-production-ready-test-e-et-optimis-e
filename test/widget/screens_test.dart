import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mes_lectures/app.dart';
import 'package:mes_lectures/data/book_repository.dart';
import 'package:mes_lectures/providers/book_provider.dart';
import 'package:mes_lectures/screens/add_book_screen.dart';
import 'package:mes_lectures/screens/detail_screen.dart';
import 'package:mes_lectures/screens/home_screen.dart';

import 'helpers.dart';

void main() {
  late BookProvider provider;

  setUp(() => provider = BookProvider(InMemoryBookRepository()));

  testWidgets('l\'accueil vide affiche le message en anglais', (tester) async {
    await tester.pumpWidget(wrapScreen(const HomeScreen(), provider));
    expect(find.text('No books yet. Add your first one!'), findsOneWidget);
  });

  testWidgets('l\'accueil vide affiche le message en français', (tester) async {
    await tester.pumpWidget(
      wrapScreen(const HomeScreen(), provider, locale: const Locale('fr')),
    );
    expect(find.text('Mes lectures'), findsOneWidget);
    expect(find.textContaining('Aucun livre'), findsOneWidget);
  });

  testWidgets('le formulaire refuse les champs vides', (tester) async {
    await tester.pumpWidget(wrapScreen(const AddBookScreen(), provider));
    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pump();
    expect(find.text('This field is required'), findsNWidgets(2));
    expect(find.text('Enter a number greater than 0'), findsOneWidget);
    expect(provider.books, isEmpty);
  });

  testWidgets('l\'écran détail affiche la progression', (tester) async {
    await provider.add(title: 'Dune', author: 'Herbert', totalPages: 200);
    final id = provider.books.first.id;
    await provider.updateProgress(id, 50);

    await tester.pumpWidget(wrapScreen(DetailScreen(bookId: id), provider));
    expect(find.text('Dune'), findsOneWidget);
    expect(find.text('50 / 200 pages'), findsOneWidget);
  });

  testWidgets('changer de langue met à jour l\'app', (tester) async {
    await tester.pumpWidget(MyReadsApp(repository: InMemoryBookRepository()));
    await tester.pumpAndSettle();
    expect(find.text('My Reads'), findsOneWidget);

    await tester.tap(find.byKey(const Key('settings_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('lang_fr')));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Mes lectures'), findsOneWidget);
  });

  testWidgets('ajouter un livre depuis le formulaire l\'affiche dans la liste',
      (tester) async {
    await tester.pumpWidget(MyReadsApp(repository: InMemoryBookRepository()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('add_fab')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('title_field')), 'Dune');
    await tester.enterText(find.byKey(const Key('author_field')), 'Herbert');
    await tester.enterText(find.byKey(const Key('pages_field')), '300');
    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pumpAndSettle();

    expect(find.text('Dune'), findsOneWidget);
    expect(find.text('Herbert'), findsOneWidget);
  });
}
