import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:realtime_firebase/user_model.dart';

void main() async {
  List <UserModel> listUser = [];
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');
  ref.onValue.listen((event) {
    var snap = event.snapshot;
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Realtime Database'),
      ),
       body: Container(
         color: Colors.green,
         padding: EdgeInsets.all(size.height * 0.02),
         child: FirebaseAnimatedList(
           query: FirebaseDatabase.instance.reference().child('user'),
           itemBuilder: (context, snapshot, animation, index) {
             return Container(
               width: size.width,
               height: size.height * 0.1,
               margin: EdgeInsets.only(bottom: 10),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: Colors.white30
               ),
               child: Row(
                 children: [
                   Container(
                     width: size.height * 0.1,
                     height: size.height * 0.1,
                     padding: EdgeInsets.all(size.height * 0.02),
                     child: Container(
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(100),
                             color: Colors.white70
                         ),
                         child: IconButton(
                           icon: Icon(Icons.apple),
                           onPressed: () {},
                         )
                     ),
                   ),
                   Container(
                     width: size.width - size.height * 0.2 - size.height * 0.04,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(snapshot.value., style: TextStyle(fontSize: 18, color: Colors.red),),
                         Container(
                             margin: EdgeInsets.only(top: 5),
                             child: Text('Job: ${snapshot.value['job']}',style: TextStyle(fontSize: 16, color: Colors.red)))
                       ],
                     ),
                   ),
                   Container(
                     width: size.height * 0.1,
                     height: size.height * 0.1,
                     child: IconButton(
                       icon: Icon(Icons.delete, size: 30, color: Colors.black,),
                       onPressed: () {
                         setState(() {
                           listUser.remove(listUser[index]);
                         });
                       },
                     ),
                   )
                 ],
               ),
             );
           },
         )
       ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
             listUser.add(UserModel(name: 'Nguyễn Văn A', job: 'A'));
          });
        },
        child: Icon(Icons.add, color: Colors.black,),
      ),
    );
  }
}