import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

String user = FirebaseAuth.instance.currentUser!.uid;
String username = '', email = '';
int avatar = 0;
DatabaseReference databaseReference =
    FirebaseDatabase.instance.ref().child('users');
DatabaseReference userRef = databaseReference.child(user);

void readData() async {
  final getName = await userRef.child('username').once(DatabaseEventType.value);
  final getMail = await userRef.child('email').once(DatabaseEventType.value);
  final getAvatar = await userRef.child('avatar').once(DatabaseEventType.value);
  username = getName.snapshot.value.toString();
  email = getMail.snapshot.value.toString();
  avatar = int.parse(getAvatar.snapshot.value.toString());
}
