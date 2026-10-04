import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mes_lectures/l10n/app_localizations.dart';
import 'package:mes_lectures/models/book.dart';
import 'package:mes_lectures/navigation.dart';
import 'package:mes_lectures/screens/detail_screen.dart';

class BookTile extends StatelessWidget {
  const BookTile({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      key: Key('book_${book.id}'),
      leading: _Cover(url: book.coverUrl),
      title: Text(book.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(book.author),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: book.progress,
            semanticsLabel:
                l10n.pagesProgress(book.currentPage, book.totalPages),
          ),
        ],
      ),
      onTap: () => openScreen(context, DetailScreen(bookId: book.id)),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    return SizedBox(
      width: 40,
      height: 56,
      child: url == null
          ? const Icon(Icons.menu_book, size: 32)
          : ClipRRect(
              borderRadius: BorderRadius.circular(4),
              // Image mise en cache, chargée seulement quand la ligne est
              // affichée, et décodée en petit pour économiser la mémoire.
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                memCacheWidth: 120,
                placeholder: (_, __) => const ColoredBox(color: Colors.black12),
                errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
    );
  }
}
