import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/my_string.dart';
import '../../utils/size_config.dart';
import '../../utils/styles.dart';

import '../widgets/home_widgets/circule_image_avatar.dart';
import '../widgets/utils_widgets/height_size_box.dart';

class DoctorsDetailsScreen extends StatelessWidget {
  DoctorsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      decoration: buildBoxDecoration(context),
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
                                        color: Theme.of(context).textTheme.headline3!.color,
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

                          Text("Dr." + "Walter White",style: Theme.of(context).textTheme.headline2,),
                          HeightSizeBox(Get.width * .01),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "The textDirection argument defaults to the ambient Directionality, if any. If there is no ambient directionality, and a text direction is going to be necessary to disambiguate start or end values for the crossAxisAlignment, the textDirection must not be null.",
                              style: Theme.of(context).textTheme.headline4,
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
                child: Text("Doctor Reviews",style: Theme.of(context).textTheme.headline4,),
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
                color: Colors.black12.withOpacity(0.5),
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
              : Center(
                  child: Text(
                    "Add review".tr,
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

  BoxDecoration buildBoxDecoration(@required context) {
    return BoxDecoration(

        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),

      ],
      color: Theme.of(context).canvasColor,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    );
  }
}
