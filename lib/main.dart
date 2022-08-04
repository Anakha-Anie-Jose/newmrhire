import 'package:flutter/material.dart';
import 'package:mrhirep/login_screen.dart';
//import './firstpage.dart';
import 'package:mrhirep/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mrhirep/demo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Now!',
      theme: ThemeData(

        primarySwatch: Colors.purple,

      ),


      home: LoginScreen(),
    );
  }
}

