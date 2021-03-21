import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/AllScreen/Registrationscreen.dart';
import 'package:uber_clone/AllScreen/loginscreen.dart';
import 'package:uber_clone/AllScreen/mainscreen.dart';
import 'package:uber_clone/contains.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef=FirebaseDatabase.instance.reference().child('users');


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SIGN_IN,
      routes: <String, WidgetBuilder>{

        SIGN_IN: (BuildContext context) =>  LoginScreen(),
        SIGN_UP: (BuildContext context) =>  RegistrationScreen(),
        Home_page:(BuildContext context)=> MainScreen(),
      },
    );
  }
}
