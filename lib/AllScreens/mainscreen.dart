import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/AllScreens/registScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllScreens/loginScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MainScreen  extends StatefulWidget {
  static const String idScreen="mainScreen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  Position currentPosition;
  var geoLocator=Geolocator();
  double bottomPaddingOfMap=0;
  void locatePosition() async {
    Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition=position;
    LatLng  latLatPosition=LatLng(position.latitude,position.longitude);
    CameraPosition cameraPosition=new CameraPosition(target: latLatPosition,zoom:14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }



  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,

  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,

      drawer:Container(
        color:Colors.white,
        width:255.0,

        child: Drawer(
          child:ListView(
            children:[
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color:Colors.white),
                  child: Row(
                    children:[
                      Image.asset("images/user_icon.png",height: 65.0,width: 65.0,),
                      SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Profile Name",style:TextStyle(fontSize:16.0,fontFamily:"Brand-Bold"),),
                          SizedBox(height: 6.0,),
                          Text("Visit Profile"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
             
              SizedBox(height: 12.0,),
                ListTile(
                  leading:Icon(Icons.person_add),
                  title:Text("Add Member",style:TextStyle(fontSize: 15.0),),
                ),
              ListTile(
                leading:Icon(Icons.notification_important),
                title:Text("Emergency Alert",style:TextStyle(fontSize: 15.0),),
              ),

                  ListTile(
                    leading:Icon(Icons.info),
                    title:Text("About",style:TextStyle(fontSize: 15.0),),
              ),
              GestureDetector(
                onTap: ()
                {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context,LoginScreen.idScreen,(route)=>false);
                },
                child: ListTile(
                  leading:Icon(Icons.logout),
                  title:Text("Sign Out",style:TextStyle(fontSize: 15.0),),
                ),
              ),
            ],
          ),
        ),
      ),
      body:Stack(
        children:[
          GoogleMap(


            padding: EdgeInsets.only(right:0,top:25 ),
            mapType:MapType.normal,
            myLocationButtonEnabled: true,
             initialCameraPosition: _kGooglePlex ,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,


            onMapCreated: (GoogleMapController controller)
            {

              _controllerGoogleMap.complete(controller);
              newGoogleMapController=controller;
              setState(() {

              });
              locatePosition();



            },
          ),
          Positioned(
            top:34.0,
            left: 15.0,
            child: GestureDetector(
              onTap:()
              {
                scaffoldkey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(
                          0.7,
                          0.7,
                        ),
                      ),
                    ],

                ) ,
                child:CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu,color:Colors.black,),
                  radius: 20.0,

                ),

              ),
            ),
          )
        ],
      ),
    );
  }
  }

