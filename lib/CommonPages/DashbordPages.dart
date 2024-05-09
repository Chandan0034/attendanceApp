import 'package:attend/Authentication/user_auth/firebase_auth_service/firebase_auth_service.dart';
import 'package:attend/Authentication/user_auth/firebase_auth_service/user_info_model.dart';
import 'package:attend/Authentication/user_auth/pages/LoginPages.dart';
import 'package:attend/CommonPages/HomePageFaculty.dart';
import 'package:attend/CommonPages/StdudenStatusFaculty.dart';
import 'package:attend/CommonPages/TeacherGurdianPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DashboardPages extends StatefulWidget {
  const DashboardPages({super.key});
  @override
  State<DashboardPages> createState() => _DashboardPagesState();
}
final auth=FirebaseAuth.instance;
class _DashboardPagesState extends State<DashboardPages> {
  int currentIndex=0;
  final user=auth.currentUser;
  String category="";
  final controller=Get.put(FirebaseAuthService());
  @override
  void initState(){
    category="hello";
    print(category);
    super.initState();
  }
  static const List<Widget> page=[
    FacultyHomePage(),
    TeacherGurdianPage(),
    StudentStatus()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
          future:controller.getUserDetatils(user!.email.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              UserModel userModel = snapshot.data as UserModel;
              if (userModel.category == "Faculty") {
                return DefaultTabController(
                  length: 3,
                  child: Scaffold(
                      appBar: AppBar(
                        flexibleSpace: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TabBar(
                                tabs: [
                                Tab(child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text("Home" ,style: TextStyle(color: Colors.black,fontSize: 20),)),),
                                Tab(child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                    decoration: BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text("TG" ,style: TextStyle(color: Colors.black,fontSize: 20),)),),
                                Tab(child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                    decoration: BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text("Profile" ,style: TextStyle(color: Colors.black,fontSize: 20),)),)
                            ])
                          ],
                        ),
                        backgroundColor: Colors.black.withOpacity(.8),
                        // leading: InkWell(
                        //     onTap: () {
                        //       auth.signOut();
                        //       Navigator.pushAndRemoveUntil(
                        //           context, MaterialPageRoute(builder: (context) =>
                        //           LoginPages()), (route) => false);
                        //     },
                        //     child: Icon(Icons.logout)),
                        // title: Text(userModel.category.toString()),
                      ),
                      body:TabBarView(
                        children: [
                          FacultyHomePage(),
                          TeacherGurdianPage(),
                          StudentStatus()
                        ],
                      )
                  ),
                );
              }
              return Center(child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.lightBlue,
                  leading: InkWell(
                      onTap: () {
                        auth.signOut();
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) =>
                            LoginPages()), (route) => false);
                      },
                      child: Icon(Icons.logout)),
                  title: Text(userModel.category.toString()),
                ),
                body: Center(child: Text("Student")),));
            }
          }),
    );
  }
}
