import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 20),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Your Journals',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 190, top: 510),
                  child: Container(
                    width: 160,
                    child: ElevatedButton(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/pencil.png',
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Write Entry',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateJournalPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        backgroundColor: Color.fromRGBO(224, 46, 129, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CreateJournalPage extends StatefulWidget {
  const CreateJournalPage({Key? key}) : super(key: key);

  @override
  State<CreateJournalPage> createState() => _CreateJournalPageState();
}

class _CreateJournalPageState extends State<CreateJournalPage> {
  Color selectedColor = Colors.white;
  bool isAnyTextFieldFilled = false;

  List<Color> colors = [
    Colors.white,
    Color.fromRGBO(250, 171, 208, 1),
    Color.fromRGBO(144, 203, 251, 1),
    Color.fromRGBO(166, 255, 169, 1),
    Color.fromRGBO(255, 247, 176, 1),
    Color.fromRGBO(255, 173, 173, 1),
    Color.fromRGBO(223, 159, 248, 1),
    Color.fromRGBO(163, 255, 247, 1),
    Color.fromRGBO(238, 179, 179, 1),
  ];

  void _showColorPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = colors[index];
                  });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: colors[index],
                    radius: 20,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, right: 320),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Create Journal',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Color.fromRGBO(86, 85, 85, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      isAnyTextFieldFilled = value.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                  maxLength: 50, // Set panjang maksimum karakter
                  maxLines: 1,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      isAnyTextFieldFilled = value.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Write your journal here',
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
              ),
            ],
          ),
          Positioned(
            top: 35,
            right: 15,
            child: Visibility(
              visible: isAnyTextFieldFilled,
              child: IconButton(
                icon: Icon(Icons.check),
                onPressed: () {},
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: Visibility(
              child: IconButton(
                onPressed: () {
                  _showColorPicker(context);
                },
                icon: Icon(Icons.palette),
                iconSize: 35,
                color: Color.fromRGBO(86, 85, 85, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
