import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce1/commonwidget/allWidgets.dart';
import 'package:ecommerce1/commonwidget/productWidget.dart';
import 'package:ecommerce1/data/models/category.dart';
import 'package:ecommerce1/data/models/productModule.dart';
import 'package:ecommerce1/services/services.dart';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/authService.dart';

// ignore: must_be_immutable
class FavouriteProducts extends ConsumerStatefulWidget {
  FavouriteProducts({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends ConsumerState<FavouriteProducts> {
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

    return SafeArea(
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
                        "  Favourite Products",
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
                  .collection("favourite")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("You're cart is Empty"));
                }

                final documents = snapshot.data!.docs;

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 0, // Spacing between columns
                    mainAxisSpacing: 20, // Spacing between rows
                    childAspectRatio:
                        1.5 / 2, // Aspect ratio of each item (width/height)
                  ),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final data =
                        documents[index].data() as Map<String, dynamic>;

                    return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ProductWidget(
                          product: Product.fromMap(data),
                          showLike: true,
                        ));
                  },
                  padding: const EdgeInsets.all(10),
                );
              },
            )),
          ])),
    ));
  }
}
