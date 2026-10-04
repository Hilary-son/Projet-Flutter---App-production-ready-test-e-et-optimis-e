import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mes_lectures/app.dart';
import 'package:mes_lectures/data/book_repository.dart';

Future<void> addBook(WidgetTester tester, String title) async {
  await tester.tap(find.byKey(const Key('add_fab')));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key('title_field')), title);
  await tester.enterText(find.byKey(const Key('author_field')), 'Auteur');
  await tester.enterText(find.byKey(const Key('pages_field')), '120');
  await tester.tap(find.byKey(const Key('save_button')));
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('parcours : ajouter un livre puis voir les statistiques',
      (tester) async {
    await tester.pumpWidget(MyReadsApp(repository: InMemoryBookRepository()));
    await tester.pumpAndSettle();

    await addBook(tester, 'Dune');
    expect(find.text('Dune'), findsOneWidget);

    await tester.tap(find.byKey(const Key('stats_button')));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('parcours : ajouter puis supprimer un livre', (tester) async {
    await tester.pumpWidget(MyReadsApp(repository: InMemoryBookRepository()));
    await tester.pumpAndSettle();

    await addBook(tester, 'Emma');
    await tester.tap(find.text('Emma'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('delete_button')));
    await tester.pumpAndSettle();

    expect(find.text('Emma'), findsNothing);
    expect(find.text('No books yet. Add your first one!'), findsOneWidget);
  });
}
