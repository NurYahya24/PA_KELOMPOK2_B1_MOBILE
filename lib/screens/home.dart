import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'journal.dart';
import 'affirmation.dart';
import 'highlight.dart';
import 'quotes.dart';

List<String> _avatar = ['1', '2', '3', '4', '5', '6', '7'];
bool _isSwitched = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  // static var id = FirebaseAuth.instance.currentUser!.uid;
  void _onItemTap(int index) {
    setState(
      () {
        _index = index;
      },
    );
  }

  static final List<Widget> _pages = [
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

  void _changeAvatar(BuildContext) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 226, 226),
        // centerTitle: true,
        title: Text(
          'Profile & Settings',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // COLUMN THAT WILL CONTAIN THE PROFILE
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80",
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Nama",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Email"),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              child: ListTile(
                leading: Icon(Icons.light_mode),
                title: Text('Dark Mode'),
                trailing: Switch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Color.fromRGBO(224, 46, 129, 1),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),

      // body: Container(
      //   padding: EdgeInsets.all(20.0),
      //   child: Center(
      //     child: Column(children: <Widget>[
      //       SizedBox(
      //         height: 30,
      //       ),
      //       CircleAvatar(
      //         backgroundColor: Color.fromARGB(255, 255, 226, 226),
      //         // backgroundImage: AssetImage(ima),
      //         radius: 70,
      //       ),
      //       SizedBox(height: 15),
      //       Container(
      //         width: MediaQuery.of(context).size.width,
      //         height: 80,
      //         decoration: BoxDecoration(
      //           color: Color.fromARGB(255, 255, 226, 226),
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //         // child: ListView(
      //         //   scrollDirection: Axis.horizontal,
      //         //   children: [
      //         //     for (int i = 0; i < _avatar.length; i++)
      //         //       GestureDetector(
      //         //         onTap: () => {} ,
      //         //         child: Container(
      //         //           width: 80,
      //         //           margin: EdgeInsets.only(top: 5, left: 2),
      //         //           child: Column(
      //         //             children: [
      //         //               CircleAvatar(
      //         //                 radius: 35,
      //         //                 backgroundColor: Colors.white,
      //         //                 child: CircleAvatar(
      //         //                   backgroundImage: Image.asset('assets/' +
      //         //                           _avatar[i].toString() +
      //         //                           '.png')
      //         //                       .image,
      //         //                   radius: 32,
      //         //                 ),
      //         //               )
      //         //             ],
      //         //           ),
      //         //         ),
      //         //       )
      //         //   ],
      //         // ),
      //         child: ListView(
      //           scrollDirection: Axis.horizontal,
      //           children: [
      //             for (int i = 0; i < _avatar.length; i++)
      //               GestureDetector(
      //                 onTap: () => {},
      //                 child: Container(
      //                   width: 80,
      //                   margin: EdgeInsets.only(top: 5, left: 2),
      //                   child: Column(
      //                     children: [
      //                       CircleAvatar(
      //                         radius: 35,
      //                         backgroundColor: Colors.white,
      //                         child: CircleAvatar(
      //                           backgroundImage: Image.asset('assets/' +
      //                                   _avatar[i].toString() +
      //                                   '.png')
      //                               .image,
      //                           radius: 32,
      //                         ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               )
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         height: 30,
      //       ),
      //       Container(
      //         padding: EdgeInsets.all(10.0),
      //         height: 40,
      //         width: 300,
      //         decoration: BoxDecoration(
      //             color: const Color.fromARGB(255, 255, 234, 234),
      //             borderRadius: BorderRadius.circular(10),
      //             border: Border.all(color: Colors.grey, width: 2)),
      //         child: TextField(
      //           decoration: InputDecoration(
      //             // hintText: nama,
      //             hintStyle: TextStyle(
      //               color: Colors.black,
      //             ),
      //             suffix: Icon(
      //               Icons.edit,
      //               color: Colors.grey,
      //               size: 15,
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(height: 100),
      //     ]),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     showAlertDialog(
      //       context,
      //       "LOGOUT",
      //       "Are you sure want to logout this account?",
      //     );
      //   },
      //   backgroundColor: Color.fromRGBO(224, 46, 129, 1),
      //   label: Text(
      //     'Logout',
      //     style: TextStyle(
      //       fontSize: 16,
      //       color: Colors.white,
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      //   icon: Icon(
      //     Icons.logout_outlined,
      //     color: Colors.white,
      //     size: 20,
      //   ),
      // ),
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
                Navigator.of(context).popUntil((route) => route.isFirst);
                FirebaseAuth.instance.signOut();
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}

class CustomListTile {
  final IconData icon;
  final String title;
  CustomListTile({
    required this.icon,
    required this.title,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.insights,
    title: "Activity",
  ),
  CustomListTile(
    icon: Icons.location_on_outlined,
    title: "Location",
  ),
  CustomListTile(
    title: "Notifications",
    icon: CupertinoIcons.bell,
  ),
  CustomListTile(
    title: "Logout",
    icon: CupertinoIcons.arrow_right_arrow_left,
  ),
];
