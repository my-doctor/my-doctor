import 'package:flutter/material.dart';

class AppIconAndName extends StatelessWidget {
  Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 75,
          width: 75,
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(39)),
            child: Image.asset(
              "assets/images/appicon.png",
              colorBlendMode: BlendMode.hue,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "myDoctor",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: "Cairo",
              ),
            ),
            Text(
              "Keep Talking..",
              style: TextStyle(
                  fontSize: 14, color: color, fontStyle: FontStyle.italic),
            ),
          ],
        )
      ],
    );
  }

  AppIconAndName({
    required this.color,
  });
}
