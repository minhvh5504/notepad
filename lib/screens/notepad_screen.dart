import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:notepad_flutter/components/notbox.dart';

import '../services/firestore_service.dart';

class NotepadScreen extends StatelessWidget {
  NotepadScreen({super.key});

  // Firestore
  final FirestoreService firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.cyanAccent.shade400,
          title: Text("Notes"),
          titleTextStyle: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.amber,
          hoverColor: Colors.amber,
          backgroundColor: Colors.cyanAccent.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () {
            openNoteBox(context, null, "Add");
          },
          child: Icon(LucideIcons.plus, size: 30, color: Colors.white),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestore.getNotesStream(),
          builder: (context, snapshot) {
            // If we have data, get all the docs

            if (snapshot.hasData) {
              List noteList = snapshot.data!.docs;
              // Display as a list

              return ListView.builder(
                  itemCount: noteList.length,
                  itemBuilder: (context, index) {
                    // Get each individual doc

                    DocumentSnapshot document = noteList[index];
                    String docID = document.id;
                    //  Get note from each doc

                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String noteText = data['note'];
                    return ListTile(
                        title: Text(noteText),
                        titleTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // update button
                            IconButton(
                              onPressed: () {
                                openNoteBox(context, docID, "Update");
                              },
                              icon: Icon(
                                LucideIcons.settings,
                                color: Colors.black54,
                              ),
                            ),
                            // delete button
                            IconButton(
                              onPressed: () {
                                firestore.deleteNotesById(docID);
                              },
                              icon: Icon(
                                LucideIcons.trash,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ));
                  });
            } else {
              return Center(
                child: Text("No notes..."),
              );
            }
          },
        ));
  }

  void openNoteBox(BuildContext context, String? docID, String text) {
    showDialog(
      context: context,
      builder: (context) => NoteBox(
        docID: docID,
        text: text,
      ),
    );
  }
}
