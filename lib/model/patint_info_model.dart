import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? displayName;
  String? email;
  String? phoneNumber;
  String? identityFile;
  String? bio;
  Timestamp? registerDate;
  bool? isDoctor;
  String? uid;
  String? profileUrl;

  UserModel(

    this.displayName,
    this.uid,
    this.email,
    this.phoneNumber,
    this.isDoctor,
    this.identityFile,
    this.bio,
    this.registerDate,
    this.profileUrl,
  );

  factory UserModel.fromMap(map) {
    return UserModel(
      map['displayName'],
      map['uid'],
      map['email'],
      map['phoneNumber'],
      map['isDoctor'],
      map['identityFile'],
      map['bio'],
      map['registerDate'],
      map['profileUrl'],
    );
  }
}
