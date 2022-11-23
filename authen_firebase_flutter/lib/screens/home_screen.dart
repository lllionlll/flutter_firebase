import 'package:authen_firebase_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          TextButton.icon(
            onPressed: () {
              AuthService().firebaseAuth.signOut();
            },
            icon: Icon(Icons.logout, color: Colors.white,),
            label: Text('Sign out', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
