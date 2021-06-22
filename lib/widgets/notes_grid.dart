import 'package:flutter/material.dart';
import 'package:notes_flutter/provider/notes_provider.dart';
import 'package:notes_flutter/screens/edit_note_screen.dart';
import 'package:provider/provider.dart';

class NotesGrid extends StatelessWidget {  
  @override
  Widget build(BuildContext context) { 
    final notes = Provider.of<NotesProvider>(context, listen: false);
    final allNotes = notes.allNotes; 

    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.25,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: allNotes.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => EditNoteScreen(id: allNotes[index].id)
          ));
          
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.grey[200],
            child: GridTile(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (allNotes[index].title != null && allNotes[index].title != '') Text(
                          allNotes[index].title!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          allNotes[index].description,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        allNotes[index].createdAt,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600]
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}