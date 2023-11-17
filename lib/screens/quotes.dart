import 'package:flutter/material.dart';

class quotes_page extends StatelessWidget {
  const quotes_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25, right: 15),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 59, bottom: 10),
                child: const Text(
                  "Quote of The Day",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                width: 460,
                height: 460,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                        image: AssetImage('assets/quote.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Spread Gratitude",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                width: 460,
                height: 460,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                        image: AssetImage('assets/spread.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Dose of Motivation",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                width: 460,
                height: 460,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                        image: AssetImage('assets/motivation.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Think Better",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                width: 460,
                height: 460,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                        image: AssetImage('assets/think.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Affirmation for You",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                width: 460,
                height: 460,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                        image: AssetImage('assets/affirmation.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/emoji.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15),
                child: const Text(
                  "Thank you for using Gratitude today",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color.fromARGB(255, 170, 170, 170),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 8, bottom: 50),
                child: const Text(
                  "See you tomorrow :)",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color.fromARGB(255, 170, 170, 170),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
