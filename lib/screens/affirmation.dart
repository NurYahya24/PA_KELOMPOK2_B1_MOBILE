import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      color: Colors.black,
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
              itemCount: _mentalHealth.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(_mentalHealth[index].foto),
                        ),
                        Text(
                          _mentalHealth[index].judul.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0',
                                style: TextStyle(color: Colors.black),
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
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 16),
              child: Text(
                'Balance Your Chakra',
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                      color: Colors.black,
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
                    onPressed: () {},
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
