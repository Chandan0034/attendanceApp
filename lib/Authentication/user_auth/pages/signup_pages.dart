import 'package:attend/Authentication/user_auth/firebase_auth_service/firebase_auth_service.dart';
import 'package:attend/Authentication/user_auth/firebase_auth_service/user_info_model.dart';
import 'package:attend/Authentication/user_auth/pages/LoginPages.dart';
import 'package:attend/Authentication/user_auth/widgets/form_container_widget.dart';
import 'package:attend/CommonPages/DashbordPages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignupPages extends StatefulWidget {
  const SignupPages({super.key});

  @override
  State<SignupPages> createState() => _SignupPagesState();
}

class _SignupPagesState extends State<SignupPages> {
  bool _isSigningUp=false;
  TextEditingController _fullName=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  TextEditingController _phoneNumber=TextEditingController();
  final FirebaseAuthService firebaseAuthService=FirebaseAuthService();
  String items="Faculty";
  final List<String> arr=["Faculty","Student"];
  void _signUp() async{
    setState(() {
      _isSigningUp=true;
    });
    String category=items;
    String userName=_fullName.text;
    String email=_email.text;
    String phoneNumber=_phoneNumber.text;
    String password=_password.text;
    if(userName.isEmpty){
      _fullName.text="Please Enter The Name";
    }
    if(userName.isNotEmpty && phoneNumber.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
      User? user =await firebaseAuthService.signUpWithEmailAndPassword(email, password);
      if(user!=null){
        UserModel userModel=UserModel(email: email, category: category, phoneNo: phoneNumber, fullName:userName);
        firebaseAuthService.CreateUser(userModel);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => DashboardPages()), (route) => false);
      }
      setState(() {
        _isSigningUp=false;
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _fullName.dispose();
    _password.dispose();
    _phoneNumber.dispose();
  }
  final _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign Up",style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                SizedBox(height: 30,),
                Container(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: items,
                    items:arr.map((item){
                      return DropdownMenuItem<String>(
                          value: item,
                          child:Text(item,style: TextStyle(fontSize: 15),)
                      );
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        items=value!;
                      });
                    },

                  ),
                ),
                SizedBox(height: 10,),
                FormContainerWidget(
                  controller: _fullName,
                  hintText: "Full Name",
                  isPasswordField: false,
                  labelText: "Name",
                ),
                SizedBox(height: 15,),
                FormContainerWidget(
                  controller: _email,
                  hintText: "Email",
                  labelText: "Email",
                  isPasswordField: false,
                ),
                SizedBox(height: 10,),
                if(_isSigningUp) Center(child: CircularProgressIndicator()),
                FormContainerWidget(
                  controller: _phoneNumber,
                  hintText: "Phone Number",
                  labelText: "Phone Number",
                  isPasswordField: false,
                ),
                SizedBox(height: 10,),
                FormContainerWidget(
                  controller: _password,
                  hintText: "Password",
                  labelText: "Password",
                  validator: (value){
                    if(value==null || value.isEmpty) {
                      return "Please Enter The Password";
                    }
                    return null;
                  },
                  isPasswordField: true,
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: _signUp,
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(width: 5,),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (context) => LoginPages()), (route) => false);
                        },
                        child: Text("Login", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
