import 'package:ecommerce1/services/userService.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce1/commonwidget/allWidgets.dart';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/authService.dart';

// ignore: must_be_immutable
class MyOrders extends ConsumerStatefulWidget {
  const MyOrders({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends ConsumerState<MyOrders> {
  ProductServices productServices = ProductServices();
  @override
  void initState() {
    super.initState();
  }

  final countProvider = StateProvider<int>((ref) => 0);
  int count = 0;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(
    BuildContext context,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "  My Orders",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uuid)
                    .collection("purchased")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
      
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
      
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text("You're Favourite list is Empty"));
                  }
      
                  final documents = snapshot.data!.docs;
      
                  return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        final data = doc.data() as Map<String, dynamic>;
      
                        return orderCard(
                          context,
                          data,
                        );
                      });
                },
              )),
            ])),
      )),
    );
  }
}
