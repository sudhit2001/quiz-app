import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/auth/login.dart';
// import 'package:flutterapp/models/question_model.dart';
import 'package:flutterapp/pages/home.dart';
import 'firebase_options.dart';
import './models/db_connect.dart';

void main() async {
  var db = DBconnect();
  // db.addQuestion(Question(id: '20', title: 'What is 20*10', options: {
  //   '100': false,
  //   '200': true,
  //   '300': false,
  //   '500': false,
  // }));
  db.fetchQuestions();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return LoginForm();
            }
          },
        ));
  }
}
