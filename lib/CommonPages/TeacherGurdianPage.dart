import 'package:attend/Authentication/user_auth/firebase_auth_service/firebase_auth_service.dart';
import 'package:attend/Authentication/user_auth/firebase_auth_service/student_add_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class TeacherGurdianPage extends StatefulWidget {
  const TeacherGurdianPage({super.key});

  @override
  State<TeacherGurdianPage> createState() => _TeacherGurdianPageState();
}
class _TeacherGurdianPageState extends State<TeacherGurdianPage> {
  final List<String> arr=["A","B","C","D"];
  final controller=Get.put(FirebaseAuthService());
  String SelectedItem="A";
  final List<String> year=["FE","SE","TE","BE"];
  List<String> selectedYear=[];
  String selectedItems ="py";
  String sel="digital";
  List<String> subjectFe=["py","se","asd"];
  List<String> subjectWiseList(){
    if(selectedYear.contains("FE")){
      List<String> Fe=["py","se","asd"];
      selectedItems=Fe[0];
      return Fe;
    }
    if(selectedYear.contains("SE")){
      List<String> se=["ELE","EX","DSA","DIGI"];
      selectedItems=se[0];
      return se;
    }else if(selectedYear.contains("TE")){
      List<String> te=["mc","dbms","java","digital","eft","computer"];
      selectedItems=te[0];
      return te;
    }else if(selectedYear.contains("BE")){
      List<String> be=["VLSI","Embedded","AI"];
      selectedItems=be[0];
      return be;
    }
    return [];
  }
  void _showDialog(BuildContext context){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
          content:SingleChildScrollView(
            child: ListBody(
                children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.black,
                                width: 2
                            )
                        ),
                        child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value:SelectedItem,
                            items: arr.map((e){
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(e)
                              );
                            }).toList(),
                            onChanged:(value){
                              setState(() {
                                SelectedItem=value!;
                              });
                            }
                        ),
                      ),
                      SizedBox(width: 2,),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.black,
                                width: 2
                            )
                        ),
                        child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value:selectedYear.isEmpty ?null : selectedYear.first,
                            items: year.map((e){
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(e)
                              );
                            }).toList(),
                            onChanged:(value){
                              setState(() {
                                selectedYear=[value!];
                                subjectFe=subjectWiseList();
                              });
                            }
                        ),
                  ),
                  if(selectedYear.isNotEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Select subject : ${selectedItems}"),
                        SizedBox(height: 3,),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2
                              )
                          ),
                          child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value:selectedItems,
                              items: subjectFe.map((e){
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(e)
                                );
                              }).toList(),
                              onChanged:(value){
                                setState(() {
                                  selectedItems=value!;
                                });
                              }
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      color: Colors.green,
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                        child: Center(child: Text("Submit"))),
                  )
                ]
            ),
          )
        );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
          List<String> result= await showDialog(
              context: context,
              builder: (context){
                return CustomAlertDialogBox();
              }
          );
        },
      ),
      body:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("Select Division : ${SelectedItem}"),
                  Container(
                    width: (size.width/5),
                    height: 50,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                    child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value:SelectedItem,
                        items: arr.map((e){
                          return DropdownMenuItem(
                              value: e,
                              child: Text(e)
                          );
                        }).toList(),
                        onChanged:(value){
                          setState(() {
                            SelectedItem=value!;
                          });
                        }
                    ),
                  ),
                ],
              ),
              SizedBox(width: 2,),
              Column(
                children: [
                  Text("Select Year : ${selectedYear.join(',')}"),
                  Container(
                    width: size.width/5,
                    height: 50,
                    margin: EdgeInsets.only(left: 10,right: 10),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                    child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value:selectedYear.isEmpty ?null : selectedYear.first,
                        items: year.map((e){
                          return DropdownMenuItem(
                              value: e,
                              child: Text(e)
                          );
                        }).toList(),
                        onChanged:(value){
                          setState(() {
                            selectedYear=[value!];
                            subjectFe=subjectWiseList();
                          });
                        }
                    ),
                  ),
                ],
              ),
              SizedBox(width: 2,),
              if(selectedYear.isNotEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Select subject : ${selectedItems}"),
                    Container(
                      height: 50,
                      width: size.width/5,
                      margin: EdgeInsets.only(left: 10,right: 10),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.black,
                              width: 2
                          )
                      ),
                      child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value:selectedItems,
                          items: subjectFe.map((e){
                            return DropdownMenuItem(
                                value: e,
                                child: Text(e)
                            );
                          }).toList(),
                          onChanged:(value){
                            setState(() {
                              selectedItems=value!;
                            });
                          }
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 5,),
          GestureDetector(
            onTap: (){
            },
            child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Center(child: Text("Submit"))),
          ), 
          FutureBuilder(
                future: controller.fetchStudentDailyAttendance(sel, SelectedItem),
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }else{
                    List<AddStudentSubjectWise> studentList=snapshot.data as List<AddStudentSubjectWise>;
                    if(studentList.length==0){
                     return Center(child: Text("No Present"),);
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: studentList.length,
                          itemBuilder: (BuildContext context,index){
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
                                ],
                              ),
                            ) ,
                          );
                          }
                      ),
                    );
                  }
                }
            ),
        ],
      )
    );
  }
}
class CustomAlertDialogBox extends StatefulWidget {
  const CustomAlertDialogBox({super.key});

  @override
  State<CustomAlertDialogBox> createState() => _CustomAlertDialogBoxState();
}

class _CustomAlertDialogBoxState extends State<CustomAlertDialogBox> {
  final List<String> arr=["A","B","C","D"];
  String SelectedItem="A";
  final List<String> year=["FE","SE","TE","BE"];
  List<String> selectedYear=[];
  String selectedItems ="py";
  List<String> subjectFe=["py","se","asd"];
  List<String> subjectWiseList(){
    if(selectedYear.contains("FE")){
      List<String> Fe=["py","se","asd"];
      selectedItems=Fe[0];
      return Fe;
    }
    if(selectedYear.contains("SE")){
      List<String> se=["ELE","EX","DSA","DIGI"];
      selectedItems=se[0];
      return se;
    }else if(selectedYear.contains("TE")){
      List<String> te=["mc","dbms","java","digital","eft","computer"];
      selectedItems=te[0];
      return te;
    }else if(selectedYear.contains("BE")){
      List<String> be=["VLSI","Embedded","AI"];
      selectedItems=be[0];
      return be;
    }
    return [];
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              content:SingleChildScrollView(
                child: ListBody(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.black,
                                width: 2
                            )
                        ),
                        child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value:SelectedItem,
                            items: arr.map((e){
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(e)
                              );
                            }).toList(),
                            onChanged:(value){
                              setState(() {
                                SelectedItem=value!;
                              });
                            }
                        ),
                      ),
                      SizedBox(width: 2,),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.black,
                                width: 2
                            )
                        ),
                        child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value:selectedYear.isEmpty ?null : selectedYear.first,
                            items: year.map((e){
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(e)
                              );
                            }).toList(),
                            onChanged:(value){
                              setState(() {
                                selectedYear=[value!];
                                subjectFe=subjectWiseList();
                              });
                            }
                        ),
                      ),
                      if(selectedYear.isNotEmpty)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Select subject : ${selectedItems}"),
                            SizedBox(height: 3,),
                            Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 2
                                  )
                              ),
                              child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value:selectedItems,
                                  items: subjectFe.map((e){
                                    return DropdownMenuItem(
                                        value: e,
                                        child: Text(e)
                                    );
                                  }).toList(),
                                  onChanged:(value){
                                    setState(() {
                                      selectedItems=value!;
                                    });
                                  }
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 5,),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop([SelectedItem,selectedItems,selectedYear[0]]);
                        },
                        child: Container(
                            color: Colors.green,
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Center(child: Text("Submit"))),
                      )
                    ]
                ),
              )
          );
  }
}

