import 'package:authen_firebase_flutter/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class LoginSceen extends StatelessWidget {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              obscureText: true,
              controller: password,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Submit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                onPressed: () async {
                  if (email.text == "" || password == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All field are required'), backgroundColor: Colors.red,));
                  } else {
                    User? result = await AuthService().login(email.text, password.text, context);
                    if (result != null) {
                      print("Succes");
                      print(result.email);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()),
                              (router) => false
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

