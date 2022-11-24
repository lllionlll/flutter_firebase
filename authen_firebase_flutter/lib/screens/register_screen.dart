import 'package:authen_firebase_flutter/screens/addData.dart';
import 'package:authen_firebase_flutter/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

  bool loading = false;
  bool loading2 = false;

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
            loading == true
                ? Container(height: 50, width: 50, padding: EdgeInsets.all(10),child: CircularProgressIndicator(),)
                :Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Submit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
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
                  setState(() {
                    loading = false;
                  });
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
            ),
            SizedBox(height: 20,),
            loading2? CircularProgressIndicator() : ElevatedButton(
              onPressed: () async{
                setState(() {
                  loading2 = true;
                });
                await AuthService().signInWithGoogle();
                FirebaseFirestore firestore = await FirebaseFirestore.instance;
                CollectionReference users = firestore.collection('users');
                String uid = FirebaseAuth.instance.currentUser!.uid;
                DocumentSnapshot result = await users.doc(uid).get();
                if (result.data() == null) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => AddData()),
                          (router) => true
                  );
                }
                setState(() {
                  loading2 = false;
                });

              },
              child: Text('Google'),
            )
          ],
        ),
      ),
    );
  }
}
