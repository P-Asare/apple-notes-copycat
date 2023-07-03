import 'package:flutter/cupertino.dart';
import 'package:notes_proj/notesdatabase.dart';
import 'note.dart';

class NoteData extends ChangeNotifier {
  final db = NotesDatabase();

  List<Note> allNotes = [
    // Note(id: 0, text: 'Hello'),
    // Note(id: 1, text: 'Hi'),
    // Note(id: 2, text: 'Palal Asare is Good')
  ];

  // initialize database
  void initializeNotes() {
    allNotes =  db.loadNotes();
  }

  // get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  // add new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  // update note
  void updateNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        // replace note's text with new text
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  // delete note
  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
