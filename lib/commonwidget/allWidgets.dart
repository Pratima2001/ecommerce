import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce1/data/models/productModule.dart';
import 'package:ecommerce1/services/userService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/products/productDetails.dart';

backArrow(BuildContext context) {
  return NeumorphicButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: const NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      padding: const EdgeInsets.all(7.0),
      child: Icon(
        Icons.arrow_back,
      ));
}

ratingView(String rating, int percent) {
  return SizedBox(
    height: 30,
    child: Row(
      children: [
        Text(
          rating,
          style: GoogleFonts.aBeeZee(fontSize: 12),
        ),
        const SizedBox(
          width: 5,
        ),
        const Icon(
          Icons.star,
          color: Color(0xff508A7B),
          size: 15,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(child: SizedBox(height: 10, child: ratingIndicator(percent))),
        const SizedBox(
          width: 10,
        ),
        Text(
          "$percent %",
          style: GoogleFonts.aBeeZee(fontSize: 12),
        ),
      ],
    ),
  );
}

ratingIndicator(int value) {
  return FAProgressBar(
    currentValue: value.toDouble(),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    size: 15,
    backgroundColor: Colors.grey.withOpacity(0.3),
    progressColor: const Color(0xff508A7B),
    animatedDuration: const Duration(seconds: 1),
    direction: Axis.horizontal,
  );
}

productView2(BuildContext context, Product product,
    ProductServices productServices, int c, Function onQuantityChanged) {
  int count = c;
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    height: 120,
    decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 5, // Spread radius of the shadow
            blurRadius: 10, // Blur radius of the shadow
            offset: const Offset(0, 3), // Shadow position (dx, dy)
          ),
        ],
        // color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(25))),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          width: 120,
          height: 120,
          child: CachedNetworkImage(
            width: double.infinity,
            imageUrl: product.images[0],
            fit: BoxFit.scaleDown,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10),
                height: 30,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        productServices.removeProductFromCart(product);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "\$${product.price}",
                style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Size: L | Color: White",
                      style:
                          GoogleFonts.aBeeZee(color: const Color(0xff8A8A8F)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff8A8A8F)),
                          borderRadius: BorderRadius.circular(30)),
                      margin: const EdgeInsets.only(left: 10),
                      width: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (c <= product.stock) {
                                c += 1;
                                bool status =
                                    await productServices.changeProductCount(
                                        context, c, product.id.toString());
                                print("after$c");
                                if (status) onQuantityChanged();
                              } else {
                                showErrorDialog(context,
                                    "Only ${product.stock} items available in stock");
                              }
                            },
                            child: const Icon(
                              Icons.add,
                              color: Color(0xff8A8A8F),
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            count.toString(),
                            style: GoogleFonts.aBeeZee(
                                color: const Color(0xff8A8A8F)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              if (c != 1) {
                                c -= 1;
                                bool status =
                                    await productServices.changeProductCount(
                                        context, c, product.id.toString());
                                if (status) onQuantityChanged();
                              }
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Color(0xff8A8A8F),
                              size: 15,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ))
      ],
    ),
  );
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

recommenedProductWidget(Product product, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetails(
                product: product,
              )));
    },
    child: Container(
      width: 250,
      padding: const EdgeInsets.symmetric(vertical: 2),
      margin: const EdgeInsets.only(right: 15),
      child: Material(
          elevation: 0.8,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          surfaceTintColor: Colors.grey,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: 70,
                child: CachedNetworkImage(
                  width: double.infinity,
                  imageUrl: product.images[0],
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.aBeeZee(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "\$${product.price}",
                    style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
                  )
                ],
              ))
            ],
          )),
    ),
  );
}

loadingWidget(BuildContext context) {
  return Container(
      height: 100,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 1 / 4,
      ),
      child: const Column(
        children: [CircularProgressIndicator()],
      ));
}

orderCard(BuildContext context, Map product) {
  return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 230,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 5, // Spread radius of the shadow
              blurRadius: 10, // Blur radius of the shadow
              offset: const Offset(0, 3), // Shadow position (dx, dy)
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 15),
              height: 50,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "OrderId#${product['transactId']}",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(product['transactionDate'].toString())
                    ],
                  ),
                ],
              )),
          RichText(
              text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Tracking Number: ', // Different style
                style: GoogleFonts.aBeeZee(
                    fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              TextSpan(
                text: product['transactId'], // Different style
                style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
              ),
            ],
          )),
          Container(
            margin: const EdgeInsets.only(top: 15),
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      )),
                  width: 120,
                  height: 120,
                  child: CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: product['images'][0],
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 10, top: 20),
                        child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: product['title'], // Different style
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      " \$${product['price']}", // Different style
                                  style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Size: L | Color: White",
                              style: GoogleFonts.aBeeZee(
                                  color: const Color(0xff8A8A8F)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, right: 15),
                        child: Row(
                          children: [
                            RichText(
                                text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Quantity: ', // Different style
                                  style:
                                      GoogleFonts.aBeeZee(color: Colors.grey),
                                ),
                                TextSpan(
                                  text: product['count']
                                      .toString(), // Different style
                                  style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            )),
                            const SizedBox(
                              width: 15,
                            ),
                            RichText(
                                text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Subtotal: ', // Different style
                                  style:
                                      GoogleFonts.aBeeZee(color: Colors.grey),
                                ),
                                TextSpan(
                                  text: double.parse(
                                          (product['price'] * product['count'])
                                              .toString())
                                      .toStringAsFixed(1)
                                      .toString(), // Different style
                                  style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "SUCCESS",
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.green),
                      )
                    ],
                  ),
                ))
              ],
            ),
          )
        ],
      ));
}
