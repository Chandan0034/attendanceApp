import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectTeacherModel{
  final String? id;
  final String teacherName;
  final String subjectName;
  final String teacherEmail;
  SubjectTeacherModel({
    this.id,
    required this.teacherName,
    required this.subjectName,
    required this.teacherEmail
  });
  toJson(){
    return{
      "id":id,
      "TeacherName":teacherName,
      "SubjectName":subjectName,
      "Email":teacherEmail
    };
  }
  factory SubjectTeacherModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot){
    final data=snapshot.data()!;
    return SubjectTeacherModel(teacherName: data["TeacherName"], subjectName:data["SubjectName"], teacherEmail: data["Email"],id: data["id"]);
  }
}