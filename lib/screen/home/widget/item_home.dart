// ignore_for_file: avoid_returning_null_for_void

import 'package:submis_f2/data/model/restaurant.dart';
import 'package:submis_f2/utils/resource/rescolor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget itemHome(Restaurant restaurant) {
  return SizedBox(
    width: 250,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
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
                  child: CachedNetworkImage(
                    imageUrl: restaurant.pictureId != null
                        ? "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}"
                        : "",
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: ResColor.blue,
                        ),
                      ),
                    ),
                    errorWidget: (context, object, stackTrace) =>
                        const Icon(Icons.error),
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
                      fontWeight: FontWeight.w600,
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
