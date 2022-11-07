import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      title: 'Firebase Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
    return Scaffold(
        appBar: AppBar(elevation: 0, title: Text('Flutter Firebase')),
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SignIn();
            } else {
              return Center(
                child:  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Text(
                      'SIGN OUT',
                      style: TextStyle(color: Colors.white),
                    )),
              );
            }
          },
        ));
  }

  Container SignIn() {
    Size size = MediaQuery.of(context).size;
    TextEditingController email = TextEditingController();
    TextEditingController pass = TextEditingController();

    Future sign() async {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: pass.text.trim());
    }

    Future forget() async {
      FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.text.trim()
      );
    }

    return Container(
      width: size.width,
      height: size.height,
      margin: EdgeInsets.only(top: size.width * 0.2),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.1,
                top: size.width * 0.05,
                right: size.width * 0.1),
            child: TextField(
              controller: email,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: 'email',
                  border: OutlineInputBorder(borderSide: BorderSide())),
              maxLines: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: size.width * 0.1,
                top: size.width * 0.05,
                right: size.width * 0.1),
            child: TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(borderSide: BorderSide())),
              maxLines: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.width * 0.2),
            child: ElevatedButton(
                onPressed: () {
                  sign();
                },
                child: Text(
                  'SIGN IN',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: size.width * 0.1),
            child: ElevatedButton(
                onPressed: () {
                  
                },
                child: Text(
                  'SIGN UP',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: size.width * 0.1),
            child: ElevatedButton(
                onPressed: () {
                  forget();
                },
                child: Text(
                  'FORGOT PASSWORD',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
