import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'homescreen1.dart';
import 'dart:io';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class  GetHired extends StatefulWidget {
  const GetHired({Key? key}) :super(key: key);
  @override
  _GetHiredState createState() => _GetHiredState();
}

class _GetHiredState extends State<GetHired> {
  CollectionReference gethired = FirebaseFirestore.instance.collection(
      'gethired');
  final _auth = FirebaseAuth.instance;
  String url = "";

  uploadDataToFirebase() async {
    //pick file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.fromMillisecondsSinceEpoch.toString();
    //uploading
    var pdfFile = FirebaseStorage.instance.ref().child('files').child(
        "/.pdf");


    UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    print(url);
    await gethired.add({
      'Name': nameController.text,
      'title': titleController.text,
      'phone': phonenoController.text,
      'address': addressController.text,
      'state': stateController.text,
      'pin': pinController.text,
      'description': descController.text,
      'url':url,
    }).then((value) => print('Done'));
    Fluttertoast.showToast(msg: "Added");

    nameController.clear();
    pinController.clear();
    stateController.clear();
    addressController.clear();
    descController.clear();
    titleController.clear();

    phonenoController.clear();
    //setState(() {
  }

    bool _status = true;
    final FocusNode myFocusNode = FocusNode();
    final TextEditingController nameController = new TextEditingController();
    final TextEditingController pinController = new TextEditingController();
    final TextEditingController descController = new TextEditingController();
    final TextEditingController titleController = new TextEditingController();
    final TextEditingController phonenoController = new TextEditingController();
    final TextEditingController stateController = new TextEditingController();
    final TextEditingController addressController = new TextEditingController();

    Widget _getEditIcon() {
      return new GestureDetector(
        child: new CircleAvatar(
          backgroundColor: Colors.purple,
          radius: 14.0,
          child: new Icon(
            Icons.edit,
            color: Colors.white,
            size: 16.0,
          ),
        ),
        onTap: () {
          setState(() {
            _status = false;
          });
        },
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: Container(
            color: Colors.white,
            child: new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Container(
                      height: 250.0,
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 25.0, top: 25.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // new Icon(
                                  //   Icons.arrow_back_ios,
                                  //   color: Colors.black,
                                  //   size: 22.0,
                                  // ),

                                  IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen1()));
                                    },
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 25.0),
                                    child: new Text('MY PROFILE ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40.0,
                                            fontFamily: 'sans',
                                            color: Colors.purple)),
                                  )
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: new Stack(fit: StackFit.loose, children: <
                                Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,

                              ),

                            ]),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Personal Details',
                                          style: TextStyle(
                                              fontSize: 19.0,
                                              color: Colors.purple,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _status
                                            ? _getEditIcon()
                                            : new Container(),
                                      ],
                                    )
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Name:',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: "What's your Name?",
                                        ),
                                        controller: nameController,
                                        enabled: !_status,
                                        //autofocus: false,
                                        autofocus: !_status,
                                        onSaved: (value) {
                                          nameController.text = value!;
                                        },
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                )),

                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Job Title',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: "What job do you do?"),
                                        enabled: !_status,
                                        controller: titleController,
                                        onSaved: (value) {
                                          titleController.text = value!;
                                        },
                                        textInputAction: TextInputAction.next,

                                      ),
                                    ),
                                  ],
                                )),


                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Description',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: "Describe about yorself"),
                                        enabled: !_status,
                                        controller: descController,
                                        onSaved: (value) {
                                          descController.text = value!;
                                        },
                                        textInputAction: TextInputAction.next,

                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Phone No',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: "Give us your Phone number"),
                                        enabled: !_status,
                                        controller: phonenoController,
                                        onSaved: (value) {
                                          phonenoController.text = value!;
                                        },
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Address',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: "what's your address?"),
                                        enabled: !_status,
                                        controller: addressController,
                                        onSaved: (value) {
                                          addressController.text = value!;
                                        },
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                )),

                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'State',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'Pin Code',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: new TextFormField(
                                          decoration: const InputDecoration(
                                              hintText: "Your State?"),
                                          enabled: !_status,
                                          controller: stateController,
                                          onSaved: (value) {
                                            stateController.text = value!;
                                          },
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Flexible(
                                      child: new TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: "Your Pincode?"),
                                        enabled: !_status,
                                        controller: pinController,
                                        onSaved: (value) {
                                          pinController.text = value!;
                                        },
                                        textInputAction: TextInputAction.next,
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                            !_status ? _getActionButtons() : new Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ));
    }

    @override
    void dispose() {
      // Clean up the controller when the Widget is disposed
      myFocusNode.dispose();
      super.dispose();
    }

    Widget _getActionButtons() {
      return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Container(
                    child: new FloatingActionButton(
                      child: new Text("Save"),
                      //textColor: Colors.white,
                      //color: Colors.green,
                      onPressed: () async {
                        await gethired.add({
                          'Name': nameController.text,
                          'title': titleController.text,
                          'phone': phonenoController.text,
                          'address': addressController.text,
                          'state': stateController.text,
                          'pin': pinController.text,
                          'description': descController.text,
                          'url':url,
                        }).then((value) => print('Done'));
                        Fluttertoast.showToast(msg: "Added");

                        nameController.clear();
                        pinController.clear();
                        stateController.clear();
                        addressController.clear();
                        descController.clear();
                        titleController.clear();

                        phonenoController.clear();
                        setState(() {
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    )),
              ),
              flex: 2,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Container(
                    child: FloatingActionButton(
                      child: new Text("Upload Resume"),
                      // textColor: Colors.white,
                      /// color: Colors.red,
                      onPressed: () async {
                        uploadDataToFirebase();
                        setState(() {
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    )),
              ),
              flex: 2,
            ),
          ],
        ),
      );
    }
  }
