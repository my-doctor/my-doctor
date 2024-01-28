import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mydoctor/view/screens/medical_specialties.dart';
import 'package:mydoctor/view/screens/search_screen.dart';

import '../../view/screens/profile_screen.dart';

class HomeScreenController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    bottomSelectedIndex = 0;
    super.onInit();
  }

  List<Widget> patientScreens = [
    MedicalSpecialties(),
    SearchScreen(),
    SettingScreen(),
  ];

  int bottomSelectedIndex = 0;
  PageController pageController = PageController();

  void bottomTapped(int index) {
    bottomSelectedIndex = index;
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    update();
  }

  void pageChanged(int index) {
    bottomSelectedIndex = index;
    update();
  }
}
