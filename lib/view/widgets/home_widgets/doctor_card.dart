import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/user_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../screens/doctor_details_screens.dart';
import '../utils_widgets/text_utils.dart';

class DoctorCard extends StatelessWidget {
  String name;
  String description;
  String imageUrl;
  String uid;
  UserModel doctorInfo;
  int averageRatingValue;

  DoctorCard({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.uid,
    required this.doctorInfo,
    required this.averageRatingValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Card(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => DoctorsDetailsScreen(),
                    arguments: [uid, imageUrl, name, description, doctorInfo]);
              },
              child: ClipRRect(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: SizeConfig.defaultSize! * 7,
                    width: SizeConfig.defaultSize! * 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/animations/loading.gif",
                          image: imageUrl),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.defaultSize! * .3,
            ),
            Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: SizeConfig.defaultSize! * 8,
                  child:Text(
                       " " + name,style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: SizeConfig.defaultSize! * 8,
                  child: Text(
                    description  ,
                    style: TextStyle(
                      fontSize: 10,
                      color: grey,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * .5,
                ),
             averageRatingValue>5?SizedBox():   SizedBox(
                  width: SizeConfig.defaultSize! * 8,
                  child: buildRatingStars(averageRatingValue),
                ),
                SizedBox(
                  height: 5,
                ),
                // SizedBox(
                //   width: SizeConfig.defaultSize! * 7,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       KTextUtils(
                //           text: " \$ 200EGP",
                //           size: SizeConfig.defaultSize! * 0.58,
                //           color: black,
                //           fontWeight: FontWeight.w600,
                //           textDecoration: TextDecoration.none),
                //       Spacer(),
                //       SizedBox(
                //         height: SizeConfig.defaultSize! * 1.2,
                //         width: SizeConfig.defaultSize! * 4.2,
                //         child: ElevatedButton(
                //             style: ElevatedButton.styleFrom(
                //               padding: EdgeInsets.all(0),
                //               primary: mainColor2, // background
                //             ),
                //             onPressed: () {},
                //             child: KTextUtils(
                //                 text: "Bock Now",
                //                 size: SizeConfig.defaultSize! * .7,
                //                 color: white,
                //                 fontWeight: FontWeight.w800,
                //                 textDecoration: TextDecoration.none)),
                //       )
                //     ],
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildRatingStars(int averageRatingValue) {
    return Row(
      children: List.generate(
        5,
            (index) => Icon(
          index < averageRatingValue
              ? Icons.star
              : Icons.star_border,
          color: Colors.amber,
          size: 20,
        ),
      ),
    );
  }
}
