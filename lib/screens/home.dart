import 'package:daily_jurnal/screens/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'journal.dart';
import 'affirmation.dart';
import 'highlight.dart';
import 'quotes.dart';
import '../pustaka/globals.dart' as globals;

List<String> _avatar =[
  '1',
  '2',
  '3',
  '4',
  '5',
  '6'
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    globals.readData();
    super.initState();
  }

  int _index = 0;
  void _onItemTap(int index) {
    setState(
      () {
        _index = index;
      },
    );
  }

  static List<Widget> _pages = [
    JournalPage(),
    affirmation_page(),
    quotes_page(),
    highlight_page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Profile_page();
                },
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(top: 15, left: 25),
            child: CircleAvatar(
              radius: 60,
              child: Icon(Icons.person),
            ),
          ),
        ),
      ),
      body: Center(
        child: _pages.elementAt(_index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Color.fromARGB(255, 253, 233, 235),
        // unselectedItemColor: Color.fromARGB(255, 221, 218, 219),
        // selectedItemColor: const Color.fromARGB(255, 229, 69, 107),
        backgroundColor: Color.fromARGB(255, 255, 226, 226),
        unselectedItemColor: Color.fromARGB(255, 170, 170, 170),
        selectedItemColor: const Color.fromRGBO(224, 46, 129, 1),
        currentIndex: _index,
        onTap: _onItemTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'Affirmation',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.circle),
            label: 'Quotes',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square),
            label: 'Highlight',
          ),
        ],
      ),
    );
  }
}

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  bool isAnyTextFieldChange = false;

  void _showIconPicker(BuildContext context) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 226, 226),
        centerTitle: true,
        title: Text(
          'Profile & Settings',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(children: <Widget>[
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 226, 226),
              // backgroundImage: AssetImage(ima),
              radius: 70,
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 226, 226),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for(int i = 0; i < _avatar.length; i++)
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.only(top: 5, left: 2),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundImage: Image.asset('assets/'+ _avatar[i].toString()+'.png').image,
                              radius: 32,
                              
                              
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 234, 234),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 2)),
              child: TextField(
                decoration: InputDecoration(
                  // hintText: nama,
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  suffix: Icon(
                    Icons.edit,
                    color: Colors.grey,
                    size: 15,
                  ),
                ),
              ),
            ),
            SizedBox(height: 200),
            Container(
              width: 90,
              height: 30,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
                onPressed: () {
                  showAlertDialog(
                    context,
                    "LOGOUT",
                    "Are you sure want to logout this account?",
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  backgroundColor: Color.fromRGBO(224, 46, 129, 1),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<dynamic> showAlertDialog(
      BuildContext context, String judul, String konten) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(judul),
          content: Text(konten),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
