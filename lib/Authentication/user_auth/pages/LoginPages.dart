import 'package:attend/Authentication/user_auth/firebase_auth_service/firebase_auth_service.dart';
import 'package:attend/Authentication/user_auth/pages/signup_pages.dart';
import 'package:attend/Authentication/user_auth/widgets/form_container_widget.dart';
import 'package:attend/CommonPages/DashbordPages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}
class _LoginPagesState extends State<LoginPages> {
  bool _isSinging=false;
  String text="";
  final FirebaseAuthService _auth=FirebaseAuthService();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  void _signIn() async{
    setState(() {
      _isSinging=true;
    });
    String email=_emailController.text;
    String password=_passwordController.text;
    User? user=await _auth.signInWithEmailAndPassword(email, password);
    if(user!=null){
      setState(() {
        text="";
      });
      print("successfull");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardPages()), (route) => false);
    }else{
      setState(() {
        text="User Doesn't Exits";
      });
    }
    setState(() {
      _isSinging=false;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              FormContainerWidget(
                isPasswordField: false,
                controller: _emailController,
                hintText: "Email",
              ),
              SizedBox(
                height: 10,
              ),
              if(_isSinging) Center(child: CircularProgressIndicator()),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 20,
              ),
              Text(text,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.red),),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: _signIn,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child:
                    Text("Login",
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                      onTap: (){
                        setState(() {
                          text="";
                        });
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => SignupPages()), (route) => false);
                      },
                      child: Text("Sign Up",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
