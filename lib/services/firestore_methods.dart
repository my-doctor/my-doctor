import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydoctor/utils/my_string.dart';

import '../model/user_model.dart';

class FireStoreMethods {
  CollectionReference doctors =
      FirebaseFirestore.instance.collection(doctorsCollectionKey);
  CollectionReference patients =
      FirebaseFirestore.instance.collection(patientsCollectionKey);

  Future<void> insertPatientInfoFireStorage(
    String displayName,
    email,
    uid,
    phoneNumber,
    password,
  ) async {
    CollectionReference patients =
        FirebaseFirestore.instance.collection('patients');
    UserModel user = UserModel(
        displayName,
        uid,
        email,
        phoneNumber,
        phoneNumber,
        false,
        false,
        "identityFile",
        "bio",
        Timestamp.fromDate(DateTime.now()),
        "https://firebasestorage.googleapis.com/v0/b/mydoctor-8f4ab.appspot.com/o/profile%20-%20Copy.png?alt=media&token=0233425a-970f-442f-857c-b44b18c0a309",
        "specialet",
        password,
        "clinicAddress",
        "availableWorkDays",
        "workStartHour",
        "workEndHour",
        "notes",
        0);

    await patients.doc(phoneNumber).set(user.toJson());
  }

  Future<void> addReview({
    required String userId,
    required String doctorId,
    required String userName,
    required int ratingValue,
    required String comment,
    required String phoneNumber,
  }) async {
    await doctors.doc(phoneNumber).collection(reviewsCollectionKey).doc().set({
      'userName': userName,
      'userId': userId,
      'rateDate': DateTime.now(),
      'ratingValue': ratingValue,
      'comment': comment,
    });
    return;
  }

  Future<void> updateDoctorAverageRatingValue({
    required String doctorId,
    required num averageRatingValue,
  }) async {
    await doctors.doc(doctorId).update({
      'averageRatingValue': averageRatingValue,
    });
    return;
  }

  Future<void> updateDoctorIdentity(uid, identityFilrUrl) {
    return doctors
        .doc(uid)
        .update({'identityFile': identityFilrUrl})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update doctor Image: $error"));
  }
}
