import 'package:attend/Authentication/user_auth/firebase_auth_service/firebase_auth_service.dart';
import 'package:attend/Authentication/user_auth/pages/LoginPages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class StudentStatus extends StatefulWidget {
  const StudentStatus({super.key});

  @override
  State<StudentStatus> createState() => _StudentStatusState();
}

class _StudentStatusState extends State<StudentStatus> {
   late List<Map<String,dynamic>> student=[];
  final _auth=FirebaseAuth.instance;
  Future<void> fetchdata() async{
    final colle=await FirebaseFirestore.instance.collection("digitalA").orderBy("timestamp",descending: false).get();
    setState(() {
      student=colle.docs.map((e) => e.data() as Map<String,dynamic>).toList();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ElevatedButton(
            onPressed:(){
              _auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPages()));
            },
            child: Text("Sign out")
        ),
      ),
      body: student== null ? Center(child: CircularProgressIndicator(),):
      Container(
        decoration: BoxDecoration(
          border:Border.all(
            color: Colors.black,
            width: 2
          )
        ),
        child: DataTable2(
          headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
          headingRowDecoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2
            )
          ),
            columnSpacing:10,
              columns: [
                DataColumn2(label: Text("Name")),
                DataColumn2(label: Text("Total Lecture")),
                DataColumn2(label: Text("Total Attend")),
                DataColumn2(label: Text("Subject Name")),
                DataColumn2(label: Text("Percentage %")),
              ],
              rows: student.map((e) =>
                  DataRow(
                      cells: [
                        DataCell(Center(child: Text(e["RollNo"]+" "+e["FullName"]))),
                        DataCell(Center(child: Text(e["TotalLecture"].toString()))),
                        DataCell(Center(child: Text(e["Lecture"].toString()))),
                        DataCell(Center(child: Text(e["SubjectName"]))),
                        DataCell(Center(child: Text(((e["Lecture"]/e["TotalLecture"])*100).toStringAsFixed(2)+" %")))

                      ]
                  )
              ).toList()
        ),
      )
    );
  }
}
