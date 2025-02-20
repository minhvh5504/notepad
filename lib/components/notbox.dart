import 'package:flutter/material.dart';
import 'package:notepad_flutter/services/firestore_service.dart';

class NoteBox extends StatelessWidget {
  final String? docID;
  final String text;
  NoteBox({super.key, this.docID, required this.text});

  // Firestore
  final FirestoreService firestore = FirestoreService();

  // Text controller
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("$text note"),
      titleTextStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.cyanAccent.shade700),
      // Text user input
      content: TextField(
        controller: textController,
      ),
      actions: [
        // Button add to save
        ElevatedButton(
          onPressed: () {
            // Add a new note
            if (docID == null) {
              if (textController.text.isNotEmpty) {
                firestore.addNote(textController.text);
              }
            }

            // Update an existing note
            else {
              if (textController.text.isNotEmpty) {
                firestore.updateNotesById(docID!, textController.text);
              }
            }

            //Clear the text controller
            textController.clear();

            //Close the box
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyan,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(text),
        ),
      ],
    );
  }
}
