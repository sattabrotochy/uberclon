import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/AllWidget/progessdilog.dart';
import 'package:uber_clone/contains.dart';
import 'package:uber_clone/main.dart';

import '../contains.dart';
import '../contains.dart';
import '../contains.dart';
import '../contains.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;

  TextEditingController nameText = TextEditingController();

  TextEditingController emailText = TextEditingController();

  TextEditingController numberText = TextEditingController();

  TextEditingController passwordText = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    isLoading = false;
  }

  final key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 250,
                    width: 280,
                    image: AssetImage(
                      'images/logo.png',
                    ),
                    alignment: Alignment.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register as a Rider',
                    style:
                        TextStyle(fontFamily: 'bolt-regular', fontSize: 24.0),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ///////////////////////........name text..........//////////////////////////
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: nameText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          )),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    ///////////////////////........email text..........//////////////////////////

                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailText,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          )),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    ///////////////////////........number text..........//////////////////////////

                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: numberText,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Number',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          )),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    ///////////////////////........password text..........//////////////////////////
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordText,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          )),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    ///////////////////////........button..........//////////////////////////

                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (nameText.text.isEmpty) {
                          DisplayToastMessage(
                              'Please enter your name', context);
                        } else if (!emailText.text.contains("@")) {
                          DisplayToastMessage(
                              'please enter valid email', context);
                        } else if (passwordText.text.length < 6) {
                          DisplayToastMessage(
                              ' password length greater than 6 ', context);
                        } else if (numberText.text.length < 10 &&
                            numberText.text.length > 12) {
                          DisplayToastMessage(
                              ' Please enter your valid number ', context);
                        } else {
                          setState(() {
                            isLoading = true;
                          });

                          CreateAccountUser(context);
                        }
                      },
                      height: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      minWidth: double.infinity,
                      color: Colors.yellow[700],
                      textColor: Colors.white,
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            fontFamily: 'bolt-regular', fontSize: 20.0),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLoading == true
                            ? CircularProgressIndicator(
                          backgroundColor: Colors.yellow[700],

                              )
                            : Text(''),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SIGN_IN);
                  },
                  child: Text('Have an Account,Login Here'))
            ],
          ),
        ),
      ),
    );
  }

  Future CreateAccountUser(BuildContext context) async {
    try {


      showDialog(context: context,barrierDismissible: false,builder: (BuildContext context){
        return ProgressDialog(message: "please wait......");
      });

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailText.text.toString(),
        password: passwordText.text.toString(),
      ).catchError((onError){
            Navigator.of(context).pop();
          DisplayToastMessage("Error", context);
          });

      if (userCredential != null) {
        Map userDataMap = {
          'id': userCredential.user.uid,
          'name': nameText.text.trim(),
          'email': emailText.text.trim(),
          'number': numberText.text.trim(),
          'password': passwordText.text.trim(),
        };
        usersRef.child(userCredential.user.uid).set(userDataMap);
        DisplayToastMessage('Registration successful', context);
        Navigator.of(context).pop();
        nameText.clear();
        emailText.clear();
        numberText.clear();
        passwordText.clear();
        Navigator.of(context).pushNamed(SIGN_IN);
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DisplayToastMessage('The password provided is too weak.', context);
        Navigator.of(context).pop();
      } else if (e.code == 'email-already-in-use') {
        DisplayToastMessage(
            'The account already exists for that email.', context);
        Navigator.of(context).pop();
      }
    } catch (e) {
      Navigator.of(context).pop();
      print(e);
    }
  }
}
