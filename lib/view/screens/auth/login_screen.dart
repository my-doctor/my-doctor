import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/my_string.dart';
import '../../../utils/size_config.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_from_field.dart';
import '../../widgets/auth/pin_put_widget.dart';
import '../../widgets/on_boarding_widgets/app_icon_and_name.dart';
import '../../widgets/utils_widgets/text_utils.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final controller = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

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
                const SizedBox(height: 50),
                // Your AppIconAndName widget here

                SizedBox(
                  height: 15,
                ),
                AppIconAndName(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 65,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KTextUtils(
                          text: "Login",
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
                            return AuthTextFromField(
                              prefixIcon: CountryCodePicker(
                                flagWidth: Get.width * .05,
                                onChanged: (code) {
                                  controller.updateCountryCode(code.dialCode!);
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
                                  return 'Please enter mobile number';
                                } else if (!RegExp(validationPhone)
                                    .hasMatch(value)) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
                              hintText: 'xxx xxx xxxx',
                              textInputType: TextInputType.phone,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
                                  return "Password is too short";
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'Password',
                              textInputType: TextInputType.visiblePassword,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.forgotPassword);
                                },
                                child: KTextUtils(
                                  text: "Forget Password",
                                  size: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  textDecoration: TextDecoration.underline,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * .1,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GetBuilder<AuthController>(builder: (_) {
                            return AuthButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    String email = emailController.text.trim();
                                    String password = passwordController.text;
                                    String phoneNumber =
                                        controller.countryCode.value +
                                            phoneController.text;
                                    controller.loginUsingFirebase(
                                        phoneNumber: phoneNumber,
                                        password: password);
                                  }
                                },
                                text: controller.isLoading == false
                                    ? Text(
                                        "Login",
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
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // نص sign up
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KTextUtils(
                              text: "Don’t have an account?",
                              size: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              textDecoration: TextDecoration.none,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.patientRegisterScreen);
                                },
                                child: KTextUtils(
                                  text: "SignUp",
                                  size: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  textDecoration: TextDecoration.underline,
                                ))
                          ],
                        ),

                        // Your sign up text and button here
                      ],
                    ),
                  ),
                ),
                // Your additional widgets here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
