import 'package:detect_covid19/modules/edit/edit-profile.dart';
import 'package:detect_covid19/modules/home/home.dart';
import 'package:detect_covid19/modules/login/login.dart';
import 'package:detect_covid19/modules/register/registration.dart';
import 'package:flutter/material.dart';

import 'modules/about/About.dart';

void main() {
  runApp(detect());
}

class detect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'Home':(context){
          return Home();
        },
        'register':(context){
          return register();
        },

        'login':(context){
          return login();
        },

        'EditProfile':(context){
          return EditProfile();
        }
      },
      home: login(),
    );
  }
}

