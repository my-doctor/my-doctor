import 'package:get/get.dart';
import '../controllers/add_doctor_controller.dart';

class AddDoctorBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>AddDoctorController() ,fenix: false);
  }

}