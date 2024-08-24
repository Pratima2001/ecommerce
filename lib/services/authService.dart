import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce1/commonwidget/allWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

String uuid = '';
Future<String> createAccount(
    String email, String password, BuildContext context) async {
  String uid = '';
  try {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': userCredential.user?.email,
        'uid': userCredential.user?.uid,
        'created_at':
            FieldValue.serverTimestamp(), // Timestamp of account creation
        'displayName': '', // Add more fields as necessary
      });
    }
    Navigator.pushReplacementNamed(context, '/compo');
    uid = userCredential.user?.uid ?? '';
    uuid = uid;
  } catch (e) {
    showErrorDialog(context, e.toString());
  }
  return uid;
}

void loginUser(String email, String password, BuildContext context) async {
  try {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    uuid = user!.uid;
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/compo');
    }
  } catch (e) {
    showErrorDialog(context, 'Error logging in: ${e.toString()}');
  } finally {}
}
