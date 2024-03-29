import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/utils/constants.dart';
import 'package:mydoctor/utils/my_string.dart';
import 'package:mydoctor/utils/size_config.dart';
import 'package:mydoctor/view/widgets/auth/auth_button.dart';
import 'package:mydoctor/view/widgets/utils_widgets/icon_botton_utils.dart';
import 'package:mydoctor/view/widgets/on_boarding_widgets/app_icon_and_name.dart';
import 'package:mydoctor/view/widgets/utils_widgets/text_utils.dart';

import '../../../controller/controllers/auth_controller.dart';
import '../../widgets/auth/auth_text_from_field.dart';

class ForgotPassword extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
   final TextEditingController passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final TextEditingController phoneController = TextEditingController();

  ForgotPassword({Key? key}) : super(key: key);

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
                        const SizedBox(
                          height: 30,
                        ),
                        GetBuilder<AuthController>(
                          builder: (_) {
                            return Directionality(
                              textDirection: TextDirection.ltr,
                              child: AuthTextFromField(
                                prefixIcon: CountryCodePicker(
                                  flagWidth: Get.width * .05,
                                  onChanged: (code) {
                                    controller
                                        .updateCountryCode(code.dialCode!);
                                  },
                                  initialSelection: 'IQ',
                                  // Set your initial country here
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                suffixIcon: SizedBox(),
                                controller: phoneController,
                                obscureText: false,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'Please enter mobile number'.tr;
                                  } else if (!RegExp(validationPhone)
                                      .hasMatch(value)) {
                                    return 'Please enter valid mobile number'
                                        .tr;
                                  }
                                  return null;
                                },
                                hintText: 'xxx xxx xxxx',
                                textInputType: TextInputType.phone,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
                              String phoneNumber =
                                  controller.countryCode.value +
                                      phoneController.text;
                              controller.resetPassword(
                                  phoneNumber: phoneNumber);
                            }
                          },
                          text: controller.isResetPass.value == false
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
