import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/theme.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/Login.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Tema(),
        )
      ],
      child: Builder(builder: (context) {
        ColorScheme darkScheme = ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        );
        return MaterialApp(
          title: 'GRATITUDE',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            //colorSchemeSeed: Colors.green,
            colorScheme: darkScheme,
            textTheme: TextTheme(
              headlineLarge: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Serif'),
              bodyLarge: TextStyle(color: Colors.white70),
              bodyMedium: TextStyle(color: Colors.white60),
              bodySmall: TextStyle(color: Colors.white54),
            ),
          ),
          themeMode: Provider.of<Tema>(context).modeTema,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Home();
              } else {
                return Login();
              }
            },
          ),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
