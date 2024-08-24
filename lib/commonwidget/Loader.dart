import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

categoriesLoader(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: MediaQuery.of(context).platformBrightness == Brightness.light
        ? Colors.grey
        : Colors.grey.shade800,
    highlightColor:
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.grey.withOpacity(0.5)
            : Colors.black38,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: const Color(0xffFFFFFF).withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration:
                const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 15,
            width: 50,
            color: Colors.grey,
          )
        ],
      ),
    ),
  );
}
