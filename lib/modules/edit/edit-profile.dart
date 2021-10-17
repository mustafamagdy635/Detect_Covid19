import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:detect_covid19/shared/components/components.dart';
import 'package:detect_covid19/shared/components/consstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
class EditProfile  extends StatefulWidget {


  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  var EditForm              = GlobalKey<FormState>();
  var userNameController        = TextEditingController();
  var emailController           = TextEditingController();
  var passwordController        = TextEditingController();
  var confirmPasswordController = TextEditingController();

  String confirmPasswordValid(String value) {
    if(value!=passwordController.text){
      return 'password not equel ';
    }
  }


  var Name;
  var Email;
  var id;
  var image;
  bool isSingnIn=false;

  getPref1()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Name =preferences.getString("Name");
    Email =preferences.getString("Email");
    id =preferences.getString("id");
    image =preferences.getString("image");
    if(Name!=null){
      setState(() {
        Name =preferences.getString("Name");
        Email =preferences.getString("Email");
        id =preferences.getString("id");
        image =preferences.getString("image");

      });
    }

  }
  @override
  void initState(){
    getPref1();
    super.initState();
  }

  File _image ;
  final packer=ImagePicker();

  Future choiceImage()async {
    var ImagePicker = await packer.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(ImagePicker.path);
    });
  }


  Edit() async {
    var formdate = EditForm.currentState;
    if (formdate.validate()) {

      String base64= base64Encode(_image.readAsBytesSync());
      String imagename = _image.path.split('/').last;
      var data = {
        "Name": userNameController.text,
        "Email": emailController.text,
        "Password": passwordController.text,
        "imagename": imagename,
        "base64": base64,
        "id":id,
      };

      var url = Uri.parse('http://10.0.2.2/detect-covid19/Edit.php');
      var response = await http.post(url, body: data);
      var respnsebody = jsonDecode(response.body);
      if (respnsebody['status'] == "success") {
        print(' valid');
        getPref1();

        Navigator.of(context).pushNamed("Home");
      }
    } else {
      print('Not valid');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Edit Profile'),
        elevation: 0,
      ),

      body:Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: EditForm,
                child: Column(

                  children: [

                    Container( child: CircleAvatar( backgroundImage:NetworkImage("http://10.0.2.2/detect-covid19/upload/$image",),radius: 50,
                      child:IconButton( icon:Icon( Icons.person),iconSize: 0,
                        onPressed: choiceImage,
                      ),),),

                    //Center(child: IconButton(onPressed:choiceImage, icon:Icon(Icons.camera_alt)),) ,
                    SizedBox(
                      height: 15,
                    ),
                    DefaultTextFormField(

                        controller:userNameController,
                        lable:"user Name",
                        hint: Name,
                        icon: Icons.person,
                        type: TextInputType.text,
                        validation: userNameValid
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DefaultTextFormField(
                      controller: emailController,
                      lable: "Email",
                      hint: Email,
                      icon: Icons.email,
                      type: TextInputType.emailAddress,
                      validation: emailValid,

                    ),
                          SizedBox(
                            height: 15,
                          ),

                     DefaultTextFormField(
                         controller: passwordController,
                         lable:"password" ,
                         icon: Icons.lock,

                         type: TextInputType.visiblePassword,
                         validation:passwordValid,
                       ispassword: ispassword,
                       suffix:ispassword ?Icons.visibility:Icons.visibility_off,
                        suffixonPressed: (){
                          setState(() {
                            ispassword=!ispassword;
                          });
                        },
                     ),

                       SizedBox(
                         height: 15,
                       ),
                    DefaultTextFormField(
                      validation: confirmPasswordValid,
                      lable: "Confirm Password",
                      type: TextInputType.visiblePassword,
                      icon: Icons.confirmation_num,
                      controller: confirmPasswordController,
                      ispassword: true,



                    ),
                  ],
                ),
              ),
              SizedBox(
                height:15 ,
              ),
              defaultButtom(
                  onpressedfunction:Edit,
                  text: "edit")
            ],
          ),
        ),

      ) ,
    );
  }
}
