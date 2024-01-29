import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/settings_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeScreenController() );
    Get.put(SettingController());
  }
}
