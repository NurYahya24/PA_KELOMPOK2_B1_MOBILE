import 'package:flutter/material.dart';

class section_page extends StatefulWidget {
  const section_page({super.key});

  @override
  State<section_page> createState() => _section_pageState();
}

class _section_pageState extends State<section_page> {
  bool isSelected = false;
  TextEditingController _textController = TextEditingController();
  Color _buttonColor = Color(0xffDDDDDD);
  Color _textColor = Colors.black;

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
                Navigator.pop(
                  context,
                  null
                );
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
                suffixIcon: IconButton(onPressed: (){
                  _textController.clear();
                }, icon: Icon(Icons.clear_rounded),),
              ),
            ),
          ),
          SizedBox(height: 300),
          Container(
            margin: EdgeInsets.all(24),
            child: TextButton(
              onPressed: _buttonColor == Color(0xFFFF8787)
                  ? () {
                      Navigator.pop(
                        context,
                        _textController
                      );
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
