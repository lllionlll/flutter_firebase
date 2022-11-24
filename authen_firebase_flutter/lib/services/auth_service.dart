import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // Register User
  Future<User?> register(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()), backgroundColor: Colors.red,));
    } catch(e) {
      print(e);
    }

  }
  // Login
  Future<User?> login(String email, String pass, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
      return userCredential.user;
    } on FirebaseAuthException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()), backgroundColor: Colors.red,));
    } catch (e) {
      print(e);
    }
  }
  // Google Sign In

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication dialog
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
        );
        // Once signed in return the user data from firebase
        UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print(e);
    }
  }
  // Sign out

  Future signOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }
}