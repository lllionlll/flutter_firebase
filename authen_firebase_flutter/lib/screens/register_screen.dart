import 'package:authen_firebase_flutter/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterScreen extends StatelessWidget {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
            TextField(
              obscureText: true,
              controller: confirm,
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
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
                  } else if (password.text != confirm.text) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password not same'), backgroundColor: Colors.red));
                  } else {
                    User? result = await AuthService().register(email.text, password.text, context);
                    if (result != null) {
                      print("Succes");
                      print(result.email);
                    }
                  }
                },
              ),
            ),
            SizedBox(height: 20,),
            TextButton(
              child: Text('Already have an account? Login here'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => LoginSceen()),
                        (router) => true
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
