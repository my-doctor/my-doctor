import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/home_controller.dart';
import '../../../utils/constants.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key}) : super(key: key);
  final controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * .03),
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          height: hight * .07,
          decoration: BoxDecoration(
              color: grey.withOpacity(.25),
              borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
            onChanged: (value) {
              controller.addSearchToList(value);
            },
            controller: controller.search,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.addSearchToList(
                      controller.search.text,
                    );
                    //////////////
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                hintText: "Search ...",
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: mainColor2, width: 2),
                    borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: mainColor2, width: 2),
                    borderRadius: BorderRadius.circular(25)),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: mainColor2, width: 2),
                    borderRadius: BorderRadius.circular(25))),
            validator: (value) {
              if (value!.isEmpty) {
                return 'search must not be null';
              }
              return null;
            },
            onFieldSubmitted: (val) {
              ////////////////////////
            },
          )),
    );
  }
}
