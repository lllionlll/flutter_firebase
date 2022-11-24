import 'package:authen_firebase_flutter/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddData extends StatelessWidget {

  TextEditingController d = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: d,
              decoration: InputDecoration(
                hintText: 'Data',
                labelText: 'Data'
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String uid = FirebaseAuth.instance.currentUser!.uid;
                final firestore = await FirebaseFirestore.instance.collection('users').doc(uid);
                firestore.set({
                  "name" : d.text.trim()
                });
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => HomeScreen()),
                        (router) => false
                );
              },
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}

