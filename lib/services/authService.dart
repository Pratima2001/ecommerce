import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce1/commonwidget/allWidgets.dart';
import 'package:ecommerce1/data/models/userModule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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

Future<bool> loginUser(
    String email, String password, BuildContext context) async {
  bool loggedIn = false;
  try {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    uuid = user!.uid;
    loggedIn = true;
    Navigator.pushReplacementNamed(context, '/compo');
  } catch (e) {
    showErrorDialog(context, 'Error logging in: ${e.toString()}');
    loggedIn = false;
  } finally {}
  return loggedIn;
}

Future<bool> saveUserInfo(UserModule user) async {
  bool status = false;
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .set(user.toMap())
        .then((value) => {status = true});
  } catch (e) {}
  return status;
}

String generateRandomString(int length) {
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random.secure();
  return List.generate(
      length, (_) => characters[random.nextInt(characters.length)]).join();
}

Future<bool> addTransactReceipt(List list) async {
  bool status = false;
  print(list);
  for (int i = 0; i < list.length; i++) {
    DocumentReference documentRef = FirebaseFirestore.instance
        .collection("users")
        .doc(uuid)
        .collection('cart')
        .doc(list[i]);
    print(list[i]);
    try {
      final DocumentSnapshot docSnapshot = await documentRef.get();
      print('before error');
      print(docSnapshot.exists);
      var data = docSnapshot.data() as Map<String, dynamic>;
      String formattedDate1 = DateFormat('yyyy-MM-dd').format(DateTime.now());

      data.addAll({
        "status": "Success",
        "transactionDate": formattedDate1,
        "transactId": generateRandomString(12)
      });
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uuid)
          .collection("purchased")
          .doc(list[i])
          .set(data);
      documentRef.delete();
      status = true;
    } catch (e) {
      print(e);
    }
  }
  return status;
}
