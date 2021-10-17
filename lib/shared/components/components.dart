import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

Widget defaultButtom({
  double width = double.infinity,
  Color color = Colors.blue,
  @required Function onpressedfunction,
  @required String text,
  double radius = 0.0,
  bool isuppercase = true,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
        onPressed: onpressedfunction,
        child: Text(
          isuppercase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget titleCovidSpot() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'C',
        style: GoogleFonts.portLligatSans(
          // textStyle: Theme.of(context).textTheme.display1,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        children: [
          WidgetSpan(
            child: Icon(
              Icons.coronavirus_sharp,
              size: 30,
              color: Colors.green[600],
            ),
          ),
          TextSpan(
            text: 'vid',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          TextSpan(
            text: ' Sp',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          WidgetSpan(
            child: Icon(
              Icons.coronavirus_sharp,
              size: 30,
              color: Colors.green[600],
            ),
          ),
          TextSpan(
            text: ' t',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ]),
  );
}

Widget DefaultTextFormField({
  @required TextEditingController controller,
  @required String lable,
  @required IconData icon,
  @required TextInputType type,
  @required Function validation,
  IconData suffix,
  Function suffixonPressed,
  bool ispassword = false,
     String hint,
}) =>
    TextFormField(
      keyboardType: type,
      obscureText: ispassword,
      validator: validation,
      controller: controller,

      decoration: InputDecoration(
        labelText: lable,
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixonPressed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget TextLoginAccount({
  @required String stringtext,
  @required String textbutton,
  @required Function OnpressdTextButton,
}) =>
    Row(
      children: [
        Text(
          '$stringtext',
          style: TextStyle(fontSize: 15),
        ),
        TextButton(
            onPressed: OnpressdTextButton,
            child: Text(
              '$textbutton',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ))
      ],
    );

showloading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [Text("Loading....."), CircularProgressIndicator()],
          ),
        );
      });
}

showdialogall(context, String mytitle, String mycontent) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(mytitle),
          content: Text(mycontent),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        );
      });
}

String passwordValid(val) {
  if (val.trim().isEmpty) {
    return ' user password cant be Empty';
  }
  if (val.trim().length < 4) {
    return ' user password cant be less than 4';
  }

  if (val.trim().length > 20) {
    return ' user password cant be more 20 ';
  }
}

String emailValid(val) {
  if (val.trim().isEmpty) {
    return ' user Email cant be Empty';
  }
  if (val.trim().length < 4) {
    return ' user Email cant be less than 4';
  }

  if (val.trim().length > 50) {
    return ' user Email cant be more 20 ';
  }
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(val)) {
    return 'example@gmail.com';
  }
}


String userNameValid(String value){
  if (value.trim() .isEmpty){
    return ' user name cant be Empty';
  }
  if (value.trim() .length< 4){
    return ' user name cant be less than 4';
  }

  if (value.trim() .length> 20){
    return ' user name cant be more 20 ';
  }
}


