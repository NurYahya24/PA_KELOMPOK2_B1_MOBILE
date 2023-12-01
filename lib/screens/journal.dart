import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  FirebaseFirestore fs = FirebaseFirestore.instance;

  void deleteJurnal(String idDoc) {
    var id = FirebaseAuth.instance.currentUser!.uid;
    String col_name = "J+" + id.toString();
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection(col_name).doc(idDoc).delete().then(
        (doc) => print("Document Berhasil Terhapus Dengan id : ${id}"),
        onError: (e) => print("Error $e"));
  }

  Stream<QuerySnapshot> getJurnal() {
    var id = FirebaseAuth.instance.currentUser!.uid;
    String col_name = "J+" + id.toString();
    return FirebaseFirestore.instance
        .collection(col_name)
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
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
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
                              return Text('Error saat membaca data...');
                            } else {
                              return Text(
                                snapshot.data?.docs[index]['username'] +
                                    "'s Journals",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
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
                        return Text('Error saat membaca data...');
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
                                      title: Text('No Journal'),
                                      subtitle: const Text('Make New Journal'),
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
                                      color: Color.fromRGBO(64, 75, 96, 0.9),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      leading: Container(
                                        padding: EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                            border: Border(
                                          right: BorderSide(
                                              width: 1, color: Colors.white24),
                                        )),
                                        child: IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Colors.white60,
                                          onPressed: () {
                                            deleteJurnal(docID);
                                          },
                                        ),
                                      ),
                                      title: Text(
                                        snapshot.data?.docs[index]['judul'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 0,
                                        ),
                                        child: Text(
                                          formatTanggal,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                      trailing: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateJournalPage(
                                                    aksi: 'edit',
                                                    id: docID,
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
                    )),
          );
        },
        backgroundColor: Color.fromRGBO(224, 46, 129, 1),
        label: Text(
          'Write Entry',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
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
  final aksi, id;
  const CreateJournalPage({
    super.key,
    required this.aksi,
    this.id,
  });

  @override
  State<CreateJournalPage> createState() => _CreateJournalPageState();
}

class _CreateJournalPageState extends State<CreateJournalPage> {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  Color selectedColor = Colors.white;
  bool isAnyTextFieldFilled = false;
  final _judul = TextEditingController();
  final _konten = TextEditingController();

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

  Stream<QuerySnapshot> getJurnal() {
    String col_name = "J+" + widget.id.toString();
    return FirebaseFirestore.instance.collection(col_name).snapshots();
  }

  void addJurnal(String judul, String konten, int warna) {
    var id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = {
      "judul": judul,
      "konten": konten,
      "tanggal": Timestamp.now(),
      "warna": warna,
    };
    db.collection('J+' + id).add(data).then((DocumentSnapshot) =>
        print("Berhasil Menambahkan Data Dengan  ID : ${DocumentSnapshot.id}"));
  }

  void editJurnal(String judul, String konten, int warna, String idDoc) {
    final data = {
      "judul": judul,
      "konten": konten,
      "tanggal": Timestamp.now(),
      "warna": warna,
    };
    var id = FirebaseAuth.instance.currentUser!.uid;
    String col_name = "J+" + id.toString();
    FirebaseFirestore.instance
        .collection(col_name)
        .doc(idDoc)
        .update(data)
        .then((DocumentSnapshot) =>
            print("Berhasil Mengubah Data Dengan  ID : ${idDoc}"));
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
      appBar: AppBar(
        backgroundColor: selectedColor,
        actions: [
          Visibility(
              visible: isAnyTextFieldFilled,
              child: IconButton(
                  onPressed: () {
                    widget.aksi == 'add'
                        ? addJurnal(_judul.text, _konten.text, 1)
                        : editJurnal(_judul.text, _konten.text, 1, widget.id);
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
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color.fromRGBO(86, 85, 85, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        'Edit Journal',
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
                      _judul.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                  maxLength: 50, // Set panjang maksimum karakter
                  maxLines: null,
                  controller: _judul,
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
                  maxLines: null,
                  controller: _konten,
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
