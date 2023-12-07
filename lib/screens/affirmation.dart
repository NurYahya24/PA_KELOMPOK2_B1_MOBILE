import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_view/story_view.dart';

List<Color> colors = [
  Color.fromRGBO(172, 33, 97, 1),
  Color.fromRGBO(63, 31, 23, 1),
  Color.fromRGBO(5, 146, 10, 1),
  Color.fromRGBO(49, 49, 45, 1),
  Color.fromRGBO(100, 22, 22, 1),
  Color.fromRGBO(172, 33, 97, 1),
  Color.fromRGBO(63, 31, 23, 1),
  Color.fromRGBO(5, 146, 10, 1),
  Color.fromRGBO(49, 49, 45, 1),
  Color.fromRGBO(100, 22, 22, 1),
  Color.fromRGBO(172, 33, 97, 1),
  Color.fromRGBO(63, 31, 23, 1),
];

class mentalHealth {
  String judul, foto;
  mentalHealth({required this.judul, required this.foto});
}

List<mentalHealth> _mentalHealth = [
  mentalHealth(judul: 'Feel Calmer', foto: 'affirmationMental/Feel Calmer.png'),
  mentalHealth(
      judul: 'Embrace Emotions',
      foto: 'affirmationMental/Embrace Emotions.png'),
  mentalHealth(
      judul: 'Feel Hopeful', foto: 'affirmationMental/Feel Hopeful.png'),
  mentalHealth(judul: 'Be Stronger', foto: 'affirmationMental/Be Stronger.png')
];

class chakraBoost {
  String judul, foto;
  chakraBoost({required this.judul, required this.foto});
}

List<chakraBoost> _chakraBoost = [
  chakraBoost(judul: 'Root Chakra', foto: 'affirmationChakra/Chakra.png'),
  chakraBoost(judul: 'Sacral Chakra', foto: 'affirmationChakra/Chakra.png'),
  chakraBoost(judul: 'Hearth Chakra', foto: 'affirmationChakra/Chakra.png'),
  chakraBoost(judul: 'Throat Chakra', foto: 'affirmationChakra/Chakra.png'),
  chakraBoost(judul: 'Third Eye Chakra', foto: 'affirmationChakra/Chakra.png'),
];

class affirmation_page extends StatelessWidget {
  const affirmation_page({super.key});
  Stream<QuerySnapshot> getAffirmation() {
    return FirebaseFirestore.instance
        .collection('affirmations')
        .orderBy('pos', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 16),
              child: Text(
                'Better Mental Health',
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: getAffirmation(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text('Error saat membaca data');
                    } else {
                      return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 18,
                                  mainAxisSpacing: 18),
                          itemCount: _mentalHealth.length,
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListAffirm(
                                            id: snapshot.data?.docs[index].id)),
                                  );
                                },
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Image.asset(
                                          snapshot.data?.docs[index]['image']),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index].id,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['count']
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'Affirmations',
                                            style: GoogleFonts.quicksand(
                                              textStyle: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          });
                    }
                }
              }),
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 16),
              child: Text(
                'Balance Your Chakra',
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 15, right: 15),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 18, mainAxisSpacing: 18),
              itemCount: _chakraBoost.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () => null,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(_chakraBoost[index].foto),
                        ),
                        Text(
                          _chakraBoost[index].judul.toString(),
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0',
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                              Text(
                                'Affirmations',
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ));
              }),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class ListAffirm extends StatefulWidget {
  final id;
  const ListAffirm({super.key, required this.id});

  @override
  State<ListAffirm> createState() => _ListAffirmState();
}

class _ListAffirmState extends State<ListAffirm> {
  Stream<QuerySnapshot> fetchData(String idDoc) {
    return FirebaseFirestore.instance
        .collection('affirmations')
        .doc(idDoc)
        .collection('content')
        .orderBy('pos', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 255, 226, 226),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => playAffirms(id: widget.id)),
                  );
                },
                icon: Icon(Icons.play_arrow)),
          )
        ],
        // centerTitle: true,
        title: Text(
          widget.id,
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: fetchData(widget.id),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text('Error saat membaca data');
                    } else {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 8,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: colors[index],
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  title: Text(
                                    snapshot.data?.docs[index]['text'],
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: 30,
                                  ),
                                  onTap: () => null,
                                ),
                              ),
                            );
                          });
                    }
                }
              })
        ],
      ),
    );
  }
}

class playAffirms extends StatefulWidget {
  final id;
  const playAffirms({super.key, required this.id});

  @override
  State<playAffirms> createState() => _playAffirmsState();
}

class _playAffirmsState extends State<playAffirms> {
  final controller = StoryController();
  Stream<QuerySnapshot> fetchData() {
    return FirebaseFirestore.instance
        .collection('affirmations')
        .doc(widget.id)
        .collection('content')
        .orderBy('pos', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: StreamBuilder<QuerySnapshot>(
            stream: fetchData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    return Text('Error saat membaca data...');
                  } else {
                    int panjang = snapshot.data!.docs.length;
                    return StoryView(
                        storyItems: [
                          for (int i = 0; i < panjang; i++)
                            StoryItem.text(
                                title: snapshot.data?.docs[i]['text'],
                                backgroundColor: colors[i])
                        ],
                        repeat: false,
                        inline: false,
                        onComplete: () {
                          Navigator.pop(context);
                        },
                        controller: controller);
                  }
              }
            }));
  }
}
