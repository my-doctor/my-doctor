import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/view/widgets/home_widgets/circule_image_avatar.dart';

import '../../../controller/controllers/settings_controller.dart';
import '../../../model/user_model.dart';

class DoctorSwitchRequistListScreen extends StatelessWidget {
  DoctorSwitchRequistListScreen({Key? key}) : super(key: key);

  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text("check requests".tr),
        centerTitle: true,
      ),
      body: Obx(() {
        return controller.doctorsRequistList.length == 0
            ? Center(
                child: Text("theres no doctor requist"),
              )
            : ListView.builder(
                itemCount: controller.doctorsRequistList.length,
                itemBuilder: (BuildContext context, int index) {
                  UserModel doctor = controller.doctorsRequistList.value[index];
                  return DoctorRequestTile(
                    doctor: doctor,
                    function: () {
                      controller.confirmDoctorRequest(controller
                          .doctorsRequistList.value[index].phoneNumber);
                    },
                    isL: controller.isLoading,
                    function2: () {
                      controller.deleteDoctorAccount(controller
                          .doctorsRequistList.value[index].phoneNumber);
                    },
                    isL2: controller.isdeleteLoading,
                  );
                },
              );
      }),
    );
  }
}

class DoctorRequestTile extends StatelessWidget {
  final UserModel doctor;
  final Function() function;
  final Function() function2;
  RxBool isL;
  RxBool isL2;

  DoctorRequestTile({
    Key? key,
    required this.doctor,
    required this.function,
    required this.function2,
    required this.isL,
    required this.isL2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      builder: (_) {
        return ExpansionTile(
          title: Text(doctor.displayName ?? ""),
          children: [
            CirculeImageAvatar(
                imageUrl: doctor.profileUrl!, width: Get.width * .3),
            ListTile(
              title: Text("Email: ${doctor.email ?? ""}"),
            ),
            ListTile(
              title: Text("Phone Number: ${doctor.phoneNumber ?? ""}"),
            ),
            ListTile(
              title: Text("Bio: ${doctor.bio ?? ""}"),
            ),
            ListTile(
              title: Text("Specialty: ${doctor.specialet ?? ""}"),
            ),
            ListTile(
              title: Text("Clinic Address: ${doctor.clinicAddress ?? ""}"),
            ),
            ListTile(
              title: Text(
                  "Available Work Days: ${doctor.availableWorkDays ?? ""}"),
            ),
            ListTile(
              title: Text("Work Start Hour: ${doctor.workStartHour ?? ""}"),
            ),
            ListTile(
              title: Text("Work End Hour: ${doctor.workEndHour ?? ""}"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: function,
                  child:
                      isL.value ? CircularProgressIndicator() : Text("Confirm"),
                ),
                ElevatedButton(
                  onPressed: function2,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent),
                  ),
                  child:
                      isL2.value ? CircularProgressIndicator() : Text("cancel"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
