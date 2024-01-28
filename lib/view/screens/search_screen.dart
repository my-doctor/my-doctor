import 'package:flutter/material.dart';
import 'package:mydoctor/view/widgets/utils_widgets/search_widget.dart';

import '../../utils/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: homeBackGroundColor,
        shadowColor: Colors.black,
        elevation: 2,
        title: Text(
          "البحث",
          style: TextStyle(fontWeight: FontWeight.w800, fontFamily: "Cairo"),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SearchWidget(),
            Text("Search Screen"),
          ],
        ),
      ),
    );
  }
}
