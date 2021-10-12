import 'package:detect_covid19/modules/home/home.dart';
import 'package:detect_covid19/modules/login/login.dart';
import 'package:flutter/material.dart';

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
        }
      },
      home: login(),
    );
  }
}

