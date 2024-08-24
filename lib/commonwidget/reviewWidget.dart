import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewWidget extends StatelessWidget {
  final String username;
  final String profileImageUrl;
  final String reviewText;
  final String timeAgo;
  double rating;

  ReviewWidget(
      {super.key, required this.username,
      required this.profileImageUrl,
      required this.reviewText,
      required this.timeAgo,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    "https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=2163"),
                radius: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  username,
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RatingBarIndicator(
                                  rating: rating,
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
                            ),
                            Text(
                              timeAgo,
                              style: GoogleFonts.aBeeZee(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            reviewText,
            style: GoogleFonts.aBeeZee(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
