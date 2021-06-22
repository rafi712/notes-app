import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../model/note.dart';

class NotesProvider with ChangeNotifier {
  int tempId = 0;
  bool onEditMode = false;

  List<Note> _notesList = [];
  List<Note> get allNotes => _notesList;
  
  void addNote(String title, String desc) {
    String date = formatDate(DateTime.now(), [d, ' ', MM, ' ', yyyy]);
    _notesList.add(
      Note(
        id: tempId++, 
        title: (title == '') ? null: title, 
        description: desc, 
        createdAt: date,
      )
    );

    notifyListeners();
  }

  void deleteNote(int id) {
    Note note = _notesList.firstWhere((note) => note.id == id);
    _notesList.remove(note);

    notifyListeners();
  }

  void editNote(int id, String title, String desc) {
    Note note = _notesList.firstWhere((note) => note.id == id);
    note.title = title;
    note.description = desc;
    note.createdAt = formatDate(DateTime.now(), [d, ' ', MM, ' ', yyyy]);
    
    notifyListeners();
  }

  void editMode(String value) {
    if (value == 'in') onEditMode = true;
    if (value == 'out') onEditMode = false;

    notifyListeners();
  }
}
