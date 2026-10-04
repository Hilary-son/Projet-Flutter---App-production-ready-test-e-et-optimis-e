import 'package:flutter/material.dart';
import 'package:mes_lectures/l10n/app_localizations.dart';
import 'package:mes_lectures/providers/book_provider.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final provider = context.watch<BookProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.stats)),
      body: ListView(
        children: [
          ListTile(
            title: Text(l10n.totalBooks),
            trailing: Text('${provider.books.length}'),
          ),
          ListTile(
            title: Text(l10n.finishedBooks),
            trailing: Text('${provider.finishedCount}'),
          ),
          ListTile(
            title: Text(l10n.pagesRead),
            trailing: Text('${provider.pagesRead}'),
          ),
        ],
      ),
    );
  }
}
