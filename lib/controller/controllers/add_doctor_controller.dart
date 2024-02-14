import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mydoctor/utils/my_string.dart';

import '../../model/patint_info_model.dart';

class AddDoctorController extends GetxController {
  bool isLoading = false;
  RxList patientDiagnosis = [].obs;
  String specialization = "Choose Specialization".tr;
  RxString formattedAvailableDays = "".obs;

  DateTime currentDateTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0000);
  String from = DateFormat('hh:mm a').format(DateTime.now());
  String to =
      DateFormat('hh:mm a').format(DateTime.now().add(Duration(minutes: 30)));
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  //////////////////////////////add available days  //////////////////////////////
  convertListToString(List<String> daysList) {
    // Join the elements of the list with a comma and space
    formattedAvailableDays.value = daysList.join(', ');
    print(formattedAvailableDays);
    update();
  }

  //////////////////////////////change Specialization  //////////////////////////////
  changeSpecialization(s) {
    specialization = s;
    update();
  }

  //////////////////////////////
  final ImagePicker picker = ImagePicker();

  File? identityImageFile;
  GetStorage authBox = GetStorage();



  getIdentityImageFile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      identityImageFile = File(pickedFile.path);
      update();
    } else {
      print("No Image Selected");
    }
    update();
  }

  clearImage() {

    identityImageFile = null;
    update();
  }

  ///////////////////////////
  onInit() async {
    super.onInit();
  }

  updateUserInfo(map, uid, collectionKey, context, phoneNumber) {
    isLoading = true;
    update();
    return FirebaseFirestore.instance
        .collection(collectionKey)
        .doc(phoneNumber)
        .set(map)
        .then((value) async {
      await authBox.write("auth", doctorsCollectionKey);

      await FirebaseFirestore.instance
          .collection(patientsCollectionKey)
          .doc(phoneNumber)
          .delete();
      Get.snackbar(
        "Updated ✔✔",
        "Updated Successfully",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
      isLoading = false;
      update();
//       Get.offAll(() => PatientMainScreen());
      Navigator.pop(context);
    }).catchError((error) {
      isLoading = false;
      update();
      Get.snackbar(
        "Error",
        "please add eee$error",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
    });
  }

  Future updateUserImageStorage(
    uid,
    imageUrl,
    name,
    phoneNumber,
    email,
    specialet,
    collectionKey,
    bio,
    context,
    password,
    clinicAddress,
    availableWorkDays,
    notes,
  ) async {
    update();
    if (identityImageFile != null &&
        specialization != "Choose Specialization".tr) {
      isLoading = true;

      storage
          .ref()
          .child(
              "$collectionKey/$uid/${Uri.file(identityImageFile!.path).pathSegments.last}")
          .putFile(identityImageFile!)
          .then((value) {
        value.ref.getDownloadURL().then((value) async {
          UserModel user = UserModel(
            name,
            uid,
            email,
            phoneNumber,
            false,
            "identityFile",
            bio,
            Timestamp.fromDate(DateTime.now()),
            value,
            specialet,
            password,
            clinicAddress,
            availableWorkDays,
            from,
            to,
            notes,
          );
          updateUserInfo(
            user.toJson(),
            uid,
            collectionKey,
            context,
            phoneNumber,
          );
          Get.snackbar(
            "Uploaded ✔✔",
            "Uploaded to firestorage successfully",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
          );
          isLoading = false;
        }).catchError((onError) {
          isLoading = false;
          update();
          Get.snackbar(
            "Error",
            "please add eee$onError",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
          );
          print(onError);
        });
      }).catchError((onError) {
        print(onError);
      });
    } else {
      isLoading = false;

      Get.snackbar(
        'Error',
        'Please Add the identity image or choose the Specialization',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  ///home screen details
  changeSelectedDateTime(DateTime dateTime) {
    currentDateTime = dateTime;

    update();
  }

  ///add appointment details.
  changeSelectedStartTime(String dateTime) {
    from = dateTime;

    update();
  }

  changeSelectedEndTime(String dateTime) {
    to = dateTime;

    update();
  }
}
