import 'package:submis_fl1/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget itemHome(Restaurant restaurant) {
  return SizedBox(
    width: 250,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: restaurant.pictureId ?? "",
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: Image.network(
                    restaurant.pictureId ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  RatingBar.builder(
                    glowRadius: 0,
                    unratedColor: Colors.transparent,
                    initialRating: (restaurant.rating ?? 0),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 16,
                    itemBuilder: (context, _) => const Text(
                      "⭐",
                      style: TextStyle(
                        fontSize: 5,
                      ),
                    ),
                    // ignore: avoid_returning_null_for_void
                    onRatingUpdate: (rating) => null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
