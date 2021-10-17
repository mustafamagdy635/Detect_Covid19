import 'dart:convert';
import 'package:detect_covid19/modules/login/login.dart';
import 'package:detect_covid19/shared/components/components.dart';
import 'package:detect_covid19/shared/components/consstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  var registerForm              = GlobalKey<FormState>();
  var userNameController        = TextEditingController();
  var emailController           = TextEditingController();
  var passwordController        = TextEditingController();
  var confirmPasswordController = TextEditingController();

  String confirmPasswordValid(String value) {
    if(value!=passwordController.text){
      return 'password not equel ';
    }
  }
  Signup() async {
    var formdate = registerForm.currentState;
    if (formdate.validate()) {
      var data = {
        "Name": userNameController.text,
        "Email": emailController.text,
        "Password": passwordController.text,
      };
    //  var url = "http://10.0.2.2/detect-covid19/add.php";
      var url = Uri.parse('http://10.0.2.2/detect-covid19/add.php');
      var response = await http.post(url, body: data);
      var respnsebody = jsonDecode(response.body);
      if (respnsebody['status'] == "success") {
        print(' valid');
        Navigator.of(context).pushNamed("login");
      }
    } else {
      print('Not valid');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      leading: Icon(Icons.double_arrow),
      title: titleCovidSpot(),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
      body:
      Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Form(
                  key: registerForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[

                      Text('Ragister',
                      style: TextStyle(fontSize: 40,
                      fontWeight: FontWeight.bold,
                      ),
                      ),

    SizedBox(height: 30,),

    DefaultTextFormField(
                    controller: userNameController,
                    lable: 'User Name',
                    icon: Icons.person,
                    type: TextInputType.text,
                    validation:userNameValid,
    ),

    SizedBox(
                  height: 15,
    ),

    DefaultTextFormField(
                    controller:emailController,
                    lable: 'Email',
                    icon: Icons.email,
                    type: TextInputType.emailAddress,
                    validation: emailValid,
    ),
                      SizedBox(
                        height: 15,
                      ),
    DefaultTextFormField(
                    controller: passwordController,
                    lable: 'password',
                    icon: Icons.lock,
                    type: TextInputType.visiblePassword,
                    validation: passwordValid,
                  ispassword:ispassword ,
                  suffixonPressed: (){
                      setState(() {
                        ispassword=!ispassword;
                      });
                  },
                  suffix: ispassword ?Icons.visibility:Icons.visibility_off,

    ),

                      SizedBox(
                        height: 15,
                      ),
                      DefaultTextFormField(
                          controller: confirmPasswordController,
                          lable: 'ConfirmPasswsord',
                          icon: Icons.confirmation_num_outlined,
                          type: TextInputType.visiblePassword,
                          validation: confirmPasswordValid,
                      ),
                      SizedBox(height: 15,),

                    ],
                  ),

                ),
                defaultButtom(
                    onpressedfunction:Signup,
                    text: 'register'),
                TextLoginAccount(
                    OnpressdTextButton: (){
                      Navigator.of(context).pushNamed("login");
                    },
                    stringtext:'Do you have account',
                  textbutton: 'login'
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

