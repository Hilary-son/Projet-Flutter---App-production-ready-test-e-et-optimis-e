import 'package:flutter/material.dart';
import 'package:mes_lectures/l10n/app_localizations.dart';
import 'package:mes_lectures/providers/book_provider.dart';
import 'package:mes_lectures/providers/settings_provider.dart';
import 'package:provider/provider.dart';

/// Affiche un seul écran avec les providers et les traductions.
Widget wrapScreen(
  Widget screen,
  BookProvider books, {
  Locale locale = const Locale('en'),
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: books),
      ChangeNotifierProvider(create: (_) => SettingsProvider()),
    ],
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: screen,
    ),
  );
}
