import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controllers/add_doctor_controller.dart';
import '../../../controller/controllers/auth_controller.dart';
import '../../../utils/constants.dart';
import '../../../utils/my_string.dart';
import '../../../utils/size_config.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_from_field.dart';
import '../../widgets/home_widgets/circule_image_avatar.dart';
import '../../widgets/utils_widgets/height_size_box.dart';

class AddDoctorInfoScreen extends StatelessWidget {
    AddDoctorInfoScreen({super.key});
  final formUpdateKey = GlobalKey<FormState>();
    final controller = Get.put(AddDoctorController());
    final cc = Get.put(AuthController());
    final TextEditingController nameController = TextEditingController();
    final TextEditingController bioController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text("fill information".tr),
        centerTitle: true,
      ),      body: Container(
      height: Get.height*.8,
      decoration: const BoxDecoration(

      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Form(
            key: formUpdateKey,
            child: Column(
              children: [
                HeightSizeBox(20),
                GetBuilder<AddDoctorController>(
                  builder: (_) {
                    return Stack(
                      children: [
                        CirculeImageAvatar(
                          width: SizeConfig.width! * .28,
                          imageUrl: "data.profileUrl!",
                          color: Colors.white,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: white.withOpacity(.8),
                            maxRadius: SizeConfig.defaultSize! * 1,
                            child: IconButton(
                              onPressed: () {
                                controller.getImage();
                              },
                              icon: Icon(
                                Icons.edit,
                                color: black,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                HeightSizeBox(SizeConfig.defaultSize!),
                AuthTextFromField(
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
                  hintText: "Full name",
                  textInputType: TextInputType.name,
                  suffixIcon: Text(""),
                  prefixIcon: Icon(
                    Icons.account_circle_outlined,
                    color: white,
                  ),
                ),
                HeightSizeBox(SizeConfig.defaultSize!),
                AuthTextFromField(
                  controller: bioController,
                  obscureText: false,
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Please enter bio';
                    } else {
                      return null;
                    }
                  },
                  hintText: "bio",
                  textInputType: TextInputType.name,
                  suffixIcon: Text(""),
                  prefixIcon: Icon(
                    Icons.insert_drive_file_outlined,
                    color: white,
                  ),
                ),
                HeightSizeBox(SizeConfig.defaultSize!),
                AuthTextFromField(
                  controller: phoneController,
                  obscureText: false,
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Please enter mobile number';
                    } else if (!RegExp(validationPhone).hasMatch(value)) {
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
                  hintText: "Phone number",
                  textInputType: TextInputType.phone,
                  suffixIcon: Text(""),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: white,
                  ),
                ),
                HeightSizeBox(SizeConfig.defaultSize!),
                AuthTextFromField(
                  controller: emailController,
                  obscureText: false,
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Please enter email';
                    } else if (!RegExp(validationEmail).hasMatch(value)) {
                      return "Invalid Email";
                    } else {
                      return null;
                    }
                  },
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: white,
                  ),
                  suffixIcon: Text(""),
                ),
                HeightSizeBox(SizeConfig.defaultSize!),
                HeightSizeBox(SizeConfig.defaultSize! * 2),
                GetBuilder<AddDoctorController>(
                  builder: (_) {
                    return GetBuilder<AuthController>(
                      builder: (_) {
                        return AuthButton(
                            onPressed: () {
                              if (formUpdateKey.currentState!.validate()) {
                                //     cc.auth.currentUser!.updateEmail(emailController.text);

                                controller
                                    .updateUserImageStorage(
                                    "data.uid!",
                                    "data.profileUrl!",
                                    nameController.text,
                                    phoneController.text,
                                    emailController.text,
                                    Get.arguments[1],
                                    bioController.text,
                                    context)
                                    .then((value) {
                                  cc.updateUserEmail(emailController.text);
                                });
                              }
                            },
                            text: controller.isLoading == true
                                ? CircularProgressIndicator()
                                : Text("Update",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            width: SizeConfig.width! * .7);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
