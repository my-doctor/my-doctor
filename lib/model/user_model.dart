import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? displayName;
  String? email;
  String? phoneNumber;
  String? clinicPhoneNum;
  String? identityFile;
  String? bio;
  Timestamp? registerDate;
  bool? isDoctor;
  bool? isDoctorRequist;
  String? uid;
  String? profileUrl;
  String? specialet;
  String? password;
  String? clinicAddress;
  String? availableWorkDays;
  String? workStartHour;
  String? workEndHour;
  String? notes;
  num?averageRatingValue;

  UserModel(

    this.displayName,
    this.uid,
    this.email,
    this.phoneNumber,
    this.clinicPhoneNum,
    this.isDoctor,
    this.isDoctorRequist,
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
    this.averageRatingValue,
  );

  factory UserModel.fromMap(map) {
    return UserModel(
      map['displayName'],
      map['uid'],
      map['email'],
      map['phoneNumber'],
      map['clinicPhoneNum'],
      map['isDoctor'],
      map['isDoctorRequist'],
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
      map['averageRatingValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'clinicPhoneNum': clinicPhoneNum,
      'identityFile': identityFile,
      'bio': bio,
      'registerDate': registerDate,
      'isDoctor': isDoctor,
      'isDoctorRequist': isDoctorRequist,
      'uid': uid,
      'profileUrl': profileUrl,
      'specialet': specialet,
      'password': password,
      'clinicAddress': clinicAddress,
      'availableWorkDays': availableWorkDays,
      'workStartHour': workStartHour,
      'workEndHour': workEndHour,
      'notes': notes,
      'averageRatingValue': averageRatingValue,
    };
  }
}
