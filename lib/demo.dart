import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'view.dart';


class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  String url="";

  get task => null;
  uploadDataToFirebase() async{
   //pick file
   FilePickerResult? result=await FilePicker.platform.pickFiles();
   File pick=File(result!.files.single.path.toString());
   var file=pick.readAsBytesSync();
   String name=DateTime.fromMillisecondsSinceEpoch.toString();
   //uploading
    var pdfFile=FirebaseStorage.instance.ref().child('files').child("/some-file.pdf");
   // final metadata = FirebaseStorage.SettableMetadata(
   //     contentType: 'file/pdf',
   //     customMetadata: {'picked-file-path': file.path});
   // print("Uploading..!");



    UploadTask task=pdfFile.putData(file);
    TaskSnapshot snapshot =await task;
    url=await snapshot.ref.getDownloadURL();
    print(url);
    await FirebaseFirestore.instance.collection("files").doc().set(
      {
        'url':url
      }
    );
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>View(url:url)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
             title: Text('Doc'),
           ),
    body:Center(
    child:FloatingActionButton(
    onPressed: (){
      uploadDataToFirebase();
    },
      child:Text('upload'),
    )
    )


      );

  }

}




