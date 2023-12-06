import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'journal.dart';
import 'affirmation.dart';
import 'highlight.dart';
import 'quotes.dart';

int profile_index = 0;

List<String> _avatar = ['1', '2', '3', '4', '5', '6', '7'];
bool _isSwitched = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
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
        backgroundColor: Color.fromARGB(255, 255, 226, 226),
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
            padding: EdgeInsets.only(left: 25),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: const Color.fromRGBO(224, 46, 129, 1),
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
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

  var idUser = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot> getUser() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db.collection('users').snapshots();
  }

  void editProfile(String username, int avatar) {
    final data = {
      "avatar": avatar,
      "username": username,
    };
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('users').doc(idUser).update(data);
  }

  renderContainer(Widget child) {
    return SizedBox(height: 90, width: 90, child: Center(child: child));
  }

  void showDialogWithFields(BuildContext context, username) {
    showDialog(
      context: context,
      builder: (BuildContext builder) {
        var nameController = TextEditingController();
        nameController.text = username;
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 226, 226),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _avatar.length,
                            itemBuilder: (BuildContext context, int index) {
                              return renderContainer(SelectableAvatar(
                                url: 'assets/' + _avatar[index] + '.png',
                                index_avatar: index,
                              ));
                            }),
                      ),
                    ]),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  cursorColor: Color.fromRGBO(224, 46, 129, 1),
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(224, 46, 129, 1),
                          width: 2.0,
                        ),
                      ),
                      hintText: 'Write your Username'),
                  maxLines: null,
                  maxLength: 20,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color.fromRGBO(224, 46, 129, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                editProfile(nameController.text, profile_index);
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Color.fromRGBO(224, 46, 129, 1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 226, 226),
        // centerTitle: true,
        title: Text(
          'Profile & Settings',
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: getUser(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return Text('Errror saat membaca data');
                    } else {
                      if (snapshot.hasData) {
                        int index = 0;
                        int panjang = snapshot.data!.docs.length;
                        for (int i = 0; i < panjang; i++) {
                          if (snapshot.data!.docs[i].id == idUser) {
                            index = i;
                          }
                        }
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 52,
                              backgroundColor: Colors.pink,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: Image.asset("assets/" +
                                        _avatar[snapshot.data?.docs[index]
                                            ['avatar']] +
                                        ".png")
                                    .image,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              snapshot.data?.docs[index]['username'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(snapshot.data?.docs[index]['email']),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(224, 46, 129, 1),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  showDialogWithFields(context,
                                      snapshot.data?.docs[index]['username']);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                label: const Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Text('Data kosong');
                      }
                    }
                }
              }),
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              child: ListTile(
                leading: Icon(Icons.light_mode),
                title: Text(
                  'Dark Mode',
                  style: GoogleFonts.quicksand(),
                ),
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
                title: Text(
                  'Log Out',
                  style: GoogleFonts.quicksand(),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showAlertDialog(
                    context,
                    "LOGOUT",
                    "Are you sure want to logout this account?",
                  );
                },
              ),
            ),
          ),
        ],
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
                child: Text(
                  "Cancel",
                  style: GoogleFonts.quicksand(),
                )),
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                FirebaseAuth.instance.signOut();
              },
              child: Text(
                "Yes",
                style: GoogleFonts.quicksand(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SelectableAvatar extends StatefulWidget {
  const SelectableAvatar({Key? key, this.url, this.index_avatar})
      : super(key: key);
  final String? url;
  final int? index_avatar;

  @override
  State<SelectableAvatar> createState() => _SelectableAvatarState();
}

class _SelectableAvatarState extends State<SelectableAvatar> {
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        child: Builder(
          builder: (context) {
            final FocusNode focusNode = Focus.of(context);
            final bool hasFocus = focusNode.hasFocus;
            return GestureDetector(
              onTap: () {
                focusNode.requestFocus();
                setState(() {
                  profile_index = int.parse(widget.index_avatar.toString());
                });
                print(profile_index);
              },
              child: _renderAvatar(hasFocus),
            );
          },
        ),
      ),
    );
  }

  Widget _renderAvatar(bool hasFocus) {
    final uri = widget.url != null ? Uri.tryParse(widget.url!) : null;
    final useDefault = uri == null;

    ImageProvider getProvider() {
      if (useDefault) {
        return const AssetImage('');
      }
      return AssetImage(widget.url!);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: hasFocus ? 120 : 100,
      height: hasFocus ? 120 : 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: hasFocus ? 3 : 2,
          color: hasFocus ? Color.fromRGBO(224, 46, 129, 1) : Colors.grey,
        ),
      ),
      child: CircleAvatar(
        foregroundColor: Colors.white,
        backgroundImage: getProvider(),
      ),
    );
  }
}
