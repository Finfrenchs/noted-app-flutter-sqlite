// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:note_app_sqlite/data/models/note.dart';
import 'package:note_app_sqlite/pages/home_page.dart';

import '../data/datasources/local_datasource.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Edit Note',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Content wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Note note = Note(
                    id: widget.note.id,
                    title: titleController.text,
                    content: contentController.text,
                    createdAt: DateTime.now(),
                  );

                  LocalDatasource().updateNoteById(note);
                  titleController.clear();
                  contentController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      content: const Text('edit note successfully.'),
                    ),
                  );
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }), (route) => false);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Save Note',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
