import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce1/Pages/ProductDetails.dart';
import 'package:ecommerce1/data/models/productModule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'likeButton.dart';

// ignore: must_be_immutable
class ProductWidget extends StatelessWidget {
  Product product;
  bool showLike = false;
  bool showRating = false;
  bool similarProWidegt = false;

  ProductWidget({
    super.key,
    required this.product,
    this.showLike = false,
    this.showRating = false,
    this.similarProWidegt = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetails(
                  product: product,
                )));
      },
      child: Container(
        padding: similarProWidegt
            ? const EdgeInsets.symmetric(vertical: 5, horizontal: 10)
            : EdgeInsets.zero,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                        color: similarProWidegt
                            ? Colors.transparent
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                CachedNetworkImageProvider(product.images[0]))),
                  ),
                  if (showLike) ...[
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, right: 5),
                        child: NeumorphicButton(
                            onPressed: () {},
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.circle(),
                            ),
                            padding: const EdgeInsets.all(7.0),
                            child: LikeButton(
                              product: product,
                            )),
                      ),
                    ),
                  ]
                ],
              )),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.title,
                style: GoogleFonts.aBeeZee(
                    fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 7,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '\$ ${product.price}',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' (${product.discountPercentage}%)',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              if (showRating) ...[
                RatingBarIndicator(
                  rating: product.rating,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Color(0xff508A7B),
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  unratedColor: Colors.grey.withOpacity(0.5),
                  direction: Axis.horizontal,
                ),
              ],
            ]),
      ),
    );
  }
}
