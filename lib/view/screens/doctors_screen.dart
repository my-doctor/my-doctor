import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor/utils/my_string.dart';

import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../widgets/home_widgets/doctor_card.dart';

class DoctorsBySpecialtiesScreen extends StatelessWidget {
  DoctorsBySpecialtiesScreen({super.key, required this.specialties});

  String specialties;

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 10,
              // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              //     childAspectRatio: 1, maxCrossAxisExtent: 200),
              itemBuilder: (context, index) {
                return DoctorCard(
                  imageUrl: imageUrl,
                  name: "Walter White",
                  description:
                      "The primary content of the scaffold.Displayed below the appBar, above the bottom of the ambient MediaQuery's MediaQueryData.viewInsets, and behind the floatingActionButton and drawer. If resizeToAvoidBottomInset is false then the body is not resized when the onscreen keyboard appears, i.e. it is not inset by viewInsets.bottom.",
                );
              }),
        ),
      ),
    );
  }
}
