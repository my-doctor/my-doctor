import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/routes.dart';
import '../../services/firestore_methods.dart';
import '../../utils/constants.dart';
import '../../utils/my_string.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  ////////////////////////////////////////////////
  final GetStorage authBox = GetStorage();

  var patientGender = "".obs;
  String gender = "Gender";

  var uid;

  bool isVisibilty = false;
///////////////////passwordVisibilty///////////////////////
  void visibility() {
    isVisibilty = !isVisibilty;
    update();
  }
//////////////////////////////////ال sign up patient//////////////////////////////////////////////////////////////////////////
  updateUserEmail(String email) async {
    await auth.currentUser!.updateEmail(email);
  }

  void patientSignUpUsingFirebase({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      isLoading.value = true;
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await authBox.write(KUid, value.user!.uid);
        uid = value.user!.uid;


        auth.currentUser!.updateDisplayName(name);


        update();
        await FireStoreMethods()
            .insertPatientInfoFireStorage(
          name,
          email,
          uid,
          phoneNumber,
        )
            .then((a) async {
          authBox.write(KUid, uid);
        }).then((v) {
          isLoading.value = false;
          update();
          authBox.write("auth", patientsCollectionKey);

          Get.offNamed(Routes.homeScreen);
          update();
        });
      });
    } on FirebaseAuthException catch (error) {
      isLoading.value = false;
      update();

      String title = error.code.toString().replaceAll(RegExp('-'), ' ');
      String message = "";
      if (error.code == 'weak-password') {
        message = "password is too weak.";
        title = error.code.toString();

        print('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        message = "account already exists ";

        print('The account already exists for that email.');
      } else {
        message = error.message.toString();
      }

      Get.defaultDialog(
          title: title,
          middleText: message,
          textCancel: "Ok",
          buttonColor: mainColor2,
          cancelTextColor: mainColor,
          backgroundColor: white);

    } catch (error) {
      Get.snackbar(
        "Error",
        "$error",
        snackPosition: SnackPosition.TOP,
      );
      print(error);
    }
  }

  //////////////////////////////////////////////////////////////////////login with firebase///////////////////////////

  void loginUsingFirebase({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      update();
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        final p = await FirebaseFirestore.instance
            .collection(patientsCollectionKey)
            .doc(value.user!.uid.toString()) // varuId in your case
            .get();
        final d = await FirebaseFirestore.instance
            .collection(doctorsCollectionKey)
            .doc(value.user!.uid.toString()) // varuId in your case
            .get();
        authBox.write(KUid, value.user!.uid.toString());
        if (p.exists) {
          Get.offNamed(Routes.homeScreen);
          authBox.write("auth", patientsCollectionKey);
          isLoading.value = false;
        } else if (d.exists) {
          Get.offNamed(Routes.doctorMainScreen);
          authBox.write("auth", doctorsCollectionKey);
          isLoading.value = false;
        } else {
          isLoading.value = false;
          Get.snackbar("Error", "try to login again",
              snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
        }
        update();
      });
      update();

//      displayUserId.value = await GetStorage().read("uid");

      update();
    } on FirebaseAuthException catch (error) {
      isLoading.value = false;
      update();
      String title = error.code.toString().replaceAll(RegExp('-'), ' ');
      String message = "";
      if (error.code == 'user-not-found') {
        message =
            "Account does not exists for that $email.. Create your account by signing up..";
      } else if (error.code == 'wrong-password') {
        message = "Invalid Password... PLease try again!";
      } else {
        message = error.message.toString();
      }
      Get.defaultDialog(
          title: title,
          middleText: message,
          textCancel: "Ok",
          buttonColor: mainColor2,
          cancelTextColor: mainColor,
          backgroundColor: white);
    } catch (error) {
      Get.defaultDialog(
          title: "error",
          middleText: "$error",
          textCancel: "Ok",
          buttonColor: mainColor2,
          cancelTextColor: mainColor,
          backgroundColor: white);
      print(error);
    }
  }

  //////////////////////////////////////////////////////////////////////reset  ///////////////////////////

  void resetPassWord(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      update();
      Get.back();
      Get.defaultDialog(
          title: "Reset Password",
          middleText: "check your gmail messages",
          textCancel: "Ok",
          buttonColor: mainColor,
          cancelTextColor: mainColor2,
          backgroundColor: white);
    } on FirebaseAuthException catch (error) {
      String title = error.code.toString().replaceAll(RegExp('-'), ' ');
      String message = "";
      if (error.code == 'user-not-found') {
        message =
            "Account does not exists for that $email.. Create your account by signing up..";
      } else {
        message = error.message.toString();
      }
      Get.defaultDialog(
          title: title,
          middleText: message,
          textCancel: "Ok",
          buttonColor: mainColor,
          cancelTextColor: mainColor2,
          backgroundColor: white);
    } catch (error) {
      Get.defaultDialog(
          title: "Error",
          middleText: "$error",
          textCancel: "Ok",
          buttonColor: mainColor,
          cancelTextColor: mainColor2,
          backgroundColor: white);
      print(error);
    }
  }

  ////////////////////////////////signOut//////////////////////////////////////
  void signOutFromApp() async {
    try {
      await auth.signOut();

      // displayUserName.value = "";
      // displayUserPhoto.value = "";
      // displayUserEmail.value = "";
      authBox.remove("auth");
      authBox.erase();

      update();
      Get.offAllNamed(Routes.loginScreen);
    } catch (error) {
      Get.defaultDialog(
          title: "Error",
          middleText: "$error",
          textCancel: "Ok",
          buttonColor: Colors.grey,
          cancelTextColor: Colors.black,
          backgroundColor: Colors.grey.shade200);
    }
  }
}
