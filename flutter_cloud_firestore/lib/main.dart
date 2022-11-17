import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_cloud_firestore/User.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Cloud Storage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            TextField(
              controller: user,
              decoration: InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder()
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 80),
              child: ElevatedButton(
                child: Text('Add'),
                onPressed: () async {
                  final docUser = FirebaseFirestore.instance.collection('users').doc('ID00');
                  User u = User(
                    id: docUser.id,
                    username: user.text.trim(),
                    password: pass.text.trim()
                  );
                  final json = u.toJson();
                  await docUser.set(json);
                },
              ),
            )
          ],
        ),
      )

    );
  }
}
