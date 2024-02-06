import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mydoctor/utils/my_string.dart';

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

   ) async {
    patients.doc(uid).set({
      'displayName': displayName,
      'uid': uid,
      'bio': "bio",
      'email': email,
      "phoneNumber": phoneNumber,
      "registerDate": DateTime.now(),
      "isDoctor": false,
      "identityFile": "identityFile",
      "profileUrl": "profileUrl",
    });
    return;
  }

  Future<void> insertDoctorInfoFireStorage(
    String displayName,
    email,
    uid,
    identityFile,
    phoneNumber,
    isDoctor,
  ) async {
    doctors.doc(uid).set({
      'displayName': displayName,
      'uid': uid,
      'email': email,
      "identityFile": identityFile,
      "phoneNumber": phoneNumber,
      "isDoctor": isDoctor,
      "registerDate": DateTime.now(),
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
