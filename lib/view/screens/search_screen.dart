import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/view/widgets/utils_widgets/search_widget.dart';

import '../../utils/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         shadowColor: Colors.black,
        elevation: 2,
        title: Text(
          "Search".tr,
         ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SearchWidget(),
            Text("Search Screen",style: Theme.of(context).textTheme.headline3,),
          ],
        ),
      ),
    );
  }
}
