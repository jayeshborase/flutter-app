import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutternowboylocation/home/header.dart';
import 'package:flutternowboylocation/home/maps.dart';
import 'package:flutternowboylocation/home/ulocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

 //final userloc = Firestore.instance.collection('location').document('12345678');
 LatLng loca;

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
//List<Marker> marker= [];
Location _location=Location();

@override
void initState() {
    //getUsers();
    //getUserId();
    //createUser();
    //updateData();
    //deleteData();
    super.initState();
  }
//getUsers() async{
    //final QuerySnapshot snapshot=await userloc.getDocuments();
    //setState(() {
     // users = snapshot.documents;
    //});
     /* snapshot.documents.forEach((DocumentSnapshot doc){
             print(doc.data);
             print(doc.documentID);
             print(doc.exists);
      });*/
    
  //}

Widget  showmarker() {
     return StreamBuilder<DocumentSnapshot>(
       stream: Firestore.instance.collection('location').document('12345678').snapshots(),
       builder: (context, snapshots){
         if(!snapshots.hasData) return  Text('data no given');
         
         //double latlog= snapshots.data;
         //Ulocation ulocation= Ulocation.fromDocument(snapshots.data);
         
           
         //for(int i=0;i<snapshots.data.documents.length;i++)
         
           //print('length $i');
           //setState(() {
            loca =LatLng(snapshots.data.data['position']['geopoint'].latitude,snapshots.data.data['position']['geopoint'].longitude);
        /* marker.add(Marker(
           markerId: MarkerId("home"),
          position: LatLng(snapshots.data.documents[i]['geopoint'].latitude,snapshots.data.documents[i]['geopoint'].longitude),
          //rotation: newLocalData.heading,
          
         // draggable: false,
          //zIndex: 2,
          //flat: true,
         // anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarkerWithHue( BitmapDescriptor.hueViolet,)
           ));*/
           //});
           
         
          return GoogleMap(
              mapType: MapType.normal,
        initialCameraPosition: initialLocation,//CameraPosition(target: LatLng(21.007713, 75.565467), zoom: 12),
        markers:{ boy } ,//Set.of((marker != null) ? [marker] : []),
       // circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
         mapController=controller;
         //if(change==false){

          _location.onLocationChanged().listen((l) {
          /*if (controller != null) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 18),
              ),
            );}*/
        });
        // }
        },
        myLocationEnabled: true,
          );//bulidgooglemaps(context, initialLocation,location: _location, markers: marker);
       },
       );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Customer'),
      body: Container(
        child: Stack(
        children: <Widget>[
         showmarker(),
         
          
        ],
      ),
      ),
    );
  }
   CameraPosition initialLocation = CameraPosition(target: LatLng(21.007713, 75.565467),zoom: 12);
}

Marker boy= Marker(
           markerId: MarkerId("home"),
          position: loca,//LatLng(snapshots.data.documents[i]['geopoint'].latitude,snapshots.data.documents[i]['geopoint'].longitude),
          //rotation: newLocalData.heading,
          infoWindow: InfoWindow(title: 'boy'),
         // draggable: false,
          //zIndex: 2,
          //flat: true,
         // anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarkerWithHue( BitmapDescriptor.hueViolet,));