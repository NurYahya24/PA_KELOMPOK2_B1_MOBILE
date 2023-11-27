import 'package:flutter/material.dart';

class mentalHealth {
  String teks;
  Color warna;

  mentalHealth({required this.teks, required this.warna});
  static List<mentalHealth> feelCalmer = [
    mentalHealth(teks: 'I am relaxing each part of my body', warna: Colors.blue),
    mentalHealth(teks: 'I am now in control', warna: Colors.black),
    mentalHealth(teks: 'My body is calm', warna: Colors.red),
    mentalHealth(teks: 'I am breathing slowly', warna: Colors.amber),
    mentalHealth(teks: 'All is well today', warna: Colors.pink),
    mentalHealth(
        teks: 'I welcome a sense of calm into my ife', warna: Colors.blue),
    mentalHealth(teks: 'I open my soul to peace', warna: Colors.purple),
    mentalHealth(teks: 'I am in control if my day', warna: Colors.pink),
    mentalHealth(teks: 'I can do this', warna: Colors.red),
    mentalHealth(teks: 'I am cool, calm, and collected', warna: Colors.yellow)
  ];
   static List<mentalHealth> embraceEmotions = [
    mentalHealth(teks: 'I am allowed to feel this way', warna: Colors.purple),
    mentalHealth(teks: 'The greatest gift i can give and recieve is the awareness of what I need right now', warna: Colors.green),
  ];
}
