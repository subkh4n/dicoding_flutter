import 'package:submis_fl1/model/restaurant.dart';
import 'package:submis_fl1/screen/detail/widget/menus_sheet.dart';
import 'package:submis_fl1/utils/resource/rescolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  const DetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 70,
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            color: Colors.white,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Hero(
                      tag: restaurant.pictureId ?? "",
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            topLeft: Radius.circular(70),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ResColor.blue.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 2.5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(70),
                            topRight: Radius.circular(70),
                          ),
                          child: Image.network(
                            restaurant.pictureId ?? "",
                            fit: BoxFit.cover,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        elevation: 6,
                        shadowColor: ResColor.blue,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                builder: (context) {
                                  return menuSheet(restaurant.menus);
                                });
                          },
                          iconSize: 35,
                          icon: const Icon(
                            Icons.restaurant_menu,
                            color: ResColor.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Card(
                        elevation: 6,
                        shadowColor: ResColor.blue,
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 35,
                          icon: const Icon(
                            Icons.reviews,
                            color: ResColor.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Card(
                        elevation: 6,
                        shadowColor: ResColor.blue,
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 35,
                          icon: const Icon(
                            Icons.bookmark_outline,
                            color: ResColor.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.name ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        restaurant.city ?? "",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: ResColor.blue,
                        ),
                      ),
                    ],
                  ),
                  RatingBar.builder(
                    glowRadius: 0,
                    unratedColor: Colors.transparent,
                    initialRating: (restaurant.rating ?? 0),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 14,
                    itemBuilder: (context, _) => const Text(
                      "⭐",
                      style: TextStyle(
                        fontSize: 5,
                      ),
                    ),
                    // ignore: avoid_returning_null_for_void
                    onRatingUpdate: (rating) => null,
                  ),
                  const SizedBox(height: 10),
                  SafeArea(
                    top: false,
                    child: Text(
                      restaurant.description ?? "",
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
