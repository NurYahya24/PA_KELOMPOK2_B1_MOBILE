import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class section_page extends StatefulWidget {
  final action, id;
  const section_page({
    super.key,
    required this.action,
    this.id,
  });

  @override
  State<section_page> createState() => _section_pageState();
}

class _section_pageState extends State<section_page> {
  bool isSelected = true;
  final _textController = TextEditingController();
  Color _buttonColor = Color(0xffDDDDDD);
  Color _textColor = Colors.black;

  FirebaseFirestore fs = FirebaseFirestore.instance;

  // Tambah data
  void addSection(String namaSection) {
    var id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = {
      "nama": namaSection,
      "tanggal": Timestamp.now(),
    };
    db.collection('users').doc(id).collection('section').add(data).then(
        (DocumentSnapshot) => print(
            "Berhasil Menambahkan Data Section Dengan ID : ${DocumentSnapshot.id}"));
  }

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
                Navigator.pop(context, null);
              },
              icon: Icon(Icons.arrow_back_rounded),
              iconSize: 30,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 14),
            child: Text(
              "Cool, now let's add a section.",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 14),
            child: Text(
              "What are sections?",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFFFF8787),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24),
            child: TextField(
              controller: _textController,
              cursorColor: Color(0xFFFF8787),
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
                suffixIcon: IconButton(
                  onPressed: () {
                    _textController.clear();
                  },
                  icon: Icon(Icons.clear_rounded),
                ),
              ),
            ),
          ),
          SizedBox(height: 300),
          Container(
            margin: EdgeInsets.all(24),
            child: TextButton(
              onPressed: _buttonColor == Color(0xFFFF8787)
                  ? () {
                      if (widget.action == "add") {
                        addSection(_textController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Your section has been successfully added!",
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
                      }
                      Navigator.of(context).pop();
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Continue",
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      color: _textColor,
                    ),
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

class sectionView extends StatefulWidget {
  final idSection, nama, tanggal;
  const sectionView(
      {super.key,
      required this.idSection,
      required this.nama,
      required this.tanggal});

  @override
  State<sectionView> createState() => _sectionViewState();
}

class _sectionViewState extends State<sectionView> {
  bool isLoaded = false;
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      final Uint8List uint8List = Uint8List.fromList(imageBytes);
      setIdPhoto(uint8List, widget.idSection);
    }
  }

  Future<void> addPhoto(
      Uint8List imageBytes, String idFolder, String idPhoto) async {
    try {
      String idUser = FirebaseAuth.instance.currentUser!.uid;
      String imageDir = 'highlight/$idUser/$idFolder/$idPhoto.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child(imageDir);
      UploadTask uploadTask = storageRef.putData(imageBytes);
      await uploadTask.whenComplete(() async {
        String url = await storageRef.getDownloadURL();
        setUrlImage(idFolder, idPhoto, url);
        setState(() {
          isLoaded = true;
        });
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  void setIdPhoto(Uint8List imageBytes, String idSection) {
    isLoaded = false;
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    final data = {"tanggal": Timestamp.now()};
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection('users')
        .doc(idUser)
        .collection('section')
        .doc(idSection)
        .collection('images')
        .add(data)
        .then((DocumentSnapshot) =>
            addPhoto(imageBytes, idSection, DocumentSnapshot.id));
  }

  void setUrlImage(String idSection, String idPhoto, String url) {
    String idUser = FirebaseAuth.instance.currentUser!.uid;
    final data = {"url": url};
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection('users')
        .doc(idUser)
        .collection('section')
        .doc(idSection)
        .collection('images')
        .doc(idPhoto)
        .update(data)
        .then((DocumentSnapshot) =>
            print('Berhasil menambahkan foto dengan id : $idPhoto'));
  }

  Stream<QuerySnapshot> getPhotos() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var id = FirebaseAuth.instance.currentUser!.uid;
    return db
        .collection('users')
        .doc(id)
        .collection('section')
        .doc(widget.idSection)
        .collection('images')
        .orderBy('tanggal', descending: true)
        .snapshots();
  }

  void deleteFolder() {
    var idUser = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection('users')
        .doc(idUser)
        .collection('section')
        .doc(widget.idSection)
        .delete();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 226, 226),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              widget.nama,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 77, 77, 77),
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.tanggal,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 77, 77, 77),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            StreamBuilder(
                stream: getPhotos(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Text('No images yet'),
                              ElevatedButton(
                                  onPressed: () {
                                    showAlertDialog(context, 'Delete Folder',
                                        'Are you sure?');
                                  },
                                  child: Text('Delete Folder')),
                            ],
                          ),
                        );
                      } else {
                        if (snapshot.hasError) {
                          return Center(
                            child: Icon(Icons.warning),
                          );
                        } else {
                          return Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 30,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Colors.black,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return RawMaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => viewImages(
                                                    url: snapshot.data
                                                        ?.docs[index]['url'],
                                                    index: index,
                                                    idSection: widget.idSection,
                                                    idPhoto: snapshot
                                                        .data?.docs[index].id,
                                                  )));
                                    },
                                    child: isLoaded
                                        ? Hero(
                                            tag: 'logo$index',
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      snapshot.data?.docs[index]
                                                              ['url'] ??
                                                          ''),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : CircularProgressIndicator(),
                                  );
                                },
                                itemCount: snapshot.data!.docs.length,
                              ),
                            ),
                          );
                        }
                      }
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(224, 46, 129, 1),
        onPressed: () {
          pickImage();
        },
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
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
                child: Text(
                  "Cancel",
                  style: GoogleFonts.quicksand(),
                )),
            TextButton(
              onPressed: () {
                deleteFolder();
                Navigator.pop(context);
                Navigator.pop(context);
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

class viewImages extends StatelessWidget {
  final url, idSection, idPhoto;
  final int index;
  const viewImages(
      {super.key,
      required this.url,
      required this.index,
      required this.idSection,
      required this.idPhoto});

  void deleteImage() async {
    var idUser = FirebaseAuth.instance.currentUser!.uid;
    final imgRef = FirebaseStorage.instance
        .ref()
        .child("highlight/$idUser/$idSection/$idPhoto.jpg");
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection('users')
        .doc(idUser)
        .collection('section')
        .doc(idSection)
        .collection('images')
        .doc(idPhoto)
        .delete();
    await imgRef.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Stack(
                children: [
                  Hero(
                      tag: 'logo$index',
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(url), fit: BoxFit.cover)),
                      )),
                  Stack(
                    children: [
                      Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_outlined,
                              )))
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
          onPressed: () {
            showAlertDialog(context, "Delete Image", "Are you sure?");
          },
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
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
                deleteImage();
                Navigator.pop(context);
                Navigator.pop(context);
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
