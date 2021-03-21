import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/AllWidget/progessdilog.dart';
import 'package:uber_clone/contains.dart';
import 'package:uber_clone/main.dart';

import '../contains.dart';
import '../contains.dart';

class LoginScreen extends StatefulWidget {



  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailText=TextEditingController();
  TextEditingController passwordText=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    'Login as a Rider',
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
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (emailText.text.isEmpty) {
                        DisplayToastMessage(
                        'please enter your email', context);
                        }
                        else if (passwordText.text.isEmpty) {
                        DisplayToastMessage(
                        ' please enter your email', context);
                        }
                        else
                          {
                            gotoHomePage(context);
                          }


                      },
                      height: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      minWidth: double.infinity,
                      color: Colors.yellow[700],
                      textColor: Colors.white,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontFamily: 'bolt-regular', fontSize: 20.0),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SIGN_UP);
                  },
                  child: Text('Do not Have an Account,Registration Here'))
            ],
          ),
        ),
      ),
    );
  }
  void gotoHomePage(BuildContext context) async {

    try{
      showDialog(context: context,barrierDismissible: false,builder: (BuildContext context){
        return ProgressDialog(message: "Authenticating,please wait......");
      });

      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailText.text.toString(),
        password: passwordText.text.toString(),

      ).catchError((onError){
        Navigator.of(context).pop();
        DisplayToastMessage('Error'+onError.toString(), context);
      });

      if(userCredential !=null)
        {
          usersRef.child(userCredential.user.uid).once().then((DataSnapshot  snapshot)
          {
            if(snapshot.value !=null)
              {
                Navigator.of(context).pushNamed(Home_page);
              }
            else{
              Navigator.of(context).pop();
              auth.signOut();
              DisplayToastMessage("Please create a account", context);
            }

          });

          Navigator.of(context).pop();
        }
      else{
        Navigator.of(context).pop();
        DisplayToastMessage('Error Occured ,can not be Signed-in', context);
      }


    }catch(e)
    {
      Navigator.of(context).pop();
      DisplayToastMessage(e,context);
    }

  }


}

