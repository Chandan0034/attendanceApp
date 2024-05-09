import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel{
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String category;
  const UserModel({
    this.id,
    required this.email,
    required this.category,
    required this.phoneNo,
    required this.fullName
  });
  toJson(){
    return{
      "id":id,
      "FullName":fullName,
      "Email":email,
      "Phone":phoneNo,
      "Category":category
    };
  }
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot){
    final data=documentSnapshot.data()!;
    return UserModel(
      id: documentSnapshot.id,
        email: data["Email"],
        category: data["Category"],
        phoneNo: data["Phone"],
        fullName: data["FullName"]);
  }
}