import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String description;

  const CustomListTile({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: darkGrey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:  Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 8),
          Text(
            description,
            style:Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}

