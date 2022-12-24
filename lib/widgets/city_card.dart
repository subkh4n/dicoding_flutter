import 'package:flutter/material.dart';
import 'package:shamo/models/city.dart';
import 'package:shamo/theme.dart';

class CityCard extends StatelessWidget {
  final City city;
  CityCard({required this.city});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: EdgeInsets.only(right: 5),
        child: Container(
          height: 150,
          width: 120,
          color: Color(0xffF6F7F8),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    city.imageurl ?? "${city.imageurl}",
                    errorBuilder: (context, error, stackTrace) {
                      return Container();
                    },
                    height: 120,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  (city.isPopular ?? false)
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                              color: purpleColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/icon_star.png",
                                width: 22,
                                height: 22,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              Text(
                city.name ?? "nama city tidak ada",
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
