import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/my_string.dart';
import '../../utils/size_config.dart';
import '../../utils/styles.dart';

import '../widgets/home_widgets/circule_image_avatar.dart';
import '../widgets/utils_widgets/height_size_box.dart';
import '../widgets/utils_widgets/text_utils.dart';

class DoctorsDetailsScreen extends StatelessWidget {
  DoctorsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBackGroundColor,
      body: SafeArea(
        child: DefaultTabController(
          length: 1,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      decoration: buildBoxDecoration(),
                      child: Column(
                        children: [
                          HeightSizeBox(Get.width * .03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.topLeft,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(
                                        IconBroken.Arrow___Left_2,
                                        color: black,
                                        size: Get.width * .089,
                                      )),
                                ],
                              ),
                              // SizedBox(
                              //   width: Get.width * .23,
                              // ),
                              Container(
                                  height: Get.width * .25,
                                  width: Get.width * .25,
                                  child: CirculeImageAvatar(
                                    imageUrl: imageUrl,
                                    width: SizeConfig.defaultSize! * 4,
                                  )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: Get.width * .089,),
                                ],
                              ),
                            ],
                          ),
                          HeightSizeBox(Get.width * .01),
                          KTextUtils(
                              text: "Dr." + "Walter White",
                              size: 21,
                              color: black,
                              fontWeight: FontWeight.w800,
                              textDecoration: TextDecoration.none),
                          HeightSizeBox(Get.width * .01),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "The textDirection argument defaults to the ambient Directionality, if any. If there is no ambient directionality, and a text direction is going to be necessary to disambiguate start or end values for the crossAxisAlignment, the textDirection must not be null.",
                              style: TextStyle(
                                color: darkGrey.withOpacity(.7),
                                fontWeight: FontWeight.w500,fontSize: 14
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: Container(
              child: Center(
                child: Text("Doctor Reviews"),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          height: Get.height * .06,
          width: Get.width * .6,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: mainColor2,
            borderRadius: BorderRadius.circular(20),
          ),
          child: false
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .1, vertical: Get.height * .028),
                  child: const LinearProgressIndicator(
                    color: white,
                  ),
                )
              : const Center(
                  child: Text(
                    "Add review",
                    style: TextStyle(
                        fontSize: 22,
                        color: white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 6,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      color: white,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    );
  }
}
