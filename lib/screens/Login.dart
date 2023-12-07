// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_final_fields

import 'Regis.dart';
import 'package:flutter/material.dart';
import '../provider/Auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlEmail = TextEditingController();

  final TextEditingController _ctrlPassword = TextEditingController();

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _ctrlEmail.value.text;
    final password = _ctrlPassword.value.text;
    setState(() => _loading = true);
    try {
      await Auth().login(email, password);
      setState(() => _loading = false);
    } catch (e) {
      print('Error during login: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'There is An Error',
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(224, 46, 129, 1),
                ),
              ),
            ),
            content: Text(
              '$e',
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome",
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        color: const Color.fromRGBO(224, 46, 129, 1),
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Log in now to continue",
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                CircleAvatar(
                  radius: 110,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/Gratitude.png'),
                ),
                SizedBox(height: 50),
                TextFormField(
                  controller: _ctrlEmail,
                  cursorColor: const Color.fromRGBO(224, 46, 129, 1),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your email';
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
                  controller: _ctrlPassword,
                  cursorColor: const Color.fromRGBO(224, 46, 129, 1),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
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
                          width: 20,
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
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Regis()),
                        );
                      },
                      child: Text(
                        'Register Now',
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
