import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final String userID;
  final String username;
  final int avatar;
  final String email;

  UserData(
      {required this.userID,
      required this.username,
      required this.email,
      required this.avatar});
}

Future<UserData> readData() async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  try {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    final userID = firebaseAuth.currentUser!.uid;
    final username = userData.data()!['username'];
    final avatar = userData.data()!['avatar'];
    final email = userData.data()!['email'];

    return UserData(
        userID: userID, username: username, email: email, avatar: avatar);
  } catch (e) {
    print('Error fetching user data: $e');
    throw e;
  }
}
