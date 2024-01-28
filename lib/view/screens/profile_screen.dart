import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mydoctor/utils/styles.dart';

import '../../../utils/my_string.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../widgets/home_widgets/circule_image_avatar.dart';
import '../widgets/utils_widgets/height_size_box.dart';
import '../widgets/utils_widgets/text_utils.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h=Get.height;
    return Scaffold(
      backgroundColor: homeBackGroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: h*.05),
          
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CirculeImageAvatar(
                    imageUrl: imageUrl,
                    width: SizeConfig.defaultSize! * 5,
                  ),
                  HeightSizeBox(SizeConfig.defaultSize! * .7),
                  KTextUtils(
                      text: "Walter White",
                      size: 22,
                      color: darkGrey,
                      fontWeight: FontWeight.w700,
                      textDecoration: TextDecoration.none),
                  HeightSizeBox(SizeConfig.defaultSize! * .2),
                  KTextUtils(
                      text: "walter@w.com",
                      size: 15,
                      color: grey,
                      fontWeight: FontWeight.w500,
                      textDecoration: TextDecoration.none)
                ],
              ),
              const Divider(
                thickness: 1,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(height: h*.07),
          
              buildTextButtonIcon(
                backColor: mainColor,
                onPressed: () {
                  //Get.to(() =>  UpdateProfile(),
                  //  arguments: [patientHomeScreenController.patientInfoModel.value,patientsCollectionKey]);
                },
                icon: Icons.edit,
                iconColor: Colors.white,
                label: '  Edit Profile    ',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 20),
              buildTextButtonIcon(
                backColor: mainColor,
                onPressed: () {},
                icon: Icons.messenger_outline_outlined,
                iconColor: Colors.white,
                label: '  Invite a friend   ',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 20),
          
              buildTextButtonIcon(
                backColor: mainColor,
                onPressed: () {},
                icon: Icons.dark_mode,
                iconColor: Colors.white,
                label: '  Dark Mode  ',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),              SizedBox(height: 20),

              buildTextButtonIcon(
                backColor: mainColor,
                onPressed: () {},
                icon: Icons.language_rounded,
                iconColor: Colors.white,
                label: '  Language   ',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 20),
              buildTextButtonIcon(
                backColor: mainColor,
                onPressed: () {},
                icon: Icons.help,
                iconColor: Colors.white,
                label: '  Help    ',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 20),              buildTextButtonIcon(
                backColor: mainColor,
                onPressed: () {},
                icon: Icons.help,
                iconColor: Colors.white,
                label: '  Switch as a doctor    ',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 20),
          
              buildTextButtonIcon(
                  onPressed: () {
                    Get.defaultDialog(
                        onCancel: () {
                          //        authController.signOutFromApp();
                        },
                        title: "Logout",
                        textConfirm: "No",
                        middleText: "Are you sure to Logout...!",
                        confirmTextColor: Colors.white,
                        textCancel: "Yes",
                        buttonColor: mainColor2,
                        cancelTextColor: mainColor2,
                        backgroundColor: white);
                  },
                  label: "LogOut",
                  icon: Icons.logout,
                  iconColor: Colors.red,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  backColor: Colors.transparent),
              // GetBuilder<AuthController>(
              //   builder: (_) {
              //     return TextButton.icon(
              //       onPressed: () {
              //         controller.signOutFromApp();
              //       },
              //       icon: Icon(
              //         Icons.logout,
              //         color: Colors.red,
              //         size: 30,
              //       ),
              //       label: Text(
              //         "LogOut",
              //         style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black54),
              //       ),
              //     );
              //   },
              // ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );

    //   Center(
    //     child: Column
    //       (mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SizedBox(height: 200,),
    //         Center(
    //           child: GetBuilder<AuthController>(
    //             builder: (_) {
    //               return InkWell(
    //                   onTap: () {
    //                     controller.signOutFromApp();
    //                   },
    //                   child: Text("LogOut"));
    //             },
    //           ),
    //         ),
    //         Center(
    //           child: GetBuilder< HomeScreenController>(
    //             builder: (_) {
    //               return InkWell(
    //                   onTap: () {
    //                      //patientHomeScreenController.getDooctorsInfo();
    //                   },
    //                   child: Text("DoctorData"));
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  buildTextButtonIcon({
    required Function()? onPressed,
    required String label,
    required IconData icon,
    Color? iconColor,
    Color? backColor,
    TextStyle? style,
  }) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Container(
            width: SizeConfig.defaultSize! * 2.2,
            height: SizeConfig.defaultSize! * 2.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: backColor),
            child: Icon(
              icon,
              color: iconColor,
            )),
        label: Row(
          children: [
            Text(label, style: style),
          ],
        ),
      ),
    );
  }
}
