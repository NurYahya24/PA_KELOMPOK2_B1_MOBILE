import 'package:flutter/material.dart';
import 'journal.dart';
import 'affirmation.dart';
import 'highlight.dart';
import 'quotes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  void _onItemTap(int index) {
    setState(() {
      _index = index;
    });
  }

  static List<Widget> _pages = [
    journal_page(),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const Profile_page();
            }));
          },
          child: CircleAvatar(
            radius: 35,
            child: Icon(Icons.person),
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
          selectedItemColor: const Color.fromARGB(255, 234, 138, 138),
          currentIndex: _index,
          onTap: _onItemTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Journal"),
            BottomNavigationBarItem(
                icon: Icon(Icons.heat_pump_rounded), label: "Affirmation"),
            BottomNavigationBarItem(icon: Icon(Icons.circle), label: "Quotes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.image), label: 'Highlight'),
          ]),
    );
  }
}

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Laman Profil'),
        ),
      ),
    );
  }
}
