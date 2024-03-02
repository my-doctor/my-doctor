import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mydoctor/routes/routes.dart';
import 'package:badges/badges.dart' as badges;
import '../../../utils/my_string.dart';
import '../../controller/controllers/auth_controller.dart';
import '../../controller/controllers/settings_controller.dart';
import '../../controller/controllers/theme_controller.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../widgets/home_widgets/circule_image_avatar.dart';
import '../widgets/utils_widgets/height_size_box.dart';
import '../widgets/utils_widgets/text_utils.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = Get.height;
    final controller = Get.find<SettingController>();
    final authController = Get.put(AuthController());

    return Obx(() => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: h * .05),
                  controller.patientInfoModel.value == null
                      ? Center(
                          child: LinearProgressIndicator(),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CirculeImageAvatar(
                              imageUrl: controller
                                  .patientInfoModel.value!.profileUrl!,
                              width: SizeConfig.defaultSize! * 5,
                            ),
                            HeightSizeBox(SizeConfig.defaultSize! * .7),
                           !controller.isDoctor() || controller.isAdmin()
                                ? KTextUtils(
                                    text: controller
                                        .patientInfoModel.value!.displayName!,
                                    size: 22,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .color!,
                                    fontWeight: FontWeight.w700,
                                    textDecoration: TextDecoration.none)
                                : SizedBox(),
                            HeightSizeBox(SizeConfig.defaultSize! * .2),
                            KTextUtils(
                                text: controller
                                    .patientInfoModel.value!.phoneNumber!,
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
                  SizedBox(height: h * .03),
                  buildTextButtonIcon(
                      backColor: mainColor,
                      onPressed: () {
                        // ThemeController().changesTheme();
                        // controller.swithchValue.value =
                        // !controller.swithchValue.value;
                      },
                      icon: Icons.dark_mode,
                      iconColor: Colors.white,
                      label: !Get.isDarkMode ? "Dark Mode".tr : "Light Mode".tr,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      leading: Switch(
                        activeTrackColor:
                            Get.isDarkMode ? grey : mainColor.withOpacity(.4),
                        activeColor: Get.isDarkMode ? darkGrey : mainColor2,
                        value: controller.swithchValue.value,
                        onChanged: (value) {
                          ThemeController().changesTheme();
                          controller.swithchValue.value = value;
                        },
                      ),
                      context: context),
                  SizedBox(height: 20),
                  buildTextButtonIcon(
                      backColor: mainColor,
                      onPressed: () {},
                      icon: Icons.language_rounded,
                      iconColor: Colors.white,
                      label: "Language".tr,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      leading: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color:
                                Theme.of(context).textTheme.headline3!.color!,
                            width: 2,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            iconSize: 25,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  english.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .color!,
                                  ),
                                ),
                                value: ene,
                              ),
                              DropdownMenuItem(
                                child: Text(
                                  arabic.tr,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .color!,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                value: ara,
                              ),
                            ],
                            value: controller.langLocal,
                            onChanged: (value) {
                              controller.changeLanguage(value!);
                              Get.updateLocale(Locale(value));
                            },
                          ),
                        ),
                      ),
                      context: context),
                  SizedBox(height: 20),
                  controller.isDoctor()
                      ? buildTextButtonIcon(
                          backColor: mainColor,
                          onPressed: () {
                            Get.toNamed(Routes.addDoctorInfoScreen, arguments: [
                              controller.patientInfoModel.value,
                              patientsCollectionKey,
                              doctorsCollectionKey
                            ]);
                          },
                          icon: Icons.change_circle,
                          iconColor: Colors.white,
                          label: "Switch as a doctor".tr,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          context: context)
                      : controller.patientInfoModel.value!.isDoctorRequist!
                          ? buildTextButtonIcon(
                              backColor: mainColor,
                              onPressed: () {},
                              icon: Icons.access_time_filled_sharp,
                              iconColor: Colors.white,
                              label: "Your Requist under revision".tr,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              context: context)
                          : SizedBox(),
                  controller.isAdmin() ? SizedBox(height: 20) : SizedBox(),
                  controller.isAdmin()
                      ? Container(
                          alignment: Alignment.topLeft,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              controller.doctorsRequistList.length == 0
                                  ? Get.snackbar(
                                      "sorry", "theres no doctor requist")
                                  : Get.toNamed(
                                      Routes.doctorSwitchRequistListScreen,
                                    );
                            },
                            icon: Container(
                                width: SizeConfig.defaultSize! * 2.2,
                                height: SizeConfig.defaultSize! * 2.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: mainColor),
                                child: badges.Badge(
                                  stackFit: StackFit.expand,
                                  badgeContent: Text(
                                    controller.doctorsRequistList.length
                                        .toString(),
                                    style: TextStyle(color: white),
                                  ),
                                  child: Icon(
                                    Icons.notifications_active,
                                    color: Colors.white,
                                  ),
                                )),
                            label: Row(
                              children: [
                                Text("Show doctors requist".tr,
                                    style:
                                        Theme.of(context).textTheme.headline3),
                                Spacer(),
                                SizedBox()
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 20),
                  buildTextButtonIcon(
                      onPressed: () {
                        Get.defaultDialog(
                            onConfirm: () {
                              authController.signOutFromApp();
                            },
                            title: "Logout".tr,
                            textConfirm: "Yes".tr,
                            middleText: "Are you sure to Logout...!".tr,
                            confirmTextColor: Colors.white,
                            textCancel: "No".tr,
                            buttonColor: mainColor2,
                            cancelTextColor: mainColor2,
                            backgroundColor: white);
                      },
                      label: "Logout".tr,
                      icon: Icons.logout,
                      iconColor: Colors.red,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      backColor: Colors.transparent,
                      context: context),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }

  buildTextButtonIcon(
      {required Function()? onPressed,
      required String label,
      required IconData icon,
      Color? iconColor,
      Color? backColor,
      TextStyle? style,
      Widget? leading,
      required context}) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(10),
      ),
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
            Text(label, style: Theme.of(context).textTheme.headline3),
            Spacer(),
            leading ?? SizedBox()
          ],
        ),
      ),
    );
  }
}
