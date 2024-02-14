import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/patint_info_model.dart';
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
    langLocal = await getLanguage;
  }

  bool isDoctor() {
    // Your logic to determine if the user is a doctor
    if (authBox.read("auth") == patientsCollectionKey) {
      return true;
    } else {
      return false;
    }
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
}
