import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    String col_name = 'S+' + id.toString();
    return FirebaseFirestore.instance.collection(col_name).snapshots();
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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
                    int index = 0;
                    int panjang = snapshot.data?.docs.length as int;
                    for (int i = 0; i < panjang; i++) {
                      if (snapshot.data!.docs[i].id ==
                          FirebaseAuth.instance.currentUser!.uid) {
                        index = i;
                      }
                    }
                    if (snapshot.hasError) {
                      return Text('Terjadi Kesalahan Saat Membaca Data');
                    } else {
                      return Container(
                        margin: EdgeInsets.all(24),
                        child: Text(
                          snapshot.data?.docs[index]['section_name'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
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
        label: const Text("New Section"),
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
