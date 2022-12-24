import 'package:flutter/material.dart';
import 'package:shamo/pages/detail_page.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/models/space.dart';

class SpaceCard extends StatelessWidget {
  final Space space;
  SpaceCard(this.space);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              space: space,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: edge),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 130,
                  height: 110,
                  child: Stack(
                    children: [
                      Image.asset(space.imageUrl ?? 'assets/space1.png'),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                            color: purpleColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon_star.png',
                                width: 22,
                                height: 22,
                              ),
                              Text(
                                '${space.rating}/5',
                                style: whiteTextStyle.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //text disamping
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${space.name}',
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text.rich(
                    TextSpan(
                      text: '\$${space.price}',
                      style: purpleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: '/month',
                          style: greyTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '${space.city},${space.country}',
                    style: greyTextStyle.copyWith(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
