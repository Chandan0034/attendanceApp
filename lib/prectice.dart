// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String value1="";
//   String value2="";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Multiple Values Dialog'),
//       ),
//       body: Column(
//         children: [
//           Text(value1+value2),
//           Center(
//             child: ElevatedButton(
//               onPressed: () async {
//                 List<String>? result = await CustomDialog.show(context);
//                 if (result != null) {
//                   setState(() {
//                     value1 = result[0];
//                     value2 = result[1];
//                   });
//                   print('Value 1: $value1, Value 2: $value2');
//                   // Perform any further actions with the values
//                 }
//               },
//               child: Text('Open Dialog'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CustomDialog {
//   static Future<List<String>?> show(BuildContext context) async {
//       return await showDialog<List<String>?>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Enter Values'),
//           content: Column(
//             children: [
//               TextField(
//                 controller: textController1,
//                 decoration: InputDecoration(labelText: 'Value 1'),
//               ),
//               TextField(
//                 controller: textController2,
//                 decoration: InputDecoration(labelText: 'Value 2'),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop([textController1.text, textController2.text]);
//               },
//               child: Text('OK'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
