// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:note_app_sqlite/data/datasources/local_datasource.dart';

import 'package:note_app_sqlite/data/models/note.dart';
import 'package:note_app_sqlite/pages/edit_note_page.dart';
import 'package:note_app_sqlite/pages/home_page.dart';

class DetailNotePage extends StatefulWidget {
  const DetailNotePage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
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
          'Detail Note',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Delete Note'),
                    content: const Text('Are you sure?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                          onPressed: () async {
                            await LocalDatasource()
                                .deleteNoteById(widget.note.id!);
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return const HomePage();
                            }), (route) => false);
                          },
                          child: const Text('Delete')),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete_rounded,
              color: Colors.white,
            ),
          ),
        ],
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.note.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.note.content,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditNotePage(
              note: widget.note,
            );
          }));
        },
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
