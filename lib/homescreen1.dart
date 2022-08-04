// import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:mrhire/model/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
 import 'model/user_model.dart';
 import 'demo.dart';
// //import 'homescreen2.dart';
//
 import 'searchjob.dart';
import 'postjob.dart';
import 'gethired.dart';
import 'viewemployyes.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = new UserModel(lastName: '', email: '', uid: '', firstName: '');
  //FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //User? user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
     // final uid=user?.uid;
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

//   @override
  Widget build(BuildContext context) {
    log("Index number is: $loggedInUser.firstName");
    final welcomeText=Text
      ("Hey ${loggedInUser.firstName}",
    style:TextStyle(
      fontSize: 30),
    );

    final likeText=Text("What would you like to do today?",
    style:TextStyle(
      fontSize:25,
    ));
    final BUTTON1 = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.purple,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => GetHired()));
          },
          child: Text(
            "GET HIRED",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final BUTTON2 = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.purple,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SearchJob()));
            },

          child: Text(
            "LOOK FOR A JOB",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final BUTTON3 = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.purple,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: (

              ) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => viewlist()));
          },
          child: Text(
            "SEARCH FOR AN EMPLOYEE",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final BUTTON4 = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.purple,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => PostJob()));
          },
          child: Text(
            "POST YOUR JOB",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      appBar: AppBar(

        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded),
            onPressed: () {
              logout(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
        title:Center(
          child:Text( "       Mr.Hire",style:TextStyle(fontSize:30.0)),
      ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              welcomeText,
              SizedBox(
                height: 20,
              ),
              likeText,

              // Text("${loggedInUser.firstName} ${loggedInUser.lastName}",
              //     style: TextStyle(
              //       color: Colors.black54,
              //       fontWeight: FontWeight.w500,
              //     )),
            SizedBox(
              height: 20,
            ),
              BUTTON1,
            SizedBox(
            height: 20,
          ),
          BUTTON2,
          SizedBox(
          height: 20,
        ),
        BUTTON3,
        SizedBox(
        height: 20,
      ),
      BUTTON4,
      SizedBox(
      height: 20,
    ),


              //   SizedBox(
              //   height: 150,
              //  child: Image.asset("assets/logo.png", fit: BoxFit.contain),
              //  ),
              // Text(
              //   "Welcome Back",
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   height: 10,
            //  ),
              // Text("firstName lastName",
              //     style: TextStyle(
              //       color: Colors.black54,
              //       fontWeight: FontWeight.w500,
              //     )),
              // Text("name",
              //     style: TextStyle(
              //       color: Colors.black54,
              //       fontWeight: FontWeight.w500,
                //  )),
              //SizedBox(
               // height: 15,
             // ),
//               ActionChip(
//                   label: Text("Logout"),
//                   onPress      ed: () {
//                     logout(context);
//                   }),
            ],
          ),
        ),
      ),
    );
  }
}
//
  //the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
// }