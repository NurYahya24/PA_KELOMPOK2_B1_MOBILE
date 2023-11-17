import 'package:flutter/material.dart';
import 'section.dart';

class highlight_page extends StatelessWidget {
  const highlight_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
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
              padding: EdgeInsets.only(
                top: 350,
              ),
              margin: EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const section_page()),
                  );
                },
                icon: Icon(Icons.add),
                label: Text("New Section"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF8787),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
