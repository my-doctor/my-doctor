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
  String? specialet;
  String? password;
  String? clinicAddress;
  String? availableWorkDays;
  String? workStartHour;
  String? workEndHour;
  String? notes;

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
    this.specialet,
    this.password,
    this.clinicAddress,
    this.availableWorkDays,
    this.workStartHour,
    this.workEndHour,
    this.notes,
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
      map['specialet'],
      map['password'],
      map['clinicAddress'],
      map['availableWorkDays'],
      map['workStartHour'],
      map['workEndHour'],
      map['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'identityFile': identityFile,
      'bio': bio,
      'registerDate': registerDate,
      'isDoctor': isDoctor,
      'uid': uid,
      'profileUrl': profileUrl,
      'specialet': specialet,
      'password': password,
      'clinicAddress': clinicAddress,
      'availableWorkDays': availableWorkDays,
      'workStartHour': workStartHour,
      'workEndHour': workEndHour,
      'notes': notes,
    };
  }
}
