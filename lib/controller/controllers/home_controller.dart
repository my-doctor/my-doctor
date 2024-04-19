import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mydoctor/model/rating_model.dart';
import 'package:mydoctor/view/screens/medical_specialties.dart';
import 'package:mydoctor/view/screens/search_screen.dart';

import '../../model/user_model.dart';
import '../../services/firestore_methods.dart';
import '../../utils/constants.dart';
import '../../utils/my_string.dart';
import '../../view/screens/profile_screen.dart';

class HomeScreenController extends GetxController {
  GetStorage authBox = GetStorage();
  final patientInfoModel = Rxn<UserModel>();

  @override
  void onInit() async {
    // TODO: implement onInit
    bottomSelectedIndex = 0;
    getDoctorsInfo();
    getUserData();
    super.onInit();
  }

  RxList doctorsList = [].obs;
  RxList doctorsListBySpecialet = [].obs;

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

  getUserData() async {
    await FirebaseFirestore.instance
        .collection(authBox.read("auth"))
        .doc(authBox.read(KUid))
        .snapshots()
        .listen((event) {
      print("getting user data");

      patientInfoModel.value = null;
      if (event.exists) {
        patientInfoModel.value = UserModel.fromMap(event);
      } else {
        print("getting user data error");

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
  bool hasUserCommented() {
    // Assuming you have access to the user's comment history
    // Check if the user has already commented
    bool userHasCommented = false; // Assume initially that the user hasn't commented
    for (var comment in  doctorReviewsList) {
      if (comment.userId ==  patientInfoModel.value!.phoneNumber!) {
        userHasCommented = true; // Set to true if the user has commented
        break; // Exit the loop since we found a comment by the user
      }
    }
    return userHasCommented;
  }

  getDoctorsInfo() async {
    await FireStoreMethods()
        .doctors
        .where('isDoctor', isEqualTo: true)
        .snapshots()
        .listen((event) {
      doctorsList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        doctorsList.add(UserModel.fromMap(event.docs[i]));
      }
    });
    //   update();
  }

  getDoctorsInfoByS(String s) async {
    //print(s);
    await FireStoreMethods()
        .doctors
        .where('specialet', isEqualTo: s)
        .orderBy('averageRatingValue', descending: true)
        .snapshots()
        .listen((event) {
      doctorsListBySpecialet.clear();
      for (int i = 0; i < event.docs.length; i++) {
        print(event.docs[i]);
        doctorsListBySpecialet.add(UserModel.fromMap(event.docs[i]));
      }
    });

    //   update();
  }

  ///                   search doctors by name

  RxList searchList = [].obs;
  RxBool isSearching = false.obs;
  TextEditingController search = TextEditingController();

  void addSearchToList(
    String searchName,
  ) {
    if (search.text.isEmpty) {
      isSearching.value = false;
      searchList.clear();
    } else {
      isSearching.value = true;
    }
    update();
    searchName = searchName.toLowerCase();
    // searchList.value = productList.where((search) {
    //   var searchTitle = search.title.toLowerCase();
    //   var searchPrice = search.price.toString().toLowerCase();
    //
    //   return searchTitle.contains(searchName) ||
    //       searchPrice.toString().contains(searchName);
    // }).toList();

    searchList.value = doctorsList.value.where((search) {
      return search.displayName!.toLowerCase().contains(searchName);
    }).toList();
    print(searchList.value[0].displayName);

    update();
  }

  ///                   doctor reviews functionality
  RxList doctorReviewsList = [].obs;
  RxBool isGetDoctorReviews = false.obs;
  RxBool isGetDoctorRatings = false.obs;

  void getDoctorReviews(String doctorPhoneNumber) {
    isGetDoctorReviews.value = true;

    FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorPhoneNumber)
        .collection('reviews')
        .snapshots()
        .listen((snapshot) {
      doctorReviewsList.clear();
      doctorRatings.clear();
      for (int i = 0; i < snapshot.docs.length; i++) {
        doctorReviewsList.add(RatingModel.fromMap(snapshot.docs[i]));
        doctorRatings.add(RatingModel.fromMap(snapshot.docs[i]).ratingValue!);
      }
      isGetDoctorReviews.value = false;
    });
  }

  RxBool isAddingReview = false.obs;
  RxInt ratingV = 0.obs;

  updateRateValue(int x) {
    ratingV.value = x;
    update();
  }

  addRatingForDoctor(
      String doctorId, num averageRatingValue, comment, phoneNumber) async {
    print(doctorId);
    print(comment);
    isAddingReview.value = true;
    String myUid = await authBox.read(KUid);
    print(myUid);
    if (myUid.isNotEmpty && patientInfoModel.value!.uid!.isNotEmpty) {
      print("1");
      try {
        await FireStoreMethods()
            .addReview(
                userId: myUid,
                doctorId: doctorId,
                userName: patientInfoModel.value!.displayName == "User name"
                    ? "User"
                    : patientInfoModel.value!.displayName!,
                ratingValue: ratingV.value,
                comment: comment,
                phoneNumber: phoneNumber)
            .then((value) async {
          FireStoreMethods().updateDoctorAverageRatingValue(
              doctorId: phoneNumber, averageRatingValue: averageRatingValue);
          ratingV.value = 0;
          Get.back();
          Get.snackbar(
            "done✔✔",
            "your rate added successfully❤",
            snackPosition: SnackPosition.TOP,
          );
        });
        isAddingReview.value = false;
        print("2");
      } catch (error) {
        ratingV.value = 0;
        print("3");

        Get.snackbar(
          "Error",
          "$error",
          snackPosition: SnackPosition.TOP,
        );
        Get.back();
        isAddingReview.value = false;
      }
    }
    update();
  }

  List<int> doctorRatings = [];

  int calculateAverageRating(List<int> ratingsList) {
    if (ratingsList.isEmpty) {
      return 0; // Return 0 if the list is empty to avoid division by zero
    }

    int totalSum = ratingsList.reduce((value, element) => value + element);
    int averageRating = totalSum ~/ ratingsList.length;
    return averageRating;
  }
}
