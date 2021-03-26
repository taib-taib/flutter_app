import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllScreens/mainscreen.dart';
import 'package:flutter_app/AllScreens/loginScreen.dart';
import 'package:flutter_app/AllScreens/registScreen.dart';
import 'package:flutter_app/AllWidgets/progressDilog.dart';
import 'package:flutter_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginScreen extends StatelessWidget {
  static const String idScreen="loginScreen";
  TextEditingController user_idTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body:SingleChildScrollView(
        child:Padding(
        padding:EdgeInsets.all(6.0),
          child:Column(
    children:[
      SizedBox(height:30.0,),
    Image(
    image:AssetImage("images/aa.png"),
    width:130.0,
    height: 130.0,
    alignment: Alignment.center,
    ),
      SizedBox(height:0.0,),
      Text(
        "L o g i n",

            style:TextStyle(fontSize: 20.0,fontFamily:"Brand Bold", color: Color.fromRGBO(0,21, 60, 65),),

      textAlign:TextAlign.center,
    ),
    Padding(
    padding:EdgeInsets.all(11.0),
    child:Column(
    children:[
      SizedBox(height:5.0),
      TextField(
        controller: user_idTextEditingController,
        keyboardType: TextInputType.emailAddress,
        decoration:InputDecoration(
          labelText:"User_ID",
          labelStyle:TextStyle(
            color: Color.fromRGBO(0,21, 60, 65),
            fontSize: 14.0,
          ),
          hintStyle:TextStyle(

            fontSize:1.0,
          ),

        ),
        style:TextStyle(
            fontSize:10.0,

            color:Colors.red

        ),

      ),
      SizedBox(height:25.0,),
      TextField(
        controller: passwordTextEditingController,
        obscureText: true,
        decoration:InputDecoration(
          labelText:"Password",
          labelStyle:TextStyle(
            color: Color.fromRGBO(0,21, 60, 65),
            fontSize: 14.0,
          ),
          hintStyle:TextStyle(

            fontSize:1.0,
          ),

        ),
        style:TextStyle(fontSize:10.0,color:Colors.red),

      ),
      SizedBox(height:65.0),
      RaisedButton(
        color: Color.fromRGBO(0,21, 60, 50),
        textColor:Colors.white,
        child:Container(
          height:42.0,
          child:Center(
            child:Text(
              "Login",
              style:TextStyle(fontSize:18.0,fontFamily: "Brand bold"),


            ),
          ),
        ),
        shape:new RoundedRectangleBorder(
          borderRadius:new BorderRadius.circular(24.0),
      ),
      onPressed:()
        {
          if (!user_idTextEditingController.text.contains("@"))
          {
            displayToastMessage("user_id not valid.", context);
          }
          else if (passwordTextEditingController.text.isEmpty)
          {
            displayToastMessage("password is mandatory.", context);
          }
          else {
            loginAndAuthenticateUser(context);
            //Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          }


        },
      ),
    ],
    ),
    ),

    FlatButton(
      onPressed:()
      {
        Navigator.pushNamedAndRemoveUntil(context,RegistScreen.idScreen,(route)=>false);

      },
      child:Text(

        "Do not have an Account?Register Here.",
        style:TextStyle(fontSize: 8.0,fontFamily:"Brand Bold", color: Color.fromRGBO(0,21, 60, 65),),
      ),
    ),
  ],
        ),
),
    ),
    );



  }
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context)async
  {
    showDialog(
        context: context,
      barrierDismissible: false,
        builder:(BuildContext context)
    {
     return ProgressDialog(message:"Authentication,please wait",);
    }
    );
    final User firebaseUser=(await _firebaseAuth
        .signInWithEmailAndPassword(
        email:user_idTextEditingController.text,
        password: passwordTextEditingController.text,
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMessage("error: " + errMsg.toString(), context);
    })).user;
    if (firebaseUser !=null)
    {
      //save user info to database
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap !=null) {

          displayToastMessage("you are logged-in now.", context);


        }
        else{
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("No record exists for this user.please create new account.", context);
        }

      });
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen,(route)=>false);
      displayToastMessage("you are logged-in now.", context);
    }
    else
    {
      Navigator.pop(context);
      displayToastMessage("Error Occured, can not be signed-in.", context);
    }
}
}
displayToastMessage(String message,BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}