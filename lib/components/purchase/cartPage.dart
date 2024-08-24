import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce1/data/models/productModule.dart';
import 'package:ecommerce1/services/authService.dart';
import 'package:ecommerce1/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../commonwidget/allWidgets.dart';
import '../../data/notifiers/countNotifier.dart';
import 'checkout.dart';

class CartPage extends ConsumerStatefulWidget {
  bool showBackbutton = false;
  CartPage({super.key, required this.showBackbutton});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  ProductServices productServices = ProductServices();

  double price = 0.0;
  List<Map> list = [];
  bool showPrice = false;
  bool isLoading = true;
  List productIds = [];
  @override
  void initState() {
    super.initState();
    // Use PostFrameCallback to update count after the first frame is rendered
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = ref.watch(priceProvider);

    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: [
                    if (widget.showBackbutton) ...[
                      backArrow(context),
                    ] else ...[
                      const SizedBox(
                        width: 40,
                      )
                    ],
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(right: 40),
                            alignment: Alignment.center,
                            child: Text(
                              "Your Cart",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )))
                  ],
                ),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uuid)
                    .collection("cart")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    if (isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        isLoading = false;
                        showPrice = false;
                      });
                    });
                    return const Center(child: Text("You're cart is Empty"));
                  }

                  final documents = snapshot.data!.docs;
                  double totalPrice = 0.0;
                  productIds = [];
                  for (var doc in documents) {
                    final data = doc.data() as Map<String, dynamic>;
                    totalPrice += (data['count'] ?? 0) * (data['price'] ?? 0.0);
                    productIds.add(doc['id'].toString());
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (isLoading) {
                      setState(() {
                        isLoading = false;
                      });
                      showPrice = true;
                    }
                    ref.read(priceProvider.notifier).setPrice(totalPrice);
                  });

                  price = 0.0;
                  return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        final data = doc.data() as Map<String, dynamic>;
                        price += data['count'] * data['price'];

                        return productView2(
                          context,
                          Product.fromMap(data),
                          productServices,
                          data['count'],
                          () async {},
                        );
                      });
                },
              )),
              if (showPrice) ...[
                Container(
                  height: 270,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 5, // Spread radius of the shadow
                          blurRadius: 10, // Blur radius of the shadow
                          offset:
                              const Offset(0, 3), // Shadow position (dx, dy)
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Product Price",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 15, color: const Color(0xff8A8A8F)),
                            ),
                            Text(
                              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Shipping",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 15, color: const Color(0xff8A8A8F)),
                            ),
                            Text(
                              "Freeship",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "\$${totalPrice.toStringAsFixed(2)}",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CheckOut(products: productIds)));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: 250,
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xff343434),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              "Proceed to checkout",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 17, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ]
            ],
          ),
        ),
      )),
    );
  }
}
