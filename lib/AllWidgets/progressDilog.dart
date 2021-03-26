import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget
{

  String message;
  ProgressDialog({this.message});
  @override
  Widget build(BuildContext context)
  {
    return Dialog(
      backgroundColor: Color.fromRGBO(0,21, 60, 50),
      child:Container(
        margin: EdgeInsets.all(10.0),
        width:double.infinity,
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children:[
              SizedBox(width: 6.0,),
              CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Color.fromRGBO(0,21, 60, 50)) ,),
              SizedBox(width: 20.0,),
              Text(
                message,
                style:TextStyle(fontSize: 6.0,fontFamily:"Brand Bold",color:Colors.red),
              ),
            ],
          ),
        ),
      )


    );
  }
}
