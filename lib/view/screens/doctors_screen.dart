import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/utils/my_string.dart';

import '../../controller/controllers/home_controller.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../widgets/home_widgets/doctor_card.dart';
import '../widgets/utils_widgets/text_utils.dart';

class DoctorsBySpecialtiesScreen extends StatelessWidget {
  DoctorsBySpecialtiesScreen({
    super.key,
    required this.specialties,
    required this.specialtiesEn,
  });

  final controller = Get.put(HomeScreenController());

  String specialties;
  String specialtiesEn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        shadowColor: Colors.black,
        elevation: 2,
        title: Text(
          specialties ?? "",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: controller.doctorsList.isNotEmpty
            ? GetX<HomeScreenController>(
                initState: (_) => controller.getDoctorsInfoByS(specialtiesEn),
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: controller.doctorsListBySpecialet.isNotEmpty
                        ? ListView.builder(
//                    padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            //                  shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.doctorsListBySpecialet.length
                                .toInt(),
                            // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            //     childAspectRatio: 1, maxCrossAxisExtent: 200),
                            itemBuilder: (context, index) {
                              return DoctorCard(
                                imageUrl: controller
                                    .doctorsListBySpecialet[index].profileUrl,
                                name: controller
                                    .doctorsListBySpecialet[index].displayName,
                                description: controller
                                    .doctorsListBySpecialet[index].bio,
                                uid: controller
                                    .doctorsListBySpecialet[index].uid,
                                doctorInfo:
                                    controller.doctorsListBySpecialet[index], averageRatingValue:controller
                                  .doctorsListBySpecialet[index].averageRatingValue,
                              );
                            })
                        : SizedBox(
                            child: Center(
                              child: Text(
                                "Theres no doctors yet",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ),
                  );
                },
              )
            : SizedBox(
                child: Center(
                  child: KTextUtils(
                      text: "Theres no doctors ",
                      size: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      textDecoration: TextDecoration.none),
                ),
              ),
      ),
    );
  }
}
