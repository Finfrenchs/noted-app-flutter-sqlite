import 'package:flutter/material.dart';
import 'package:note_app_sqlite/data/datasources/local_datasource.dart';
import 'package:note_app_sqlite/data/models/note.dart';
import 'package:note_app_sqlite/pages/add_note_page.dart';
import 'package:note_app_sqlite/pages/detail_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  bool isLoading = false;

  //function get all note
  Future<void> getNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await LocalDatasource().getNotes();

    setState(() {
      isLoading = false;
    });

    print(notes);
  }

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Noted App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : notes.isEmpty
              ? const Center(
                  child: Text(
                    'No Notes',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (cotext) {
                          return DetailNotePage(
                            note: notes[index],
                          );
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notes[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                notes[index].content,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddNotePage();
              },
            ),
          );
          getNotes();
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
