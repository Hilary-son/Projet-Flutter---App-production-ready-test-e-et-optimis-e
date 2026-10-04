// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Mes lectures';

  @override
  String get emptyList => 'Aucun livre pour l\'instant. Ajoute le premier !';

  @override
  String get addBook => 'Ajouter un livre';

  @override
  String get bookTitle => 'Titre';

  @override
  String get bookAuthor => 'Auteur';

  @override
  String get bookPages => 'Nombre de pages';

  @override
  String get bookCover => 'URL de la couverture (facultatif)';

  @override
  String get fieldRequired => 'Ce champ est obligatoire';

  @override
  String get invalidNumber => 'Entre un nombre supérieur à 0';

  @override
  String get save => 'Enregistrer';

  @override
  String get stats => 'Statistiques';

  @override
  String get settings => 'Réglages';

  @override
  String get language => 'Langue';

  @override
  String get delete => 'Supprimer';

  @override
  String pagesProgress(int current, int total) {
    return '$current / $total pages';
  }

  @override
  String get totalBooks => 'Livres dans la bibliothèque';

  @override
  String get finishedBooks => 'Livres terminés';

  @override
  String get pagesRead => 'Pages lues';
}
