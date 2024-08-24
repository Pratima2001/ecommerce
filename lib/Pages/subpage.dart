import 'package:ecommerce1/commonwidget/allWidgets.dart';
import 'package:ecommerce1/commonwidget/productWidget.dart';
import 'package:ecommerce1/data/models/category.dart';
import 'package:ecommerce1/services/services.dart';

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SearchProducts extends ConsumerStatefulWidget {
  MainCategory? category;
  bool showAllProducts = false;
  bool showFeatured = false;
  bool showRecommended = false;

  SearchProducts(
      {super.key,
      this.category,
      this.showAllProducts = false,
      this.showFeatured = false,
      this.showRecommended = false});

  @override
  // ignore: library_private_types_in_public_api
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends ConsumerState<SearchProducts> {
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
    final categoryProducts = ref.watch((widget.showAllProducts ||
            widget.showRecommended ||
            widget.showFeatured)
        ? widget.showAllProducts
            ? allProducts
            : (widget.showRecommended)
                ? recommandedProducts
                : futureProducts
        : categoryProductsProvider(widget.category!.name));
    final searchState = ref.watch(searchProvider);

    final countNotifier = ref.read(countProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      countNotifier.state = count;
    });

    return SafeArea(
        child: Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        if (!widget.showAllProducts) ...[
                          backArrow(context),
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                        Text(
                          (widget.showAllProducts ||
                                  widget.showFeatured ||
                                  widget.showRecommended)
                              ? widget.showAllProducts
                                  ? "All Products"
                                  : widget.showRecommended
                                      ? 'Recommended Products'
                                      : "Featured Products"
                              : widget.category!.name,
                          style: GoogleFonts.aBeeZee(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: TextField(
                        controller: textEditingController,
                        onChanged: (s) {
                          if (s.isEmpty) {
                            setState(() {});
                          } else {
                            ref.read(searchProvider.notifier).search(s);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.2),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[600],
                            size: 25,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          // Add shadow for a subtle depth effect
                          isDense: true, // Less vertical space
                        ),
                      ),
                    ),
                    Consumer(builder: (context, ref, child) {
                      final count = ref.watch(countProvider);
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Found $count Results",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  height: 2.0),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              if (textEditingController.text.isEmpty) ...[
                Expanded(
                    child: categoryProducts.when(
                  loading: () {
                    return loadingWidget(context);
                  },
                  error: (error, stackTrace) {
                    return loadingWidget(context);
                  },
                  data: (products) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 0, // Spacing between columns
                      mainAxisSpacing: 20, // Spacing between rows
                      childAspectRatio:
                          1.5 / 2, // Aspect ratio of each item (width/height)
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      count = products.length;

                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ProductWidget(
                            product: products[index],
                            showLike: true,
                          ));
                    },
                    padding: const EdgeInsets.all(10),
                  ),
                )),
              ] else ...[
                if (searchState.isLoading)
                  const CircularProgressIndicator()
                else if (searchState.error.isNotEmpty)
                  Text('Error: ${searchState.error}')
                else
                  Expanded(
                    child: 
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 0, // Spacing between columns
                        mainAxisSpacing: 20, // Spacing between rows
                        childAspectRatio:
                            1.5 / 2, // Aspect ratio of each item (width/height)
                      ),
                      itemCount: searchState.results.length,
                      itemBuilder: (context, index) {
                        count = searchState.results.length;

                        return ProductWidget(
                          product: searchState.results[index],
                          showLike: true,
                        );
                      },
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
              ]
            ],
          )),
    ));
  }
}
