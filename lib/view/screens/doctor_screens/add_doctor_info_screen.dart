import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/view/widgets/utils_widgets/upload_file_doctor.dart';

import '../../../controller/controllers/add_doctor_controller.dart';
import '../../../controller/controllers/auth_controller.dart';
import '../../../model/patint_info_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/my_string.dart';
import '../../../utils/size_config.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_from_field.dart';
import '../../widgets/home_widgets/circule_image_avatar.dart';
import '../../widgets/setting_widget/add_specialization.dart';
import '../../widgets/setting_widget/choose_available_days.dart';
import '../../widgets/utils_widgets/height_size_box.dart';
import '../../widgets/utils_widgets/text_utils.dart';

class AddDoctorInfoScreen extends StatelessWidget {
  AddDoctorInfoScreen({super.key});

  final formUpdateKey = GlobalKey<FormState>();
  final controller = Get.put(AddDoctorController());
  final cc = Get.put(AuthController());
  UserModel data = Get.arguments[0];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationAddress = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    nameController.text = data.displayName!;
    emailController.text = data.email!;
    phoneController.text = data.phoneNumber!;
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: Theme.of(context).iconTheme,
          title: Text("fill information".tr),
          centerTitle: true,
        ),
        body: Container(
          height: Get.height * .8,
          decoration: const BoxDecoration(),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: GetBuilder<AddDoctorController>(
              builder: (_) {
                return SingleChildScrollView(
                  child: Form(
                    key: formUpdateKey,
                    child: Column(
                      children: [
                        HeightSizeBox(20),
                        GetBuilder<AddDoctorController>(
                          builder: (_) {
                            return Stack(
                              children: [
                                controller.identityImageFile == null
                                    ? CirculeImageAvatar(
                                        width: SizeConfig.width! * .28,
                                        imageUrl:
                                            "https://firebasestorage.googleapis.com/v0/b/mydoctor-8f4ab.appspot.com/o/profile%20-%20Copy.png?alt=media&token=0233425a-970f-442f-857c-b44b18c0a309",
                                        color: Colors.white,
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          height: width * .25,
                                          width: width * .25,
                                          child: Image.file(
                                            controller.identityImageFile!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    backgroundColor: white.withOpacity(.8),
                                    maxRadius: SizeConfig.defaultSize! * 1,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.getIdentityImageFile();
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
                        // GetBuilder<AddDoctorController>(
                        //   builder: (_) {
                        //     return UploadFileDoctor(onPressed: () {
                        //       controller.getIdentityImageFile();
                        //     });
                        //   },
                        // ),
                        HeightSizeBox(SizeConfig.defaultSize!),
                        AddSpecialization(),
                        HeightSizeBox(SizeConfig.defaultSize!),
                        AuthTextFromField(
                          controller: nameController,
                          obscureText: false,
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Please enter name'.tr;
                            } else if (value.toString().length <= 2 ||
                                !RegExp(validationName).hasMatch(value)) {
                              return "Enter valid name".tr;
                            } else {
                              return null;
                            }
                          },
                          hintText: "Full name".tr,
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
                              return 'Please enter bio'.tr;
                            } else {
                              return null;
                            }
                          },
                          hintText: "bio".tr,
                          textInputType: TextInputType.name,
                          suffixIcon: Text(""),
                          prefixIcon: Icon(
                            Icons.insert_drive_file_outlined,
                            color: white,
                          ),
                        ),
                        // HeightSizeBox(SizeConfig.defaultSize!),
                        // AuthTextFromField(
                        //   controller: phoneController,
                        //   obscureText: false,
                        //   validator: (value) {
                        //     if (value.length == 0) {
                        //       return 'Please enter mobile number';
                        //     } else if (!RegExp(validationPhone)
                        //         .hasMatch(value)) {
                        //       return 'Please enter valid mobile number';
                        //     }
                        //     return null;
                        //   },
                        //   hintText: "Phone number",
                        //   textInputType: TextInputType.phone,
                        //   suffixIcon: Text(""),
                        //   prefixIcon: Icon(
                        //     Icons.phone_android,
                        //     color: white,
                        //   ),
                        // ),
                        HeightSizeBox(SizeConfig.defaultSize!),
                        AuthTextFromField(
                          controller: emailController,
                          obscureText: false,
                          validator: (value) {
                            if (value.length == 0) {
                              return 'Please enter email'.tr;
                            } else if (!RegExp(validationEmail)
                                .hasMatch(value)) {
                              return "Invalid Email".tr;
                            } else {
                              return null;
                            }
                          },
                          hintText: 'Email'.tr,
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: white,
                          ),
                          suffixIcon: Text(""),
                        ),
                        HeightSizeBox(SizeConfig.defaultSize!),
                        AuthTextFromField(
                          controller: locationAddress,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your location'.tr;
                            }
                            // Add custom validation rules here if needed
                            return null;
                          },
                          hintText: 'Location'.tr,
                          textInputType: TextInputType.streetAddress,
                          prefixIcon: Icon(
                            Icons.not_listed_location_outlined,
                            color: white,
                          ),
                          suffixIcon: Text(""),
                        ),
                        HeightSizeBox(SizeConfig.defaultSize!),
                        AuthTextFromField(
                          controller: notesController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your notes'.tr;
                            }
                            // Add custom validation rules here if needed
                            return null;
                          },
                          hintText: 'Notes'.tr,
                          textInputType: TextInputType.streetAddress,
                          prefixIcon: Icon(
                            Icons.note_add_sharp,
                            color: white,
                          ),
                          suffixIcon: Text(""),
                        ),
                        HeightSizeBox(SizeConfig.defaultSize!),
                        ChooseAvailableDays(
                          onChange: controller.convertListToString,
                        ),
                        HeightSizeBox(Get.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KTextUtils(
                                text: "from :",
                                size: Get.width * .04,
                                color: white,
                                fontWeight: FontWeight.bold,
                                textDecoration: TextDecoration.none),
                            InkWell(
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  controller.changeSelectedStartTime(
                                      value!.format(context).toString());
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: grey.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                child: KTextUtils(
                                    text: controller.from,
                                    size: Get.width * .06,
                                    color: darkGrey,
                                    fontWeight: FontWeight.bold,
                                    textDecoration: TextDecoration.none),
                              ),
                            ),
                          ],
                        ),
                        HeightSizeBox(Get.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KTextUtils(
                                text: "to :",
                                size: Get.width * .04,
                                color: white,
                                fontWeight: FontWeight.bold,
                                textDecoration: TextDecoration.none),
                            InkWell(
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  controller.changeSelectedEndTime(
                                      value!.format(context).toString());
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: grey.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                child: KTextUtils(
                                    text: controller.to,
                                    size: Get.width * .06,
                                    color: darkGrey,
                                    fontWeight: FontWeight.bold,
                                    textDecoration: TextDecoration.none),
                              ),
                            ),
                          ],
                        ),
                        HeightSizeBox(SizeConfig.defaultSize! * 2),
                        GetBuilder<AddDoctorController>(
                          builder: (_) {
                            return GetBuilder<AuthController>(
                              builder: (_) {
                                return AuthButton(
                                    onPressed: () {
                                      if (formUpdateKey.currentState!
                                              .validate() &&
                                          controller.formattedAvailableDays
                                                  .value !=
                                              "") {
                                        controller
                                            .updateUserImageStorage(
                                                data.uid!,
                                                data.profileUrl!,
                                                nameController.text,
                                                phoneController.text,
                                                emailController.text,
                                                controller.specialization,
                                                doctorsCollectionKey,
                                                bioController.text,
                                                context,
                                                data.password,
                                                locationAddress.text,
                                                controller
                                                    .formattedAvailableDays
                                                    .value,

                                                ///todo:add check on day not to be null
                                                notesController.text)
                                            .then((value) {
                                          cc.updateUserEmail(
                                              emailController.text);
                                        });
                                      } else {
                                        Get.snackbar(
                                          "Error",
                                          "Please Fill All Data",
                                          backgroundColor: Colors.red,
                                          colorText: white,
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      }
                                    },
                                    text: controller.isLoading == true
                                        ? CircularProgressIndicator()
                                        : Text("Update".tr,
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
