import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/view/screens/medical_specialties.dart';

import '../../../controller/controllers/add_doctor_controller.dart';
import '../../../utils/constants.dart';
import '../utils_widgets/text_utils.dart';

class AddSpecialization extends StatelessWidget {
  AddSpecialization({Key? key}) : super(key: key);
  final addDoctorController = Get.put(AddDoctorController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<AddDoctorController>(
      builder: (_) {
        return InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: homeBackGroundColor,
              builder: (BuildContext context) {
                return ListView.builder(
                  itemCount: medicalSpecialtiesEn.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(medicalSpecialtiesEn[index]['name']!),
                      onTap: () {
                        Get.back(); //
                      addDoctorController.changeSpecialization(medicalSpecialtiesEn[index]['name']!);
                        addDoctorController.specialization =
                            medicalSpecialtiesEn[index]['name']!;
                      },
                    );
                  },
                );
              },
            );
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 1.3,
              ),
            ),
            child: KTextUtils(
              text: addDoctorController.specialization,
              size: 16,
              color: white,
              fontWeight: FontWeight.w700,
              textDecoration: TextDecoration.none,
            ),
          ),
        );
      },
    );
  }
}
