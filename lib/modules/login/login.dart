import 'dart:convert';
import 'package:detect_covid19/shared/components/components.dart';
import 'package:detect_covid19/shared/components/consstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
   var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var FormKeyLogin = GlobalKey<FormState>();


   SavePref(String id,String Name, String Email ,String image) async {
     SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.setString("id",id);
     preferences.setString("Name", Name);
     preferences.setString("Email", Email);
     preferences.setString("image", image);
     print(preferences.getString("id"));
     print(preferences.getString("Name"));
     print(preferences.getString("Email"));
     print(preferences.getString("image"));
   }
  Singin() async {
    var formdate = FormKeyLogin.currentState;
    if (formdate.validate()) {
      var data = {
        "Email": emailController.text,
        "Password": passwordController.text
      };
      var url = Uri.parse('http://10.0.2.2/detect-covid19/login.php');
      var response = await http.post(url, body: data);
      var responsebody = jsonDecode(response.body);
      if (responsebody['status'] == "success") {
       SavePref(responsebody['userId'],responsebody['useNnam'], responsebody['userEmail'],responsebody['image']);
        print("valid");

        Navigator.of(context).pushNamed("Home");
      }  else {
        showdialogall(context, "Error!", "Email Or Password Invalid");
      }
    } else {
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(leading: Icon(Icons.double_arrow),
        title: titleCovidSpot(),
        backgroundColor: Colors.white,
        elevation: 0,),*/
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          icon: Icons.email,
                          lable: 'Email',
                          validation: emailValid,

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
                          validation:passwordValid,

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
                    OnpressdTextButton: () { Navigator.of(context).pushNamed("register");}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
