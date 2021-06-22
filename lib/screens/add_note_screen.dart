import 'package:flutter/material.dart';
import 'package:notes_flutter/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
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
    final notes = Provider.of<NotesProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        title: Text(
          'Add Note',
          style: TextStyle(color: Colors.orange, fontSize: 26),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          // color: Colors.white,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
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
                  controller: descController,
                  cursorColor: Colors.orange,
                  autofocus: true,
                  // keyboardType: TextInputType.multiline,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.save,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          notes.addNote(titleController.text, descController.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}
