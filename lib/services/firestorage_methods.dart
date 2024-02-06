import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
 // import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get_storage/get_storage.dart';
 import 'package:mydoctor/services/firestore_methods.dart';
import 'package:mydoctor/utils/my_string.dart';

class FireStorageMethods {
  final GetStorage authBox = GetStorage();

  FirebaseAuth auth = FirebaseAuth.instance;

  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;



  updateDoctorIdentityStorage(uid, identityFile) {
    // storage
    //     .ref()
    //     .child(
    //         "$doctorsCollectionKey/$uid/identityFile/${Uri.file(identityFile.path).pathSegments.last}")
    //     .putFile(identityFile)
    //     .then((value) {
    //   value.ref.getDownloadURL().then((value) {
    //     FireStoreMethods().updateDoctorIdentity(uid, value);
    //   }).catchError((onError) {
    //     print(onError);
    //   });
    // }).catchError((onError) {
    //   print(onError);
    // });
  }


}
