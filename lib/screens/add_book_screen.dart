import 'package:flutter/material.dart';
import 'package:mes_lectures/l10n/app_localizations.dart';
import 'package:mes_lectures/providers/book_provider.dart';
import 'package:provider/provider.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _author = TextEditingController();
  final _pages = TextEditingController();
  final _cover = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _author.dispose();
    _pages.dispose();
    _cover.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<BookProvider>();
    final navigator = Navigator.of(context);
    final cover = _cover.text.trim();
    await provider.add(
      title: _title.text.trim(),
      author: _author.text.trim(),
      totalPages: int.parse(_pages.text.trim()),
      coverUrl: cover.isEmpty ? null : cover,
    );
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addBook)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: const Key('title_field'),
                controller: _title,
                decoration: InputDecoration(labelText: l10n.bookTitle),
                validator: required,
              ),
              TextFormField(
                key: const Key('author_field'),
                controller: _author,
                decoration: InputDecoration(labelText: l10n.bookAuthor),
                validator: required,
              ),
              TextFormField(
                key: const Key('pages_field'),
                controller: _pages,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: l10n.bookPages),
                validator: (v) {
                  final n = int.tryParse(v?.trim() ?? '');
                  return (n == null || n <= 0) ? l10n.invalidNumber : null;
                },
              ),
              TextFormField(
                key: const Key('cover_field'),
                controller: _cover,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(labelText: l10n.bookCover),
              ),
              const SizedBox(height: 24),
              FilledButton(
                key: const Key('save_button'),
                onPressed: _submit,
                child: Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
