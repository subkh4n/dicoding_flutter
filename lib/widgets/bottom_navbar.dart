import 'package:flutter/material.dart';
import 'package:shamo/theme.dart';

class BottomNavbarItem extends StatelessWidget {
  final String? imageUrl;
  final bool? isActive;

  BottomNavbarItem({this.imageUrl, this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(
          imageUrl ?? 'assets/icon_home.png',
          width: 26,
        ),
        Spacer(),
        (isActive ?? true)
            ? Container(
                width: 30,
                height: 2,
                decoration: BoxDecoration(
                  color: purpleColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(1000),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
