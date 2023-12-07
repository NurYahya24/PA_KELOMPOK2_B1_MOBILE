import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_jurnal/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Color> colors = [
  Color.fromRGBO(250, 171, 208, 1),
  Color.fromRGBO(144, 203, 251, 1),
  Color.fromRGBO(166, 255, 169, 1),
  Color.fromRGBO(255, 247, 176, 1),
  Color.fromRGBO(255, 173, 173, 1),
  Color.fromRGBO(223, 159, 248, 1),
  Color.fromRGBO(163, 255, 247, 1),
  Color.fromRGBO(238, 179, 179, 1),
  Color.fromRGBO(150, 142, 255, 1),
];

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  Future<dynamic> showAlertDialog(
      BuildContext context, String judul, String konten, String idDoc) {
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
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: const Color.fromRGBO(224, 46, 129, 1),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteJurnal(idDoc);
                Navigator.pop(context);
              },
              child: Text(
                "Yes",
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: const Color.fromRGBO(224, 46, 129, 1),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteJurnal(String idDoc) {
    var id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection('users')
        .doc(id)
        .collection('jurnal')
        .doc(idDoc)
        .delete()
        .then((doc) => print("Document Berhasil Terhapus Dengan id : ${id}"),
            onError: (e) => print("Error $e"));
  }

  Stream<QuerySnapshot> getJurnal() {
    var id = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('jurnal')
        .orderBy('tanggal', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> whoAmI() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StreamBuilder(
                      stream: whoAmI(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Text(
                              "Loading.... Journals",
                              style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          default:
                            int index = 0;
                            int panjang = snapshot.data?.docs.length as int;
                            for (int i = 0; i < panjang; i++) {
                              if (snapshot.data!.docs[i].id ==
                                  FirebaseAuth.instance.currentUser!.uid) {
                                index = i;
                              }
                            }
                            if (snapshot.hasError) {
                              return Text(
                                'Error saat membaca data...',
                                style: GoogleFonts.quicksand(),
                              );
                            } else {
                              profile_index =
                                  snapshot.data?.docs[index]['avatar'];
                              return Text(
                                snapshot.data?.docs[index]['username'] +
                                    "'s Journals",
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                    fontSize: 25,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                        }
                      })
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: getJurnal(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Error saat membaca data...',
                          style: GoogleFonts.quicksand(),
                        );
                      } else {
                        if (snapshot.data!.docs.length == 0) {
                          return Center(
                            child: Card(
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    ListTile(
                                      leading: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minWidth: 100,
                                          minHeight: 190,
                                          maxWidth: 200,
                                          maxHeight: 200,
                                        ),
                                        child: Icon(Icons.menu_book, size: 45),
                                      ),
                                      title: Text(
                                        'No Journal',
                                        style: GoogleFonts.quicksand(),
                                      ),
                                      subtitle: Text(
                                        'Create Your Own Journal',
                                        style: GoogleFonts.quicksand(),
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        } else {
                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                final docID = snapshot.data!.docs[index].id;
                                final Timestamp timestamp = snapshot
                                    .data?.docs[index]['tanggal'] as Timestamp;
                                final DateTime dateTime = timestamp.toDate();
                                var formatTanggal =
                                    "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                                return Card(
                                  elevation: 8,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: colors[snapshot.data?.docs[index][
                                          'warna']], //Color.fromRGBO(64, 75, 96, 0.9),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      leading: Container(
                                        padding: EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                            border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              color: const Color.fromARGB(
                                                  60, 0, 0, 0)),
                                        )),
                                        child: IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Color.fromARGB(153, 0, 0, 0),
                                          onPressed: () {
                                            showAlertDialog(
                                                context,
                                                "Delete Journal",
                                                "Are you sure want to delete this journal?",
                                                docID);
                                          },
                                        ),
                                      ),
                                      title: Text(
                                        snapshot.data?.docs[index]['judul'],
                                        style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      subtitle: Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 0,
                                        ),
                                        child: Text(
                                          formatTanggal,
                                          style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          ),
                                        ),
                                      )),
                                      trailing: Icon(
                                        Icons.keyboard_arrow_right,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        size: 30,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateJournalPage(
                                                    aksi: 'edit',
                                                    judul: snapshot.data
                                                        ?.docs[index]['judul'],
                                                    konten: snapshot.data
                                                        ?.docs[index]['konten'],
                                                    id: docID,
                                                    warna: snapshot.data
                                                        ?.docs[index]['warna'],
                                                  )),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              });
                        }
                      }
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Make New Entry',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateJournalPage(
                      aksi: 'buat',
                      warna: 0,
                      judul: '',
                      konten: '',
                    )),
          );
        },
        backgroundColor: Color.fromRGBO(224, 46, 129, 1),
        label: Text(
          'Write Entry',
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        icon: Image.asset(
          'assets/pencil.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}

class CreateJournalPage extends StatefulWidget {
  final aksi, id, warna, judul, konten;
  const CreateJournalPage(
      {super.key,
      required this.aksi,
      this.id,
      this.warna,
      this.judul,
      this.konten});

  @override
  State<CreateJournalPage> createState() => _CreateJournalPageState();
}

class _CreateJournalPageState extends State<CreateJournalPage> {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  int index_warna = 0;
  Color selectedColor = colors[0]; //Color.fromRGBO(250, 171, 208, 1);
  bool isAnyTextFieldFilled = false;
  var _judul = TextEditingController();
  var _konten = TextEditingController();

  void addJurnal(String judul, String konten, int warna) {
    var id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = {
      "judul": judul,
      "konten": konten,
      "tanggal": Timestamp.now(),
      "warna": warna,
    };
    db.collection('users').doc(id).collection('jurnal').add(data).then(
        (DocumentSnapshot) => print(
            "Berhasil Menambahkan Data Dengan  ID : ${DocumentSnapshot.id}"));
  }

  void editJurnal(String judul, String konten, int warna, String idDoc) {
    final data = {
      "judul": judul,
      "konten": konten,
      "warna": warna,
    };
    var id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('jurnal')
        .doc(idDoc)
        .update(data)
        .then((DocumentSnapshot) =>
            print("Berhasil Mengubah Data Dengan  ID : ${idDoc}"));
  }

  void colorChanges(String idDoc, int warna) {
    final data = {
      "warna": warna,
    };
    var id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('jurnal')
        .doc(idDoc)
        .update(data)
        .then((DocumentSnapshot) => print("Berhasil Mengubah Warna: ${idDoc}"));
  }

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
                    index_warna = index;
                    selectedColor = colors[index_warna];
                  });
                  colorChanges(widget.id, index_warna);
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
  void initState() {
    super.initState();
    setState(() {
      _judul.text = widget.judul;
      _konten.text = widget.konten;
      selectedColor = colors[widget.warna];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _judul.dispose();
    _konten.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        backgroundColor: selectedColor,
        actions: [
          Visibility(
              visible: isAnyTextFieldFilled,
              child: IconButton(
                  onPressed: () {
                    // widget.aksi == 'buat'
                    //     ? addJurnal(_judul.text, _konten.text, index_warna)
                    //     : editJurnal(
                    //         _judul.text, _konten.text, index_warna, widget.id);
                    if (widget.aksi == 'buat') {
                      addJurnal(_judul.text, _konten.text, index_warna);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Your journal has been successfully added!",
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          backgroundColor: Color.fromRGBO(0, 230, 118, 1),
                        ),
                      );
                    } else {
                      editJurnal(
                          _judul.text, _konten.text, index_warna, widget.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Your journal has been successfully updated!",
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          backgroundColor: Color.fromRGBO(224, 46, 129, 1),
                        ),
                      );
                    }
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.check))),
          SizedBox(
            width: 12,
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: widget.aksi == 'buat'
                    ? Text(
                        'Create Journal',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(86, 85, 85, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : Text(
                        'Edit Journal',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: Color.fromRGBO(86, 85, 85, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
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
                      _judul.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.black),
                  maxLength: 50, // Set panjang maksimum karakter
                  maxLines: null,
                  controller: _judul,
                  cursorColor: Color.fromRGBO(106, 106, 106, 1),
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
                      _konten.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Write your journal here',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.black),
                  maxLines: null,
                  controller: _konten,
                  cursorColor: Color.fromRGBO(106, 106, 106, 1),
                ),
              ),
            ],
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
