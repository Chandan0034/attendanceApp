import 'package:attend/Authentication/user_auth/firebase_auth_service/SubjectTeacherModel.dart';
import 'package:attend/Authentication/user_auth/firebase_auth_service/student_add_model.dart';
import 'package:attend/Authentication/user_auth/firebase_auth_service/user_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class FirebaseAuthService{
  String Category="";
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch(e){
      print(e.code);
    }
    catch (e) {
      print("Some error occured");
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseAuthException catch(e){
      print(e);
    }
    catch (e) {
      print("Some error occured");
    }
    return null;

  }
  final _db=FirebaseFirestore.instance;
  Future<void> CreateUser(UserModel userModel) async{
    if(userModel.category!=""&& userModel.email!="" && userModel.fullName!="" &&
    userModel.phoneNo!=""){
      await _db.collection("UserInfo").add(userModel.toJson());
    }
  }
   Future<UserModel> getUserDetatils(String email) async{
    final snapshot=await _db.collection("UserInfo").where("Email",isEqualTo: email).get();
    final userData=snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }
  Future<void> subjectTeacher(SubjectTeacherModel model) async{
    if(!model.isBlank!){
       await _db.collection(model.teacherEmail).add({
         "TeacherName":model.teacherName,
         "SubjectName":model.subjectName,
         "Email":model.teacherEmail,
         "timestamp":FieldValue.serverTimestamp(),
       });
     }
  }
  Future<List<SubjectTeacherModel>> getSubjectTeacher(String email) async{
    final snapshot=await _db.collection(email).orderBy('timestamp',descending: false).get();
    final data=snapshot.docs.map((e) => SubjectTeacherModel.fromSnapshot(e)).toList();
    return data;
  }
  Future<void> addStudentList(AddStudentSubjectWise model,String subjectName,String div) async{
    if(!model.isBlank!){
      await _db.collection(subjectName+div).add({
        "Lecture":model.Lecture,
        "Division":model.division,
        "RollNo":model.RollNo,
        "TotalLecture":model.TotalLecture,
        "FullName":model.FullName,
        "SubjectName":model.SubjectName,
        "timestamp":FieldValue.serverTimestamp(),
        "lastUpdated": Timestamp.now()
      });
    }
  }
  /*
  DateTime today = DateTime.now();
DateTime startOfToday = DateTime(today.year, today.month, today.day);

// Query documents updated today
QuerySnapshot querySnapshot = await collectionRef
    .where('lastUpdated', isGreaterThanOrEqualTo: startOfToday)
    .get();

// Iterate through the documents
querySnapshot.docs.forEach((DocumentSnapshot document) {
  // Access the document data
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  // Handle the document data as needed
  print('Document updated today: $data');
  *
  * */
  Future<List<AddStudentSubjectWise>>fetchAllStudentSubjectAndDivisionWise(String Subject,String div)async{
    // FirebaseFirestore firestore=FirebaseFirestore.instance;
    // final allc=await firestore.collectionGroup("").get();
    // allc.docs.forEach((DocumentSnapshot document) {
    //   String collectionName = document.reference.path;
    //   print("Collection name is: ${collectionName}");
    // });
    final snapshot=await _db.collection(Subject+div).orderBy('timestamp',descending: false).get();
    CollectionReference collectionReference=await _db.collection(Subject+div);
    DateTime today=DateTime.now();
    DateTime startOfDay=DateTime(today.year,today.month,today.day);
    QuerySnapshot snapshots = await collectionReference.where("lastUpdated",isGreaterThanOrEqualTo: startOfDay).get();
    snapshots.docs.forEach((DocumentSnapshot d){
      Map<String,dynamic> data=d.data() as Map<String,dynamic>;
      print(data["FullName"]);
    });
    final data=snapshot.docs.map((e) => AddStudentSubjectWise.fromSnapshot(e)).toList();
    return data;
  }
  Future<void>AttendanceUpdate(String s,String d)async{
    print(s+d);
    final collection=_db.collection(s+d);
    QuerySnapshot querySnapshot=await collection.get();
    querySnapshot.docs.forEach((element)async {
      int currentValue=element["TotalLecture"];
      print(currentValue);
      int newValue=currentValue+1;
      await collection.doc(element.id).update({"TotalLecture":newValue});
    });
  }
  Future<void> UpdateDailyAttendance(List<Map<String,dynamic>> upadtes,String s,String d)async{
    final collection=await _db.collection(s+d);
    for(var upadte in upadtes){
      String DocumentId=upadte['Id'];
      bool shouldIncreament=upadte['IsCheck'];
      if(shouldIncreament){
        DocumentSnapshot documentSnapshot=await collection.doc(DocumentId).get();
        if(documentSnapshot.exists){
          int currentValue=documentSnapshot["Lecture"];
          int newValue=currentValue+1;
          await collection.doc(DocumentId).update({"Lecture":newValue,"lastUpdated": Timestamp.now()});
        }
      }
    }
  }
  Future<List<AddStudentSubjectWise>> fetchStudentDailyAttendance(String s,String d) async {
    DateTime today=DateTime.now();
    DateTime startOfDay=DateTime(today.year,today.month,today.day);
    final collection= await _db.collection(s+d).where("lastUpdated",isGreaterThanOrEqualTo:startOfDay).get();
    final data=collection.docs.map((e) => AddStudentSubjectWise.fromSnapshot(e)).toList();
    return data;
  }
}