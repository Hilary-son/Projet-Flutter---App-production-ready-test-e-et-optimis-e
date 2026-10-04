import 'package:flutter/material.dart';
import 'package:mes_lectures/l10n/app_localizations.dart';
import 'package:mes_lectures/providers/book_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final book = context.select((BookProvider p) => p.byId(bookId));
    // Le livre vient d'être supprimé : écran vide le temps du retour.
    if (book == null) return const Scaffold();

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.author, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Text(l10n.pagesProgress(book.currentPage, book.totalPages)),
            Slider(
              key: const Key('progress_slider'),
              value: book.currentPage.toDouble(),
              max: book.totalPages.toDouble(),
              divisions: book.totalPages,
              label: '${book.currentPage}',
              semanticFormatterCallback: (v) =>
                  l10n.pagesProgress(v.round(), book.totalPages),
              onChanged: (v) => context
                  .read<BookProvider>()
                  .updateProgress(book.id, v.round()),
            ),
            const Spacer(),
            TextButton.icon(
              key: const Key('delete_button'),
              icon: const Icon(Icons.delete_outline),
              label: Text(l10n.delete),
              onPressed: () {
                final provider = context.read<BookProvider>();
                Navigator.of(context).pop();
                provider.remove(book.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
