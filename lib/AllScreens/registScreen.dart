import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllScreens/mainscreen.dart';
import 'package:flutter_app/AllScreens/registScreen.dart';
import 'package:flutter_app/AllScreens/loginScreen.dart';
import 'package:flutter_app/AllWidgets/progressDilog.dart';
import 'package:flutter_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
class RegistScreen extends StatelessWidget {
  static const String idScreen="register";
TextEditingController nameTextEditingController=TextEditingController();
  TextEditingController phoneTextEditingController=TextEditingController();
  TextEditingController user_idTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body:Column(
        children:[
          SizedBox(height:30.0,),
          Image(
            image:AssetImage("images/aa.png"),
            width:130.0,
            height: 130.0,
            alignment: Alignment.center,
          ),
          SizedBox(height:2.0,),
          Text(
            "R e g i s t e r",
            style:TextStyle(fontSize: 13.0,fontFamily:"Brand Bold",  color: Color.fromRGBO(0,21, 60, 65)),
            textAlign:TextAlign.center,
          ),
          Padding(
            padding:EdgeInsets.all(8.0),
            child:Column(
              children:[
                SizedBox(height:0.0,),
                TextField(
                  controller: nameTextEditingController,
                  keyboardType: TextInputType.name,
                  decoration:InputDecoration(
                    labelText:"Name",
                    labelStyle:TextStyle(
                      color: Color.fromRGBO(0,21, 60, 65),
                      fontSize: 9.0,
                    ),
                    hintStyle:TextStyle(
                      color:Colors.grey,
                      fontSize:10.0,
                    ),

                  ),
                  style:TextStyle(fontSize:8.0, color:Colors.red),

                ),
                SizedBox(height:1.0,),
                TextField(
                  controller:phoneTextEditingController,
                  keyboardType: TextInputType.phone,
                  decoration:InputDecoration(
                    labelText:"phone",
                    labelStyle:TextStyle(
                      color: Color.fromRGBO(0,21, 60, 65),
                      fontSize: 9.0,
                    ),
                    hintStyle:TextStyle(
                      color:Colors.grey,
                      fontSize:10.0,
                    ),

                  ),
                  style:TextStyle(fontSize:8.0, color:Colors.red),

                ),
                SizedBox(height:1.0,),
                TextField(
                  controller:user_idTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:InputDecoration(
                    labelText:"User_ID",
                    labelStyle:TextStyle(
                      color: Color.fromRGBO(0,21, 60, 65),
                      fontSize: 9.0,
                    ),
                    hintStyle:TextStyle(
                      color:Colors.grey,
                      fontSize:10.0,
                    ),

                  ),
                  style:TextStyle(
                      fontSize:8.0,
                      color:Colors.red,
                  ),

                ),
                SizedBox(height:1.0,),
                TextField(
                  controller:passwordTextEditingController,
                  obscureText: true,
                  decoration:InputDecoration(
                    labelText:"password",
                    labelStyle:TextStyle(
                      color: Color.fromRGBO(0,21, 60, 65),
                      fontSize: 9.0,
                    ),
                    hintStyle:TextStyle(
                      color:Colors.grey,
                      fontSize:10.0,
                    ),

                  ),
                  style:TextStyle(fontSize:8.0, color:Colors.red),

                ),
                SizedBox(height:23.0,),

                RaisedButton(
                  color: Color.fromRGBO(0,21, 60, 50),
                  textColor:Colors.white,
                  child:Container(
                    height:40.0,

                    child:Center(



                      child:Text(
                        "Create Account",
                        style:TextStyle(fontSize:18.0,fontFamily: "Brand bold"),


                      ),
                    ),
                  ),
                  shape:new RoundedRectangleBorder(
                    borderRadius:new BorderRadius.circular(24.0),
                  ),
                  onPressed:()
                  {
                   // Navigator.pushNamedAndRemoveUntil(context,MainScreen.idScreen,(route)=>false);
                    if(nameTextEditingController.text.length<3)
                      {
                       // Fluttertoast.showToast(msg:"name must atleast 3 characters.");
                        displayToastMessage("name must be atleast 2 characters.", context);
                      }
                    else if (!user_idTextEditingController.text.contains("@"))
                    {
                      displayToastMessage("user_id not valid.", context);
                    }
                    else if (phoneTextEditingController.text.isEmpty)
                    {
                      displayToastMessage("phone number  is mandatory.", context);
                    }
                    else if (passwordTextEditingController.text.length<6)
                    {
                      displayToastMessage("password must be atleast 5 add characters.", context);
                    }
                    else{

                      registerNewUser(context);
                    }

                  },
                ),
              ],
            ),
          ),

          FlatButton(
            onPressed:()
            {
              Navigator.pushNamedAndRemoveUntil(context,LoginScreen.idScreen,(route)=>false);
            },
            child:Text(
              "Already have an Account? Login Here",
              style:TextStyle(fontSize: 8.0,fontFamily:"Brand Bold", color: Color.fromRGBO(0,21, 60, 65),),
            ),
          ),
        ],
      ),
    );

  }
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  registerNewUser(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder:(BuildContext context)
        {
          return ProgressDialog(message:"Registering, please wait ...",);
        }
    );
    final User firebaseUser=(await _firebaseAuth
        .createUserWithEmailAndPassword(
        email:user_idTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      displayToastMessage("error: "+errMsg.toString(), context);
    })).user;
    if (firebaseUser !=null)
      {
        //save user info to database

        Map userDataMap={
          "name":nameTextEditingController.text.trim(),
          "user":user_idTextEditingController.text.trim(),
          "phone":phoneTextEditingController.text.trim(),

        };
        usersRef.child(firebaseUser.uid).set(userDataMap);
        displayToastMessage("congratulations,your account has been created.", context);
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
      }
   else
     {
       Navigator.pop(context);
       //error accured-display error msg
       displayToastMessage("New user account has not been created.", context);
     }
  }

}
displayToastMessage(String message,BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}

