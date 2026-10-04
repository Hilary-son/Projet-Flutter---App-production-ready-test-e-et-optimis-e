import 'package:flutter/material.dart';
import 'package:mes_lectures/data/book_repository.dart';
import 'package:mes_lectures/l10n/app_localizations.dart';
import 'package:mes_lectures/providers/book_provider.dart';
import 'package:mes_lectures/providers/settings_provider.dart';
import 'package:mes_lectures/screens/home_screen.dart';
import 'package:provider/provider.dart';

class MyReadsApp extends StatelessWidget {
  const MyReadsApp({super.key, required this.repository});

  final BookRepository repository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider(repository)..init()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final locale = context.select((SettingsProvider s) => s.locale);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
