import 'package:daily_jurnal/screens/highlight.dart';
import 'package:flutter/material.dart';

class section_page extends StatelessWidget {
  const section_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const highlight_page()));
              },
              icon: Icon(Icons.arrow_back_rounded),
              iconSize: 30,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 14),
            child: Text(
              "Cool, now let's add a section.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 14),
            child: Text(
              "What are sections?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFFFF8787),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name your section',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFFFF8787)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
