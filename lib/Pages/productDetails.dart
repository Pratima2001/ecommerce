import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce1/commonwidget/allWidgets.dart';
import 'package:ecommerce1/data/models/productModule.dart';
import 'package:ecommerce1/services/userService.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../commonwidget/likeButton.dart';
import '../commonwidget/productWidget.dart';
import '../commonwidget/reviewWidget.dart';
import '../services/services.dart';

// ignore: must_be_immutable
class ProductDetails extends ConsumerStatefulWidget {
  Product product;
  ProductDetails({super.key, required this.product});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  ProductServices productServices = ProductServices();
  List<Color> colors = [
    Color(0xffE7C0A7),
    Color(0xff050302),
    Color(0xffEE6969)
  ];
  List sizes = ['S', 'M', 'L'];
  String selectedSize = 'S';
  Color selctedColor = const Color(0xffE7C0A7);
  @override
  Widget build(BuildContext context) {
    final similarProducts =
        ref.watch(categoryProductsProvider(widget.product.category));

    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: InkWell(
              onTap: () {
                productServices.addProductInCart(widget.product, context);
              },
              child: Container(
                height: 70,
                decoration: const BoxDecoration(
                    color: Color(0xff343434),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Add To Cart",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 17, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.grey.withOpacity(0.1),
                          height: MediaQuery.of(context).size.height / 2,
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            imageUrl: widget.product.images[0],
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 2 - 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.1), // Shadow color
                                  spreadRadius:
                                      5, // Spread radius of the shadow
                                  blurRadius: 10, // Blur radius of the shadow
                                  offset: const Offset(
                                      0, 3), // Shadow position (dx, dy)
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    widget.product.title,
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    '\$ ${widget.product.price}',
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: widget.product.rating,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Color(0xff508A7B),
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        unratedColor:
                                            Colors.grey.withOpacity(0.5),
                                        direction: Axis.horizontal,
                                      ),
                                      Text(
                                        "(83)",
                                        style:
                                            GoogleFonts.aBeeZee(fontSize: 12),
                                      )
                                    ],
                                  )),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xffF3F3F6)),
                                        top: BorderSide(
                                            color: Color(0xffF3F3F6)))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Color",
                                          style: GoogleFonts.aBeeZee(
                                              fontSize: 18,
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                        ),
                                        SizedBox(
                                            height: 50,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: colors.length,
                                                itemBuilder: (context, index) {
                                                  return colors[index] ==
                                                          selctedColor
                                                      ? InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selctedColor =
                                                                  colors[index];
                                                            });
                                                          },
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 10),
                                                            child:
                                                                NeumorphicButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              style:
                                                                  const NeumorphicStyle(
                                                                shape:
                                                                    NeumorphicShape
                                                                        .flat,
                                                                boxShape:
                                                                    NeumorphicBoxShape
                                                                        .circle(),
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Container(
                                                                width: 35,
                                                                height: 35,
                                                                decoration: BoxDecoration(
                                                                    color: colors[
                                                                        index],
                                                                    shape: BoxShape
                                                                        .circle),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selctedColor =
                                                                  colors[index];
                                                            });
                                                          },
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 10),
                                                            width: 35,
                                                            height: 35,
                                                            decoration: BoxDecoration(
                                                                color: colors[
                                                                    index],
                                                                shape: BoxShape
                                                                    .circle),
                                                          ),
                                                        );
                                                }))
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Size",
                                          style: GoogleFonts.aBeeZee(
                                              fontSize: 18,
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                        ),
                                        SizedBox(
                                            height: 50,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: sizes.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedSize =
                                                            sizes[index];
                                                      });
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 3),
                                                        width: 40,
                                                        height: 40,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: sizes[
                                                                        index] !=
                                                                    selectedSize
                                                                ? const Color(
                                                                        0xffC5C5C5)
                                                                    .withOpacity(
                                                                        0.5)
                                                                : const Color(
                                                                    0xff515151),
                                                            shape: BoxShape
                                                                .circle),
                                                        child: Text(
                                                          sizes[index],
                                                          style: GoogleFonts.aBeeZee(
                                                              fontSize: 14,
                                                              color: sizes[
                                                                          index] !=
                                                                      selectedSize
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ExpansionTile(
                                initiallyExpanded: true,
                                childrenPadding: EdgeInsets.zero,
                                shape: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(0.5)),
                                    bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.5))),
                                collapsedShape: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(0.5)),
                                    bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.5))),
                                tilePadding: EdgeInsets.zero,
                                title: Text(
                                  "Description",
                                  style: GoogleFonts.aBeeZee(fontSize: 17),
                                ),
                                enabled: true,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "${widget.product.description}\n",
                                      style: GoogleFonts.aBeeZee(),
                                    ),
                                  )
                                ],
                              ),
                              ExpansionTile(
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                childrenPadding: EdgeInsets.zero,
                                shape: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(0.5)),
                                    bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.5))),
                                tilePadding: EdgeInsets.zero,
                                title: Text(
                                  "Reviews",
                                  style: GoogleFonts.aBeeZee(fontSize: 17),
                                ),
                                enabled: true,
                                initiallyExpanded: true,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                widget.product.rating
                                                    .toString(),
                                                style: GoogleFonts.aBeeZee(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                " Out of 5",
                                                style: GoogleFonts.aBeeZee(
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              RatingBarIndicator(
                                                rating: widget.product.rating,
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Color(0xff508A7B),
                                                ),
                                                itemCount: 5,
                                                itemSize: 30.0,
                                                unratedColor: Colors.grey
                                                    .withOpacity(0.5),
                                                direction: Axis.horizontal,
                                              ),
                                              Text(
                                                "${widget.product.reviews.length} Ratings",
                                                style: GoogleFonts.aBeeZee(),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Column(
                                      children: [
                                        ratingView("5", 1),
                                        ratingView("4", 50),
                                        ratingView("3", 70),
                                        ratingView("2", 20),
                                        ratingView("1", 10)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      '${widget.product.reviews.length} Reviews',
                                      style: GoogleFonts.aBeeZee(fontSize: 15),
                                    ),
                                  ),
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: widget.product.reviews.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: ReviewWidget(
                                            username: widget.product
                                                .reviews[index].reviewerName,
                                            profileImageUrl:
                                                'https://via.placeholder.com/50', // Replace with your profile image URL
                                            reviewText: widget
                                                .product.reviews[index].comment,
                                            timeAgo: '2 hours ago',
                                            rating: widget
                                                .product.reviews[index].rating
                                                .toDouble(),
                                          ),
                                        );
                                      })
                                ],
                              ),
                              ExpansionTile(
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                childrenPadding: EdgeInsets.zero,
                                shape: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(0.5)),
                                    bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.5))),
                                collapsedShape: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(0.5)),
                                    bottom: BorderSide(
                                        color: Colors.grey.withOpacity(0.5))),
                                tilePadding: EdgeInsets.zero,
                                title: Text(
                                  "Similar Products",
                                  style: GoogleFonts.aBeeZee(fontSize: 17),
                                ),
                                enabled: true,
                                initiallyExpanded: true,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    height: 250,
                                    child: similarProducts.when(
                                      data: (products) => ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: products.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: 150,
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: ProductWidget(
                                                product: products[index],
                                                showLike: false,
                                                showRating: false,
                                              ),
                                            );
                                          }),
                                      loading: () =>
                                          const CircularProgressIndicator(),
                                      error: (err, stack) =>
                                          Text('Error: $err'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      backArrow(context),
                      LikeButton(
                        product: widget.product,
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
