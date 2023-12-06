// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../provider/Auth.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlEmail = TextEditingController();

  final TextEditingController _ctrlUsername = TextEditingController();

  final TextEditingController _ctrlPassword = TextEditingController();
  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _ctrlEmail.value.text;
    final password = _ctrlPassword.value.text;
    final username = _ctrlUsername.value.text;
    setState(() => _loading = true);
    await Auth().regis(email, password, username);
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _ctrlEmail,
                  cursorColor: const Color.fromRGBO(224, 46, 129, 1),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Email Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .grey), // Atur warna border saat tidak aktif
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(224, 46, 129, 1),
                      ), // Atur warna border saat focused
                    ),
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _ctrlUsername,
                  cursorColor: const Color.fromRGBO(224, 46, 129, 1),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Username Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .grey), // Atur warna border saat tidak aktif
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(224, 46, 129, 1),
                      ), // Atur warna border saat focused
                    ),
                    hintText: 'Username',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _ctrlPassword,
                  cursorColor: const Color.fromRGBO(224, 46, 129, 1),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Password Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .grey), // Atur warna border saat tidak aktif
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(224, 46, 129, 1),
                      ), // Atur warna border saat focused
                    ),
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => handleSubmit(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(224, 46, 129, 1),
                    minimumSize:
                        const Size(400, 50), // Atur lebar dan tinggi button
                    padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16), // Padding di sekitar icon dan teks
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Mengatur radius untuk membuat button rounded
                    ),
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 100,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Submit",
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have account?',
                      style: GoogleFonts.quicksand(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Click here',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                              color: const Color.fromRGBO(224, 46, 129, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
