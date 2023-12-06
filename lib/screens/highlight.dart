import 'package:flutter/material.dart';
import 'section.dart';

class highlight_page extends StatefulWidget {
  const highlight_page({super.key});

  @override
  State<highlight_page> createState() => _highlight_pageState();
}

class _highlight_pageState extends State<highlight_page> {
  String Section = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            child: Text(
              "Your Highlights",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: Text(
              '$Section',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final result = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const section_page(),
            ),
          );
          if (result != null){
            setState(() {
              Section = result as String;
            });
          }
          
        },
        label: const Text("New Section"),
        icon: const Icon(Icons.add),
        backgroundColor: Color(0xFFFF8787),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
