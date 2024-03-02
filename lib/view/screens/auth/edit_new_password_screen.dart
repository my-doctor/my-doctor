import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/auth_controller.dart';
import '../../../utils/constants.dart';
import '../../../utils/my_string.dart';
import '../../../utils/size_config.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_from_field.dart';
import '../../widgets/on_boarding_widgets/app_icon_and_name.dart';
import '../../widgets/utils_widgets/icon_botton_utils.dart';
import '../../widgets/utils_widgets/text_utils.dart';

class EditNewPasswordScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  String phoneNum = Get.arguments[0];
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
          mainColor2,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.1, 0.6, 1.9],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * .03,
                ),
                // الايكون back
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 3,
                    ),
                    KIconButtom(
                        icon: Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25,
                        function: () {
                          Get.back();
                        })
                  ],
                ),

                // الايكون back
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     SizedBox(
                //       width: 200,
                //     ),
                //     KIconButtom(
                //         icon: Icons.arrow_back_ios,
                //         color: Colors.white,
                //         size: 50,
                //         function: () {Get.back();})
                //   ],
                // ),
                // الصورة والنص
                AppIconAndName(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 15,
                ),
                // النص

                SizedBox(
                  height: 65,
                ),
                // نص ال login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KTextUtils(
                          text: "Reset Password".tr,
                          size: 30,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.bold,
                          textDecoration: TextDecoration.none,
                        ),
                        GetBuilder<AuthController>(
                          builder: (_) {
                            return AuthTextFromField(
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: white,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.visibility();
                                },
                                icon: controller.isVisibilty
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                color: mainColor3,
                              ),
                              controller: passwordController,
                              obscureText:
                                  controller.isVisibilty ? false : true,
                              validator: (value) {
                                if (value.toString().length < 6) {
                                  return "Password is too short".tr;
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'Password'.tr,
                              textInputType: TextInputType.visiblePassword,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //password
                        GetBuilder<AuthController>(
                          builder: (_) {
                            return AuthTextFromField(
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: white,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.visibility2();
                                },
                                icon: controller.isVisibilty2
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                color: mainColor3,
                              ),
                              controller: confirmPasswordController,
                              obscureText:
                                  controller.isVisibilty2 ? false : true,
                              validator: (value) {
                                if (confirmPasswordController.text.toString() !=
                                    passwordController.text.toString()) {
                                  return "The passwords must be identical".tr;
                                } else if (value.toString().length < 6) {
                                  return "Password is too short".tr;
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'confirm password'.tr,
                              textInputType: TextInputType.visiblePassword,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: height * .25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GetBuilder<AuthController>(builder: (_) {
                      return AuthButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.editNewPassword(
                                phoneNum,
                                passwordController.text,
                              );
                            }
                          },
                          text: controller.isEditNewPass.value == false
                              ? Text(
                                  "Reset".tr,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                )
                              : SizedBox(
                                  width: SizeConfig.defaultSize,
                                  height: SizeConfig.defaultSize,
                                  child: CircularProgressIndicator(
                                    color: mainColor,
                                  )),
                          width: MediaQuery.of(context).size.width / 1.3);
                    }),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                // نص sign up
              ],
            ),
          ),
        ),
      ),
    );
  }
}
