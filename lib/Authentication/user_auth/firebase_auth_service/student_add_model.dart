import 'package:cloud_firestore/cloud_firestore.dart';

class AddStudentSubjectWise{
  final String? id;
  final int Lecture;
  final String division;
  final int TotalLecture;
  final String RollNo;
  final String FullName;
  final String SubjectName;
  AddStudentSubjectWise({
     required this.Lecture,required this.TotalLecture,required this.FullName,required this.SubjectName, this.id,required this.RollNo,required this.division});
  toJson(){
    return{
      "Lecture":Lecture,
      "Division":division,
      "RollNo":RollNo,
      "TotalLecture":TotalLecture,
      "FullName":FullName,
      "SubjectName":SubjectName
    };
  }
  factory AddStudentSubjectWise.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> documentSnapshot){
    final data=documentSnapshot.data()!;
    return AddStudentSubjectWise(
      id: documentSnapshot.id,
        division: data["Division"],
        RollNo: data["RollNo"],
        Lecture: data["Lecture"],
        TotalLecture: data["TotalLecture"],
        FullName:data["FullName"],
        SubjectName: data["SubjectName"]
    );
  }
}