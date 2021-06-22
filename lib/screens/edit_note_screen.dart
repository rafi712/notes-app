import 'package:flutter/material.dart';
import 'package:notes_flutter/model/note.dart';
import 'package:notes_flutter/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  final int id;
  EditNoteScreen({required this.id});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesProvider>(context);
    Note showedNote = notes.allNotes.firstWhere((note) => note.id == widget.id, orElse: () => Note(id: 0, title: '', description: '', createdAt: ''));
    titleController.text = showedNote.title ?? '';
    descController.text = showedNote.description;

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // notes.editMode('out');
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back)
        ),
        title: Text(
          'Edit Note',
          style: TextStyle(color: Colors.orange, fontSize: 26),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {
              notes.deleteNote(showedNote.id);
              Navigator.pop(context);
            }, 
            icon: Icon(Icons.delete)
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () => (notes.onEditMode == false) ? notes.editMode('in') : notes.editMode('out'),
            icon: (notes.onEditMode == false) ? Icon(Icons.edit) :Icon(Icons.close)
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          notes.editMode('out');
          return true;
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  readOnly: !notes.onEditMode,
                  controller: titleController,
                  cursorColor: Colors.orange,
                  style: TextStyle(fontSize: 25, color: Colors.orange),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle:
                          TextStyle(color: Colors.orange, letterSpacing: 1)),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.grey,
                ),
                Expanded(
                  child: TextField(
                    readOnly: !notes.onEditMode,
                    controller: descController,
                    cursorColor: Colors.orange,
                    autofocus: true,
                    style: TextStyle(color: Colors.grey[300], fontSize: 18),
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    maxLines: 15,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: (notes.onEditMode == false)
        ? null
        : FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.save,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
            notes.editMode('out');
            notes.editNote(showedNote.id, titleController.text, descController.text);
          },
        ),
    );
  }
}
