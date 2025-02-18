import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NotepadScreen extends StatelessWidget {
  const NotepadScreen({super.key});

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
        onPressed: () {},
        child: Icon(LucideIcons.plus, size: 30, color: Colors.white),
      ),
      body: Center(),
    );
  }
}
