import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  TextEditingController phoneNumberController = TextEditingController();

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
                    // Add your form key and other form elements here
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Your login text and form elements here
                        KTextUtils(
                          text: "Login",
                          size: 35,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.bold,
                          textDecoration: TextDecoration.none,
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        // Country code picker
                        CountryCodePicker(
                          onChanged: (code) {
                            // Handle country code change
                          },
                          initialSelection: 'US',
                          // Set your initial country here
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        // Phone number text field
                        AuthTextFromField(
                          prefixIcon: Icon(
                            Icons.phone_android,
                            color: grey,
                          ),
                          suffixIcon: Text(""),
                          controller: phoneNumberController,
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
                          hintText: 'Phone number',
                          textInputType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        // Your login button here
                        Align(
                          alignment: Alignment.center,
                          child: AuthButton(
                              onPressed: () {
                                Get.to(
                                  () => PinCodeVerificationScreen(
                                    phoneNumber: "+0011001",
                                  ),
                                  transition: Transition.rightToLeft,
                                  duration: Duration(milliseconds: 1000),
                                );
                              },
                              text: true
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
                              width: width * .8),
                        ),
                        SizedBox(
                          height: 30,
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
