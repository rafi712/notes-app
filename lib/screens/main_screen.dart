import 'package:flutter/material.dart';
// import 'package:notes_flutter/model/notes.dart';
import 'package:notes_flutter/provider/notes_provider.dart';
import 'package:notes_flutter/screens/add_note_screen.dart';
import 'package:notes_flutter/widgets/notes_grid.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesProvider>(context);
    final allNotes = notes.allNotes;

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        title: Text(
          'Notes App',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 26
          ),
        ),        
      ),
      body: (allNotes.length == 0) 
        ? Center(
          child: Text(
            'No Data',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 30
            ),
          ),
        )
        : NotesGrid(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black, size: 33,),
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
      ),
    );
  }
}

