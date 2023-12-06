import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class section_page extends StatefulWidget {
  final action, id;
  const section_page({
    super.key,
    required this.action,
    this.id,
  });

  @override
  State<section_page> createState() => _section_pageState();
}

class _section_pageState extends State<section_page> {
  bool isSelected = false;
  final _textController = TextEditingController();
  Color _buttonColor = Color(0xffDDDDDD);
  Color _textColor = Colors.black;

  FirebaseFirestore fs = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getSection() {
    String col_name = 'S+' + widget.id.toString();
    return FirebaseFirestore.instance
    .collection(col_name)
    .snapshots();
  }

  // Tambah data
  void addSection(String namaSection) {
    var id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final dataSection = {
      "nama_section": namaSection,
    };
    db.collection('S+' + id).add(dataSection).then((DocumentSnapshot) => print(
        "Berhasil Menambahkan Data Section Dengan ID : ${DocumentSnapshot.id}"));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onTextFieldChanged(String value) {
    setState(() {
      _buttonColor = value.isEmpty ? Color(0xffDDDDDD) : Color(0xFFFF8787);
      _textColor = value.isEmpty ? Colors.black : Colors.white;
    });
  }

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
                Navigator.pop(context, null);
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
            margin: EdgeInsets.only(left: 24, right: 24),
            child: TextField(
              controller: _textController,
              onChanged: _onTextFieldChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name your section',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF8787)),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _textController.clear();
                  },
                  icon: Icon(Icons.clear_rounded),
                ),
              ),
            ),
          ),
          SizedBox(height: 300),
          Container(
            margin: EdgeInsets.all(24),
            child: TextButton(
              onPressed: _buttonColor == Color(0xFFFF8787)
                  ? () {
                      widget.action == "add"
                          ? addSection(_textController.text)
                          : null;
                      Navigator.of(context).pop();
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: _textColor,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: _buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
