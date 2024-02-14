import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/utils/constants.dart';
import 'package:mydoctor/utils/my_string.dart';
import 'package:mydoctor/view/widgets/auth/auth_button.dart';
import 'package:mydoctor/view/widgets/auth/auth_text_from_field.dart';

import 'package:mydoctor/view/widgets/utils_widgets/text_utils.dart';
import '../../../controller/controllers/auth_controller.dart';
import '../../widgets/on_boarding_widgets/app_icon_and_name.dart';
import '../../widgets/utils_widgets/icon_botton_utils.dart';

class PatientRegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  final controller = Get.find<AuthController>();

  PatientRegisterScreen({Key? key}) : super(key: key);

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .03,
              ),
              // الايكون back
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KIconButtom(
                        icon: Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                        function: () {
                          Get.back();
                        }),
                    KTextUtils(
                      text: "Register",
                      size: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      textDecoration: TextDecoration.none,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              AppIconAndName(
                color: Colors.black,
              ),
              SizedBox(
                height: height * .001,
              ),
              // الصورة
              SizedBox(
                height: height * .01,
              ),
              //النص

              Divider(
                color: Color(0xff4b455d),
                height: 10,
                endIndent: 70,
                indent: 55,
                thickness: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              // full name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * .1,
                      ),
                      AuthTextFromField(
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: white,
                        ),
                        suffixIcon: Text(""),
                        controller: nameController,
                        obscureText: false,
                        validator: (value) {
                          if (value.length == 0) {
                            return 'Please enter name';
                          } else if (value.toString().length <= 2 ||
                              !RegExp(validationName).hasMatch(value)) {
                            return "Enter valid name";
                          } else {
                            return null;
                          }
                        },
                        hintText: "Full Name",
                        textInputType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //Phone number
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
                      SizedBox(
                        height: 10,
                      ),
                      //Email address
                      // AuthTextFromField(
                      //   prefixIcon: Icon(
                      //     Icons.email_outlined,
                      //     color: white,
                      //   ),
                      //   suffixIcon: Text(""),
                      //   controller: emailController,
                      //   obscureText: false,
                      //   validator: (value) {
                      //     if (value.length == 0) {
                      //       return 'Please enter email';
                      //     } else if (!RegExp(validationEmail).hasMatch(value)) {
                      //       return "Invalid Email";
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      //   hintText: 'Email',
                      //   textInputType: TextInputType.emailAddress,
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),

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
                                controller.visibility();
                              },
                              icon: controller.isVisibilty
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              color: mainColor3,
                            ),
                            controller: passwordController,
                            obscureText: controller.isVisibilty ? false : true,
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
                            obscureText: controller.isVisibilty2 ? false : true,
                            validator: (value) {
                              if (confirmPasswordController.text.toString() !=
                                  passwordController.text.toString()) {
                                return "The passwords must be identical";
                              } else if (value.toString().length < 6) {
                                return "Password is too short";
                              } else {
                                return null;
                              }
                            },
                            hintText: 'confirm password',
                            textInputType: TextInputType.visiblePassword,
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Obx(
                        () {
                          return AuthButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  String name = nameController.text;

                                  String email = "email@e.com";
                                  String password = passwordController.text;
                                  String phoneNumber =
                                      controller.countryCode.value +
                                          phoneController.text;
                                  controller.registerWithPhoneNumber(
                                    name: name,
                                    email: email,
                                    password: password,
                                    phoneNumber: phoneNumber,
                                  );
                                }
                              },
                              text: controller.isLoading.value == false
                                  ? Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    )
                                  : SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: CircularProgressIndicator(
                                        color: mainColor,
                                      )),
                              width: width * .5);
                        },
                      ),

                      SizedBox(
                        height: height * .01,
                      ),

                      SizedBox(
                        height: height * .01,
                      ),

                      SizedBox(
                        height: height * .0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
