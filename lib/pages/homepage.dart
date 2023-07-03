import 'package:notes_proj/modules/note.dart';
import 'package:notes_proj/modules/notedata.dart';
import 'package:notes_proj/pages/blankpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // initialize notes
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  // Create new note
  void createNewNote() {
    // Provide length of NoteData
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    // create new note
    Note newNote = Note(id: id, text: '');

    // Navigate to editing page
    toEditingScreen(newNote, true);
  }

  void toEditingScreen(Note note, bool isNew) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlankPage(
          note: note,
          isNew: isNew,
        ),
      ),
    );
  }

  // delete Note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 75,
                left: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            (value.getAllNotes().isEmpty)
                ? const Center(
                    child: Text('Nothing here...'),
                  )
                : CupertinoListSection.insetGrouped(
                    children: List.generate(
                      value.getAllNotes().length,
                      (index) => CupertinoListTile(
                          title: Text(
                            value.getAllNotes()[index].text,
                          ),
                          onTap: () => toEditingScreen(
                              value.getAllNotes()[index], false)),
                    ),
                  )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          backgroundColor: Colors.grey[350],
          elevation: 0,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
