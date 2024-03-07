import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/routes.dart';
import '../../services/firestore_methods.dart';
import '../../utils/constants.dart';
import '../../utils/my_string.dart';
import '../../view/screens/auth/edit_new_password_screen.dart';
import '../../view/screens/home_screen.dart';
import '../../view/widgets/auth/pin_put_widget.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxBool isResetPass = false.obs;
  RxBool isEditNewPass = false.obs;

  ////////////////////////////////////////////////
  final GetStorage authBox = GetStorage();

  var patientGender = "".obs;
  String gender = "Gender";

  var uid;

  bool isVisibilty = false;
  bool isVisibilty2 = false;

///////////////////passwordVisibilty///////////////////////
  void visibility() {
    isVisibilty = !isVisibilty;
    update();
  }

  void visibility2() {
    isVisibilty2 = !isVisibilty2;
    update();
  }

//////////////////////////////////ال sign up patient//////////////////////////////////////////////////////////////////////////
  updateUserEmail(String email) async {
    await auth.currentUser!.updateEmail(email);
  }

  RxString countryCode = "+964".obs;

  updateCountryCode(String cCode) {
    countryCode.value = cCode;
    update();
  }

  RxBool isCheckingPin = false.obs;
  RxBool hasError = false.obs;

  void checkVerificationCode(
    String verificationCode,
    String name,
    String email,
    String password,
    String phoneNumber,
  ) async {
    isCheckingPin.value = true;
    hasError.value = false;

    try {
      // Create a PhoneAuthCredential object with the verification ID and the entered verification code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: authBox.read(KVerificationId),
        smsCode: verificationCode,
      );

      // Sign in with the credential
      await auth.signInWithCredential(credential).then((value) async {
        await authBox.write(KUid, phoneNumber);
        uid = value.user!.uid;

        isCheckingPin.value = false;
        update();
        await FireStoreMethods()
            .insertPatientInfoFireStorage(
                name, email, uid, phoneNumber, password)
            .then((a) async {
          authBox.write(KUid, phoneNumber);
        }).then((v) {
          isLoading.value = false;
          update();
          authBox.write("auth", patientsCollectionKey);

          Get.offNamed(Routes.homeScreen);
          update();
        });
      });

      // Navigate to the desired screen
    } catch (error) {
      isCheckingPin.value = false;
      hasError.value = true;
      // Handle verification failure
      Get.snackbar(
        "Verification Failed",
        error.toString(),
        snackPosition: SnackPosition.TOP,
      );
      print(error);
    }
  }

  //////////////////////////////////////////////////////////////////////Reset with firebase///////////////////////////

  void resetPassword({
    required String phoneNumber,
  }) async {
    isResetPass.value = true;
    update();

    final p = await FirebaseFirestore.instance
        .collection(patientsCollectionKey)
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
    final d = await FirebaseFirestore.instance
        .collection(doctorsCollectionKey)
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
    final a = await FirebaseFirestore.instance
        .collection(adminCollectionKey)
        .where("phoneNumber", isEqualTo: phoneNumber) // varuId in your case
        .get();
    if (p.docs.isNotEmpty || d.docs.isNotEmpty || a.docs.isNotEmpty) {
      // await auth.verifyPhoneNumber(
      //   phoneNumber: phoneNumber,
      //   verificationCompleted: (PhoneAuthCredential credential) async {
      //     // Automatically sign in after verification
      //     await auth.signInWithCredential(credential);
      //     isLoading.value = false;
      //     update();
      //     Get.off(() => PinCodeVerificationScreen(),
      //         arguments: ["name", "email", "password", phoneNumber, true]);
      //   },
      //   verificationFailed: (FirebaseAuthException e) {
      //     isLoading.value = false;
      //     update();
      //
      //     Get.snackbar(
      //       "Verification Failed",
      //       e.message!,
      //       snackPosition: SnackPosition.TOP,
      //     );
      //   },
      //   codeSent: (String verificationId, int? resendToken) {
      //     // Save the verification ID for later use
      //     Get.snackbar(
      //       "code sent",
      //       "Verification code sent to ur number",
      //       snackPosition: SnackPosition.TOP,
      //     );
      //     authBox.write(KVerificationId, verificationId);
      //     isLoading.value = false;
      //     update();
      //
      //     // Navigate to the PIN screen to enter the code
      //     Get.off(() => PinCodeVerificationScreen(),
      //         arguments: ["name", "email", "password", phoneNumber, true]);
      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {
      //     // Auto-retrieval timeout
      //     // You can handle this case if needed
      //   },
      // );
    } else {
      isResetPass.value = false;
      Get.snackbar("Error", "try to write correct number this number not exist",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }
  }

  void editNewPassword(
    String phoneNumber,
    String password,
  ) async {
    isEditNewPass.value = true;
    update();

    final p = await FirebaseFirestore.instance
        .collection(patientsCollectionKey)
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
    final d = await FirebaseFirestore.instance
        .collection(doctorsCollectionKey)
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
    final a = await FirebaseFirestore.instance
        .collection(adminCollectionKey)
        .where("phoneNumber", isEqualTo: phoneNumber) // varuId in your case
        .get();

    if (p.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection(patientsCollectionKey)
          .doc(phoneNumber)
          .update({"password": password}).then((value) {
        Get.offAllNamed(Routes.loginScreen);
        Get.snackbar("Done", "password Changed Successfully");
        update();
      }).catchError((onError) {
        Get.defaultDialog(
            title: "error",
            middleText: "$onError",
            textCancel: "Ok",
            buttonColor: mainColor2,
            cancelTextColor: mainColor,
            backgroundColor: white);
      });
      isEditNewPass.value = false;
    } else if (d.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection(doctorsCollectionKey)
          .doc(phoneNumber)
          .update({"password": password}).then((value) {
        Get.offAllNamed(Routes.loginScreen);
        Get.snackbar("Done", "password Changed Successfully");
        update();
      }).catchError((onError) {
        Get.defaultDialog(
            title: "error",
            middleText: "$onError",
            textCancel: "Ok",
            buttonColor: mainColor2,
            cancelTextColor: mainColor,
            backgroundColor: white);
      });
      isEditNewPass.value = false;
    } else if (a.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection(adminCollectionKey)
          .doc(phoneNumber)
          .update({"password": password}).then((value) {
        Get.offAllNamed(Routes.loginScreen);
        Get.snackbar("Done", "password Changed Successfully");
        update();
      }).catchError((onError) {
        Get.defaultDialog(
            title: "error",
            middleText: "$onError",
            textCancel: "Ok",
            buttonColor: mainColor2,
            cancelTextColor: mainColor,
            backgroundColor: white);
      });
      isEditNewPass.value = false;
    } else {
      isEditNewPass.value = false;
      Get.snackbar(
          "Error", "try to login again with correct password and number",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }

//      displayUserId.value = await GetStorage().read("uid");

    update();
  }

  void checkVerificationCodeForResetPass(
    String verificationCode,
    String phoneNumber,
  ) async {
    isCheckingPin.value = true;
    hasError.value = false;

    try {
      // Create a PhoneAuthCredential object with the verification ID and the entered verification code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: authBox.read(KVerificationId),
        smsCode: verificationCode,
      );

      // Sign in with the credential
      await auth.signInWithCredential(credential).then((value) async {
        await authBox.write(KUid, phoneNumber);
        uid = value.user!.uid;

        isCheckingPin.value = false;
        Get.off(() => EditNewPasswordScreen(), arguments: [phoneNumber]);
        update();
      });

      // Navigate to the desired screen
    } catch (error) {
      isCheckingPin.value = false;
      hasError.value = true;
      // Handle verification failure
      Get.snackbar(
        "Verification Failed",
        error.toString(),
        snackPosition: SnackPosition.TOP,
      );
      print(error);
    }
  }

  //////////////////////////////////////////////////////////////////////register with firebase///////////////////////////

  void registerWithPhoneNumber({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      print(name + email + password + phoneNumber);
      isLoading.value = true;
      update();
      await authBox.write(KUid, phoneNumber);
      final p = await FirebaseFirestore.instance
          .collection(patientsCollectionKey)
          .where("phoneNumber", isEqualTo: phoneNumber)
          .get();
      final d = await FirebaseFirestore.instance
          .collection(doctorsCollectionKey)
          .where("phoneNumber", isEqualTo: phoneNumber)
          .get();
      final a = await FirebaseFirestore.instance
          .collection(adminCollectionKey)
          .where("phoneNumber", isEqualTo: phoneNumber) // varuId in your case
          .get();

      if (p.docs.isEmpty && d.docs.isEmpty && a.docs.isEmpty) {
        isLoading.value = false;
        update();
        await FireStoreMethods()
            .insertPatientInfoFireStorage(
                name, email, phoneNumber, phoneNumber, password)
            .then((a) async {
          authBox.write(KUid, phoneNumber);
          isLoading.value = false;
          update();
          authBox.write("auth", patientsCollectionKey);
          Get.offNamed(Routes.homeScreen);
          authBox.write("auth", patientsCollectionKey);

          Get.offNamed(Routes.homeScreen);
          update();
        })   ;
      } else {   isLoading.value = false;
        Get.snackbar("خطا", "رقم الهاتف مستخدم سابقا");
      }
    } catch (error) {
      isLoading.value = false;
      update();

      Get.snackbar(
        "Error",
        error.toString(),
        snackPosition: SnackPosition.TOP,
      );
      print(error);
    }
  }

  //////////////////////////////////////////////////////////////////////login with firebase///////////////////////////

  void loginUsingFirebase({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      update();

      final p = await FirebaseFirestore.instance
          .collection(patientsCollectionKey)
          .where("password", isEqualTo: password)
          .where("phoneNumber", isEqualTo: phoneNumber)
          .get();
      final d = await FirebaseFirestore.instance
          .collection(doctorsCollectionKey)
          .where("password", isEqualTo: password)
          .where("phoneNumber", isEqualTo: phoneNumber)
          .get();
      final a = await FirebaseFirestore.instance
          .collection(adminCollectionKey)
          .where("password", isEqualTo: password)
          .where("phoneNumber", isEqualTo: phoneNumber) // varuId in your case
          .get();
      authBox.write(KUid, phoneNumber);
      if (p.docs.isNotEmpty) {
        Get.offNamed(Routes.homeScreen);
        authBox.write("auth", patientsCollectionKey);
        isLoading.value = false;
      } else if (d.docs.isNotEmpty) {
        Get.offNamed(Routes.homeScreen);
        authBox.write("auth", doctorsCollectionKey);
        isLoading.value = false;
      } else if (a.docs.isNotEmpty) {
        Get.offNamed(Routes.homeScreen);
        authBox.write("auth", adminCollectionKey); //
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Get.snackbar(
            "Error", "try to login again with correct password and number",
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      }
      update();
//7750616684
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
            "Account does not exists for that $phoneNumber.. Create your account by signing up..";
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
