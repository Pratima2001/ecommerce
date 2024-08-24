import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce1/services/authService.dart';
import 'package:flutter/material.dart';

import '../data/models/productModule.dart';

class ProductServices {
  addProductInCart(Product product, BuildContext context) async {
    Map<String, dynamic> map = product.toMap();
    map.addAll({'count': 1});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("cart")
        .doc(product.id.toString())
        .set(map)
        .then((value) {
      Navigator.pushReplacementNamed(context, '/cart');
    });
  }

  removeProductFromCart(Product product) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("cart")
        .doc(product.id.toString())
        .delete();
  }

  Future<bool> changeProductCount(
      BuildContext context, int count, String id) async {
    bool status = false;
    try {
      await FirebaseFirestore.instance.collection('users').doc(uuid)
        ..collection("cart").doc(id).update({
          "count": count,
        }).then((value) {
          print("value updated");
        });
      status = true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating field: ${e.toString()}')),
      );
    }
    return status;
  }

  Future<bool> addProductsInLike(Product product) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("favourite")
        .doc(product.id.toString())
        .set(product.toMap());
    return true;
  }

  removeProductFromLike(Product product) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .collection("favourite")
        .doc(product.id.toString())
        .delete();
  }

  Future<bool> checkDocumentExists(String documentId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    bool exist = false;
    final DocumentReference documentRef = firestore
        .collection("users")
        .doc(uuid)
        .collection('favourite')
        .doc(documentId);

    try {
      final DocumentSnapshot docSnapshot = await documentRef.get();
      if (docSnapshot.exists) {
        exist = true;
        print("Document exists! Data:");
      }
    } catch (e) {
      exist = false;
    }
    print(exist);
    return exist;
  }
  
}
