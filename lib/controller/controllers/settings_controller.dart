import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/user_model.dart';
import '../../services/firestore_methods.dart';
import '../../utils/constants.dart';
import '../../utils/my_string.dart';

class SettingController extends GetxController {
  var swithchValue = false.obs;
  var storage = GetStorage();
  var langLocal = ene;
  final patientInfoModel = Rxn<UserModel>();

  GetStorage authBox = GetStorage();

  //Language

  @override
  void onInit() async {
    super.onInit();
    getUserData();
    getDoctorsInfoByS();
    getDoctorsRequistList();
    String c = authBox.read("auth") ?? "nothinbg";
    print("????????????????????????" + c);
    langLocal = await getLanguage;
    isAdmin();
  }

  bool isDoctor() {
    // Your logic to determine if the user is a doctor
    if (authBox.read("auth") == patientsCollectionKey) {
      return true;
    } else {
      return false;
    }
  }

  bool isAdmin() {
    // Your logic to determine if the user is a admin
    if (authBox.read("auth") == adminCollectionKey) {
      return true;
    } else {
      return false;
    }
  }

  RxBool isLoading = false.obs;

  confirmDoctorRequest(String phoneNumber) {
    isLoading.value = true;
    update();
    return FirebaseFirestore.instance
        .collection(doctorsCollectionKey)
        .doc(phoneNumber)
        .update({
      "isDoctor": true,
      "isDoctorRequist": false,
    }).then((value) async {
      Get.snackbar(
        "Updated ✔✔",
        "Doctor Confirmed Successfully",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
      isLoading.value = false;
      update();

      //  Navigator.pop(context);
      update();
    }).catchError((error) {
      isLoading.value = false;
      update();
      Get.snackbar(
        "Error",
        "$error",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    });
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection(authBox.read("auth"))
        .doc(authBox.read(KUid))
        .snapshots()
        .listen((event) {
      patientInfoModel.value = null;
      if (event.exists) {
        patientInfoModel.value = UserModel.fromMap(event);
      } else {
        Get.snackbar(
          "Notification", // Title
          "User data not found in Firebase", // Message
          backgroundColor: mainColor2,
          snackPosition: SnackPosition.TOP,
        );
      }
      //  update();
    });
  }

  RxList doctorsRequistList = [].obs;

  getDoctorsRequistList() async {
    await FireStoreMethods()
        .doctors
        .where('isDoctorRequist', isEqualTo: true)
        .snapshots()
        .listen((event) {
      doctorsRequistList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        doctorsRequistList.add(UserModel.fromMap(event.docs[i]));
      }
      update();
    });
    //   update();
  }

  void saveLanguage(String lang) async {
    await storage.write("lang", lang);
  }

  Future<String> get getLanguage async {
    return await storage.read("lang") ?? ene;
  }

  void changeLanguage(String typeLang) {
    saveLanguage(typeLang);
    if (langLocal == typeLang) {
      return;
    }

    if (typeLang == ara) {
      langLocal = ara;
      saveLanguage(ara);
    } else {
      langLocal = ene;
      saveLanguage(ene);
    }
    update();
  }

  RxList doctorsListBySpecialet = [].obs;

  getDoctorsInfoByS() async {
    //print(s);
    await FireStoreMethods().doctors.snapshots().listen((event) {
      doctorsListBySpecialet.clear();
      for (int i = 0; i < event.docs.length; i++) {
        print(event.docs[i]);
        doctorsListBySpecialet.add(UserModel.fromMap(event.docs[i]));
      }
    });

    //   update();
  }

  RxBool isdeleteLoading = false.obs;

  deleteDoctorAccount(String doctorID) async {
    isdeleteLoading.value = true;
    await FireStoreMethods().doctors.doc(doctorID).delete().then((value) {
      Get.snackbar("done", "account deleted successfully");
      isdeleteLoading.value = false;
    }).catchError((onError) {
      Get.snackbar("error", "${onError}");
      isdeleteLoading.value=false;

    });
  }
}
