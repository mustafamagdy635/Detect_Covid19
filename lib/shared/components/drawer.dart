import 'package:detect_covid19/modules/edit/edit-profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class drawer extends StatefulWidget{
  @override

  _drawer createState()=>_drawer();
}
class _drawer extends State<drawer> {
  var Name;
  var Email;
  int id;
  var image;
  bool isSingnIn=false;

  getPref()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    Name =preferences.getString("Name");
    Email =preferences.getString("Email");
    image =preferences.getString("image");

    if(Name!=null){
      setState(() {
        Name =preferences.getString("Name");
        Email =preferences.getString("Email");
        image =preferences.getString("image");
        isSingnIn=true;
      });
    }

  }
  @override
  void initState(){
    getPref();
    super.initState();
  }
  Widget build(BuildContext context) {



    return Drawer(
      child: ListView(
        children: [

          UserAccountsDrawerHeader(

            accountName: isSingnIn ? Text(Name) :Text(""),
            accountEmail:isSingnIn ? Text( Email) :Text(""),
            currentAccountPicture:Stack(
              children: [
                Container( child: CircleAvatar( backgroundImage:NetworkImage("http://10.0.2.2/detect-covid19/upload/$image",),radius: 50,
                  child:IconButton( icon:Icon( Icons.person),iconSize: 0,
                  onPressed: (){
                  print(image);
                  Navigator.of(context).pushNamed("EditProfile");
                  },
                ),),),

              ],
            ),

            decoration:BoxDecoration(

              color:Colors.blue,
            ) ,
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: (){
              Navigator.of(context).pushNamed('Home_page');
            },
          ),
          ListTile(
            title: Text('Logout '),
            leading: Icon(Icons.login),
            onTap: (){
              Navigator.of(context).pushNamed('logout');
            },
          ),
        ],
      ),
    );

  }
}

