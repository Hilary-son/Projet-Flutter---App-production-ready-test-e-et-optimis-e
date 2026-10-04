import 'package:flutter/material.dart';
import 'package:mes_lectures/l10n/app_localizations.dart';
import 'package:mes_lectures/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = context.watch<SettingsProvider>();
    final current = Localizations.localeOf(context).languageCode;

    Widget option(Key key, String label, String code) {
      return ListTile(
        key: key,
        title: Text(label),
        trailing: current == code ? const Icon(Icons.check) : null,
        onTap: () => settings.setLocale(Locale(code)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          option(const Key('lang_fr'), 'Français', 'fr'),
          option(const Key('lang_en'), 'English', 'en'),
        ],
      ),
    );
  }
}
