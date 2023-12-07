import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'section.dart';

class highlight_page extends StatefulWidget {
  const highlight_page({super.key});

  @override
  State<highlight_page> createState() => _highlight_pageState();
}

class _highlight_pageState extends State<highlight_page> {
  FirebaseFirestore fs = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getSection() {
    var id = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('section')
        .orderBy('tanggal', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            child: Text(
              "Your Highlights",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: getSection(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return Text(
                        'Terjadi Kesalahan Saat Membaca Data',
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
                                      child: Icon(CupertinoIcons.photo_camera,
                                          size: 45),
                                    ),
                                    title: Text(
                                      'No Highlight',
                                      style: GoogleFonts.quicksand(),
                                    ),
                                    subtitle: Text(
                                      'Create Your Own Highlight',
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
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Color.fromRGBO(216, 216, 216, 0.898)
                                        : Color.fromRGBO(68, 68, 83, 0.894),
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
                                      child: Icon(Icons.image),
                                    ),
                                    title: Text(
                                      snapshot.data?.docs[index]['nama'],
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? const Color.fromARGB(
                                                        255, 0, 0, 0)
                                                    : Colors.white,
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
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? const Color.fromARGB(
                                                      255, 0, 0, 0)
                                                  : Colors.white),
                                        ),
                                      ),
                                    )),
                                    trailing: Icon(
                                      Icons.keyboard_arrow_right,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      size: 30,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => sectionView(
                                                  idSection: docID,
                                                  nama: snapshot.data
                                                      ?.docs[index]['nama'],
                                                  tanggal: formatTanggal,
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
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const section_page(
                action: "add",
              ),
            ),
          );
        },
        label: Text(
          "New Section",
          style: GoogleFonts.quicksand(),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(224, 46, 129, 1),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
