import 'package:attend/Authentication/user_auth/firebase_auth_service/SubjectTeacherModel.dart';
import 'package:attend/Authentication/user_auth/widgets/form_container_widget.dart';
import 'package:attend/CommonPages/addStudentpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uuid/uuid.dart';
import '../Authentication/user_auth/firebase_auth_service/firebase_auth_service.dart';
class FacultyHomePage extends StatefulWidget {
  const FacultyHomePage({super.key});
  @override
  State<FacultyHomePage> createState() => _FacultyHomePageState();
}
final auth=FirebaseAuth.instance;
class _FacultyHomePageState extends State<FacultyHomePage> {
  final user=auth.currentUser;
  bool showRefresh=false;
  bool check=false;
  int count=0;
  bool flag=false;
  String attend="Absent";
  List<bool> isCheck=List.generate(100, (index) => false);
  void refreshPage(){
    setState(() {
      showRefresh=true;
    });
  }
  Future<void> getAllCollection()async{
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    final allc=await firestore.collectionGroup("").get();
    allc.docs.forEach((DocumentSnapshot document) {
      String collectionName = document.reference.path;
      print("Collection name is: ${collectionName}");
    });
  }
  final controller = Get.put(FirebaseAuthService());
  TextEditingController nameController=TextEditingController();
  TextEditingController subjectName=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flag=true;
  }
  void _dialogClose(){
    String name=nameController.text.toString();
    String subjectNames=subjectName.text.toString();
    var rdnId=Uuid();
    String id=rdnId.v4();
    SubjectTeacherModel subjectTeacherModel=SubjectTeacherModel(teacherName: name, subjectName: subjectNames, teacherEmail: user!.email.toString(),id: id);
    controller.subjectTeacher(subjectTeacherModel);
    refreshPage();
    flag=true;
    Navigator.of(context).pop();
  }
  void clearText(){
    nameController.clear();
    subjectName.clear();


  }
  // void _showDialog(BuildContext context){
  //   showDialog(context: context,
  //       builder: (BuildContext context){
  //         return AlertDialog(
  //         content:SingleChildScrollView(
  //           child: ListBody(
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.all(10),
  //                   padding: EdgeInsets.only(left: 10),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(8),
  //                     border: Border.all(
  //                       color: Colors.black,
  //                       width: 2
  //                     )
  //                   ),
  //                   child: DropdownButtonFormField<String>(
  //                     isExpanded: true,
  //                       value:SelectedItem,
  //                       items: arr.map((e){
  //                         return DropdownMenuItem(
  //                           value: e,
  //                             child: Text(e)
  //                         );
  //                       }).toList(),
  //                       onChanged:(value){
  //                       setState(() {
  //                         SelectedItem=value!;
  //                       });
  //                       }
  //                   ),
  //                 ),
  //                 FormContainerWidget(
  //                   hintText: "Enter The Name",
  //                   labelText: "Name",
  //                   controller: nameController,
  //                   isPasswordField: false,
  //                 ),
  //                 SizedBox(height: 5,),
  //                 Container(
  //                   margin: EdgeInsets.all(10),
  //                   padding: EdgeInsets.only(left: 10),
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(8),
  //                       border: Border.all(
  //                           color: Colors.black,
  //                           width: 2
  //                       )
  //                   ),
  //                   child: DropdownButtonFormField<String>(
  //                       isExpanded: true,
  //                       value:selectedYear,
  //                       items: year.map((e){
  //                         return DropdownMenuItem(
  //                             value: e,
  //                             child: Text(e)
  //                         );
  //                       }).toList(),
  //                       onChanged:(value){
  //                         setState(() {
  //                           selectedYear=value!;
  //                           if(value=="SE"){
  //                             flagS=2;
  //                             print("Hello");
  //                             subjectFe.removeRange(0,subjectFe.length);
  //                             for(var s in subjectFe){
  //                               print("subject: "+s);
  //                             }
  //                             selectedSubject="Electrical";
  //                             subjectFe.add("Electronics");
  //                             subjectFe.add("Mathematics");
  //                             subjectFe.add("Digital");
  //                             subjectFe.add("Data Structure");
  //                           }else if(value=="TE"){
  //                             flagS=3;
  //                             subjectFe.removeRange(0,subjectFe.length-1);
  //                             selectedSubject="Microcontroller";
  //                             subjectFe.add("Microcontroller");
  //                             subjectFe.add("DBMS");
  //                             subjectFe.add("Digital Communic");
  //                             subjectFe.add("Computer");
  //                           }
  //                           print("Subject"+selectedSubject);
  //                         });
  //                       }
  //                   ),
  //                 ),
  //                 SizedBox(height: 5,),
  //                 Text(selectedSubject),
  //                 SizedBox(height: 5,),
  //                 GestureDetector(
  //                   onTap: (){
  //                     _dialogClose();
  //                   },
  //                   child: Container(
  //                     color: Colors.green,
  //                     padding: EdgeInsets.all(10),
  //                     width: double.infinity,
  //                       child: Center(child: Text("Submit"))),
  //                 )
  //               ]
  //           ),
  //         )
  //       );
  //       }
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
         showDialog(
             context: context,
             builder: (context){
               return AlertDialogBox();
             }
         ).whenComplete(() =>
             Future.delayed(Duration(milliseconds: 1),(){
               setState(() {
                 flag=true;
               });
             })
         );
          clearText();
        },
      ),
      body: FutureBuilder(
          future: controller.getSubjectTeacher(user!.email.toString()),
          builder:(context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting && flag){
          flag=false;
          return Center(child: CircularProgressIndicator());
        }else{
          List<SubjectTeacherModel> list=snapshot.data as List<SubjectTeacherModel>;
          return ListView.builder(
            itemCount: list.length,
              itemBuilder: (BuildContext context,index){
                return InkWell(
                  onTap: (){
                    setState(() {
                     Navigator.push(context,MaterialPageRoute(builder: (context)=>AddStudentPage(subjectName: list[index].subjectName,division: "A",)));
                    });
                  },
                    child: Card(
                      elevation: 3,
                      margin: EdgeInsets.all(8),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(12)
                        ),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(list[index].subjectName),
                            SizedBox(height: 3,),
                            Text(list[index].teacherName),
                            // Checkbox(
                            //     value:isCheck[index],
                            //     onChanged: (value){
                            //       setState(() {
                            //         print(isCheck.length);
                            //         isCheck[index]=value!;
                            //         print(list[index].subjectName);
                            //       });
                            //     }
                            // )
                          ],
                        ),
                      ),
                    ),
                );
              }
          );
        }
          }
      )
    );
  }
}
class AlertDialogBox extends StatefulWidget {
  const AlertDialogBox({super.key});

  @override
  State<AlertDialogBox> createState() => _AlertDialogBoxState();
}

class _AlertDialogBoxState extends State<AlertDialogBox> {
  final List<String> arr=["A","B","C","D"];
  final user=auth.currentUser;
  TextEditingController nameController=TextEditingController();
  final List<String> year=["FE","SE","TE","BE"];
  List<String> selectedYear=[];
  String SelectedItem="A";
  String selectedItems ="py";
  List<String> subjectFe=["py","se","asd"];
  final controller = Get.put(FirebaseAuthService());
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
  void _dialogClose(){
    String name=nameController.text.toString();
    var rdnId=Uuid();
    String id=rdnId.v4();
    SubjectTeacherModel subjectTeacherModel=SubjectTeacherModel(teacherName: name, subjectName:selectedItems, teacherEmail: user!.email.toString(),id: id);
    controller.subjectTeacher(subjectTeacherModel);
    Navigator.of(context).pop();
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
                FormContainerWidget(
                  hintText: "Enter The Name",
                  labelText: "Name",
                  controller: nameController,
                  isPasswordField: false,
                ),
                SizedBox(height: 5,),
                Text("Select the Year"+selectedYear.join(',')),
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
                SizedBox(height: 5,),
                if(selectedYear.isNotEmpty)
                  Column(
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
                    _dialogClose();
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

