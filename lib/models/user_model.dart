import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  int age;
  String gender;
  DateTime createdAt;

  UserModel({
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "age": age,
      "gender": gender,
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    Timestamp timeFirestore = map["createdAt"] ?? Timestamp.now();
    return UserModel(
      name: map["name"],
      email: map["email"],
      age: map["age"],
      gender: map["gender"],
      createdAt: timeFirestore.toDate(),
    );
  }
}
