import 'dart:convert';

import 'package:detect_covid19/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
   var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var FormKeyLogin = GlobalKey<FormState>();
  bool ispassword = true;

  Singin() async {
    var formdate = FormKeyLogin.currentState;
    if (formdate.validate()) {
      var data = {
        "Email": emailController.text,
        "Password": passwordController.text
      };
      var url = "http://10.0.2.2/detect-covid19/login.php";
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
        print('welcom ');
        Navigator.of(context).pushNamed("Home");
      } else {
        showdialogall(context, "Error!", "Email Or Password Invalid");
      }
    } else {
      print('Login Faild');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                titleCovidSpot(),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: FormKeyLogin,
                  child: Column(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DefaultTextFormField(
                          type: TextInputType.name,
                          controller: emailController,
                          icon: Icons.email,
                          lable: 'Email',
                          validation: ValidEmail,

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultTextFormField(
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          lable: 'password',
                          icon: Icons.lock,
                          ispassword: ispassword,
                          suffixonPressed: () {
                            setState(() {
                              ispassword = !ispassword;
                            });
                          },
                          suffix: ispassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          validation:ValidPassword,

                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                defaultButtom(
                    text: 'Login', onpressedfunction: Singin, radius: 5),
                SizedBox(
                  height: 5,
                ),
                TextLoginAccount(
                    stringtext: 'Don\'t have account?',
                    textbutton: 'Register Now',
                    OnpressdTextButton: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
