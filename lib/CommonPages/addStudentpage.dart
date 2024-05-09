import 'dart:async';

import 'package:attend/Authentication/user_auth/firebase_auth_service/student_add_model.dart';
import 'package:attend/Authentication/user_auth/widgets/form_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Authentication/user_auth/firebase_auth_service/firebase_auth_service.dart';
class AddStudentPage extends StatefulWidget {
  final String subjectName;
  final String division;
  const AddStudentPage({super.key,required this.subjectName,required this.division});
  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}
class _AddStudentPageState extends State<AddStudentPage> {
  List<Map<String, dynamic>> myDataList = [];
  List<String> studentDocumentId=[];
  List<bool> isCheck=List.generate(200, (index) => false);
  List<String> todayAttend=List.generate(200, (index) =>"Absent");
  bool flag=false;
  final controller=Get.put(FirebaseAuthService());
  TextEditingController _NameController = TextEditingController();
  TextEditingController _RollNo = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flag=true;
  }
  void addStudentIntoDatabase(){
    String name=_NameController.text;
    String RollNo=_RollNo.text;
    AddStudentSubjectWise subjectWiseModel = AddStudentSubjectWise(Lecture: 0, TotalLecture: 0, FullName: name,SubjectName:widget.subjectName, RollNo: RollNo,division: widget.division);
    controller.addStudentList(subjectWiseModel,widget.subjectName,widget.division);
    setState(() {
      flag=true;
    });
    Navigator.of(context).pop();
  }
  void clearText(){
    _NameController.clear();
    _RollNo.clear();
  }
  void _addStudentWithNameAndDivision(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  FormContainerWidget(
                    labelText:"Enter The Name",
                    hintText:"Enter Your Name",
                    isPasswordField: false,
                    controller: _NameController,
                  ),
                  SizedBox(height: 10,),
                  FormContainerWidget(
                    hintText: "Enter The Roll No",
                    labelText: "Enter The Roll No",
                    isPasswordField: false,
                    controller: _RollNo,
                  ),
                  GestureDetector(
                    onTap: (){
                      addStudentIntoDatabase();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(8),
                      child: Center(child: Text("Submit")),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    ).whenComplete(() => Future.delayed(Duration(milliseconds: 2),(){
      setState(() {
        flag=true;
      });
    }
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.add),
        onPressed: (){
          _addStudentWithNameAndDivision(context);
          clearText();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: (){
            setState(() {
              controller.AttendanceUpdate(widget.subjectName,widget.division);
              controller.UpdateDailyAttendance(myDataList, widget.subjectName, widget.division);
              Navigator.pop(context);
              todayAttend=List.generate(200, (index) => "Absent");
              isCheck=List.generate(200, (index) => false);
              myDataList=[];
            });
          },
          child: Container(
            width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.only(left: 8,right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue
              ),
              child: Center(child: Text("Submit"))),
        )
      ),
      body: FutureBuilder(
          future: controller.fetchAllStudentSubjectAndDivisionWise(widget.subjectName,widget.division),
          builder:(constext,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting && flag){
              flag=false;
              return Center(child: CircularProgressIndicator(),);
            }else{
              List<AddStudentSubjectWise> studentList=snapshot.data as List<AddStudentSubjectWise>;
              return ListView.builder(
                itemCount: studentList.length,
                  itemBuilder:(context,index){
                  return Card(
                    margin: EdgeInsets.all(8),
                    elevation: 2,
                    child:Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(10),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Column(
                           children: [
                             Row(
                               children: [
                                 Text(studentList[index].RollNo),
                               ],
                             ),
                             SizedBox(height: 10,),
                             Text(studentList[index].SubjectName)
                           ],
                         ),
                         Column(
                           children: [
                             Row(
                               children: [
                                 Text(studentList[index].FullName.toUpperCase()),
                                 SizedBox(width: 10,),
                               ],
                             ),
                             SizedBox(height: 10,),
                             Row(
                               children: [
                                 Text("Attendance: "),
                                 SizedBox(width: 10,),
                                 Text(studentList[index].Lecture.toString()+"/"+studentList[index].TotalLecture.toString()),
                               ],
                             )
                           ],
                         ),
                         Column(
                             children: [
                               Text(todayAttend[index].toUpperCase()),
                               Checkbox(
                                   value:isCheck[index],
                                   onChanged: (value){
                                     setState(() {
                                       isCheck[index]=value!;
                                       if (value) {
                                         todayAttend[index]="Present";
                                         myDataList.add({'Id':studentList[index].id, 'IsCheck': true});
                                       }
                                       else {
                                         todayAttend[index]="Absent";
                                         myDataList.removeWhere((item) => item['Id'] == studentList[index].id);
                                       }
                                     });
                                   }
                               )
                             ],
                         )
                       ],
                      ),
                    ) ,
                  );
                  }
              );
            }
          }
      ),
    );
  }
}
