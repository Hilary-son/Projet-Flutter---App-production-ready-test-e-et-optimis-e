// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Reads';

  @override
  String get emptyList => 'No books yet. Add your first one!';

  @override
  String get addBook => 'Add a book';

  @override
  String get bookTitle => 'Title';

  @override
  String get bookAuthor => 'Author';

  @override
  String get bookPages => 'Number of pages';

  @override
  String get bookCover => 'Cover URL (optional)';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidNumber => 'Enter a number greater than 0';

  @override
  String get save => 'Save';

  @override
  String get stats => 'Statistics';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get delete => 'Delete';

  @override
  String pagesProgress(int current, int total) {
    return '$current / $total pages';
  }

  @override
  String get totalBooks => 'Books in library';

  @override
  String get finishedBooks => 'Books finished';

  @override
  String get pagesRead => 'Pages read';
}
