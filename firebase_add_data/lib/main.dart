import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

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
  List <String> list = [];
  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Open'),
              onPressed: () async{
                list.clear();
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'pdf', 'doc'],
                  allowMultiple: true
                );
                setState(() {
                  result!.paths.forEach((element) {
                    list.add(element.toString());
                  });
                });
              },
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.green,
              child: list.length > 0 ? Image.file(File(list[_selectIndex]), fit: BoxFit.cover,):null,
            ),
            ElevatedButton(
              onPressed: () async {
                UploadTask uploadTask;
                final path = 'files';
                final file = File(list.first);
                final ref = FirebaseStorage.instance.ref().child(path);
                uploadTask = ref.putFile(file);

                final snapshot = await uploadTask.whenComplete(() {});

                final urlDownload = await snapshot.ref.getDownloadURL();
                print('Download Link: $urlDownload');
              },
              child: Text('Upload'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectIndex = _selectIndex == list.length - 1? 0: _selectIndex + 1;
          });
        },
        child: Icon(Icons.arrow_forward_rounded, color: Colors.white,),
      ),
    );
  }
}
