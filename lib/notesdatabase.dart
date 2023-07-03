import 'package:hive/hive.dart';

import 'modules/note.dart';

class NotesDatabase {
  // initialize hive
  final _myBox = Hive.box('notes_database');

  // load hive
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    if (_myBox.get('ALL_NOTES') != null) {
      List<dynamic> savedNotes = _myBox.get('ALL_NOTES');

      // create individual notes out of array storage
      for (int i = 0; i < savedNotes.length; i++) {
        Note individualNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][1]);

        savedNotesFormatted.add(individualNote);
      }
    }

    return savedNotesFormatted;
  }
  
  // save data
  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];

    // Add each note indvidually as an array
    for (var note in allNotes) {
      String text = note.text;
      int id = note.id;

      allNotesFormatted.add([id, text]);
    }

    // update box of notes
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
