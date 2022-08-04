import 'package:flutter/material.dart';
import 'package:mrhirep/login_screen.dart';
import 'package:mrhirep/homescreen1.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mrhirep/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
class  RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) :super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();

}
class _RegistrationScreenState extends State<RegistrationScreen>{
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  final _formKey= GlobalKey<FormState>();

  final TextEditingController emailController=new TextEditingController();
  final TextEditingController passwordController=new TextEditingController();
  final TextEditingController firstnameController=new TextEditingController();
  final TextEditingController lastnameController=new TextEditingController();
  final TextEditingController confirmpasswordController=new TextEditingController();

  @override
  Widget build(BuildContext context){
    final emailField=TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value){
          if(value!.isEmpty){
            return("Please Enter your Email");
          }
          // if(!RegExp("^[a-zA-Z0-9+_,-]+@[a-zA-Z0-9=_,-]+.[a-z]").hashMatch(value))
          //   {
          //     return("Please enter a valid email");
          //   }
          return null;

        },
        onSaved: (value) {
          firstnameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final firstname=TextFormField(
        autofocus: false,
        controller: firstnameController,
        validator: (value){
          if(value!.isEmpty) {
            return (" First Name Cannot be empty");
          }
          return null;

        },
        onSaved: (value) {
          firstnameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final lastname=TextFormField(
        autofocus: false,
        controller: lastnameController,
        validator: (value){
          if(value!.isEmpty) {
            return (" Last Name Cannot be empty");
          }
          return null;

        },
        onSaved: (value) {
          lastnameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    // final confirmpasswordField = TextFormField(
    //     autofocus: false,
    //     controller: passwordController,
    //     obscureText: true,
    //     validator: (value) {
    //       if(confirmpasswordController.text!=passwordController.text)
    //       {
    //         return("passwords don't match");
    //       }
    //       return null;
    //     },
    //     onSaved: (value) {
    //       confirmpasswordController.text = value!;
    //     },
    //     textInputAction: TextInputAction.done,
    //     decoration: InputDecoration(
    //       prefixIcon: Icon(Icons.vpn_key),
    //       contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Confirm Password",
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ));
    final RegisterButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.purple,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailController.text, passwordController.text);
          },
          child: Text(
            "Register",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //SizedBox(
                    //height: 200,
                    //child: Image.asset(
                    // "assets/logo.png",
                    // fit: BoxFit.contain,
                    // )),
                    SizedBox(height: 45),
                    firstname,
                    SizedBox(height: 25),
                    lastname,
                    SizedBox(height: 25),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    //SizedBox(height: 25),
                    //confirmpasswordField,
                    SizedBox(height: 35),
                    RegisterButton,
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginScreen()));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model


    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel(firstName: '', email: '', uid: '', lastName: '');

    // writing all the values
    userModel.email = user!.email!;
    userModel.uid = user.uid;
    userModel.firstName = firstnameController.text;
    userModel.lastName = lastnameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
       (context),
        MaterialPageRoute(builder: (context) => HomeScreen1()),
          (route) => false
         );
  }


}

