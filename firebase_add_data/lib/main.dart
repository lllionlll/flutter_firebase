import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // DatabaseReference fb = FirebaseDatabase.instance.ref().child('test');
  // fb.onValue.listen((event) {
  //   print(event.snapshot.value);
  // });
  // fb.child('xyz/12ab/xyz').set({
  //   "abcd": "123",
  //   "xyz": "xyz",
  //   "12ab": "12d"
  // });
  // fb.child('12ab').remove();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Open'),
          onPressed: () async{
            String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

            if (selectedDirectory == null) {
              // User canceled the picker
            }

            print(selectedDirectory);
          },
        ),
      ),
    );
  }
}
