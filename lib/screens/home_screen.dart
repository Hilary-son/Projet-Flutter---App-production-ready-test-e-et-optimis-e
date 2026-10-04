import 'package:flutter/material.dart';
import 'package:mes_lectures/l10n/app_localizations.dart';
import 'package:mes_lectures/navigation.dart';
import 'package:mes_lectures/providers/book_provider.dart';
import 'package:mes_lectures/screens/add_book_screen.dart';
import 'package:mes_lectures/screens/settings_screen.dart';
import 'package:mes_lectures/screens/stats_screen.dart';
import 'package:mes_lectures/widgets/book_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final books = context.select((BookProvider p) => p.books);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            key: const Key('stats_button'),
            tooltip: l10n.stats,
            icon: const Icon(Icons.bar_chart),
            onPressed: () => openScreen(context, const StatsScreen()),
          ),
          IconButton(
            key: const Key('settings_button'),
            tooltip: l10n.settings,
            icon: const Icon(Icons.settings),
            onPressed: () => openScreen(context, const SettingsScreen()),
          ),
        ],
      ),
      body: books.isEmpty
          ? Center(child: Text(l10n.emptyList))
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, i) => BookTile(book: books[i]),
            ),
      floatingActionButton: FloatingActionButton(
        key: const Key('add_fab'),
        tooltip: l10n.addBook,
        onPressed: () => openScreen(context, const AddBookScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
