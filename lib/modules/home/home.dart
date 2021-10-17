import 'package:detect_covid19/shared/components/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('mustafa'),
        elevation:0 ,

      ),
      drawer: drawer(),
      body:Column(
        children: [
          Text('mustafa'),
        ],
      ) ,
    );
  }
}
