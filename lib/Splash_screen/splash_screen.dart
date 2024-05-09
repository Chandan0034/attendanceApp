import 'package:attend/Authentication/user_auth/pages/LoginPages.dart';
import 'package:attend/CommonPages/DashbordPages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
final auth=FirebaseAuth.instance;
final user=auth.currentUser;
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    print(user?.email);
    if(user!=null){
      Future.delayed(
          Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DashboardPages()), (route) => false);
      }
      );

    }else{
      Future.delayed(
          Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPages()), (route) => false);
      }
      );
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text('Splash Screen')),
    );
  }
}
