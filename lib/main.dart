import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllScreens/registScreen.dart';
import 'package:flutter_app/AllScreens/loginScreen.dart';
import 'package:flutter_app/AllScreens/mainscreen.dart';

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(MyApp());
}
DatabaseReference usersRef=FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        fontFamily: "Brand Bold",

      visualDensity:VisualDensity.adaptivePlatformDensity,
      ),

      initialRoute: FirebaseAuth.instance.currentUser == null ? LoginScreen.idScreen : MainScreen.idScreen,
      routes:
          {
            RegistScreen.idScreen:(context)=>RegistScreen(),
            LoginScreen.idScreen:(context)=>LoginScreen(),
            MainScreen.idScreen:(context)=>MainScreen(),
          },
      debugShowCheckedModeBanner:false,

    );
  }
}
