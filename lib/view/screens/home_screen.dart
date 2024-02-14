import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controllers/home_controller.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../../utils/styles.dart';

class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});
    PageController pageController = PageController();
    final controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomeScreenController>(
      builder: (_) {
        return Scaffold(backgroundColor: Colors.white,
            body: PageView(
              onPageChanged: (val) {
                controller.pageChanged(val);
              },
              controller: controller.pageController,
              allowImplicitScrolling: true,
              scrollDirection: Axis.horizontal,
              children: controller.patientScreens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
               currentIndex: controller.bottomSelectedIndex,
              onTap: (index) {
                controller.bottomTapped(index);
              },

              items: [
                buildBottomNavigationBarItem(IconBroken.Home),
                buildBottomNavigationBarItem(IconBroken.Search),
                buildBottomNavigationBarItem(IconBroken.Setting),
               ],
            ));
      },
    );
  }


  BottomNavigationBarItem buildBottomNavigationBarItem(IconData iconData) {
    return BottomNavigationBarItem(
  //    backgroundColor: homeBackGroundColor,
      label: "",
      icon: Icon(
        iconData,
        size: SizeConfig.defaultSize! * 1.6,
      ),
    );
  }

}
