//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutternowboylocation/pages/deliverboy.dart';
import 'package:location/location.dart';

GoogleMapController mapController;
//Marker marker;

/*<meta-data android:name="com.google.android.geo.API_KEY"
            android:value="AIzaSyBeS_345oExDmBN7EVn4vKbQtAksyfLlyY"/>*/

Widget bulidgooglemaps(BuildContext context, CameraPosition initialLocation, {Circle circle, Marker markers,bool change=false,bool boyLocation=false, Location location}){
  return Container(
     height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,//CameraPosition(target: LatLng(21.007713, 75.565467), zoom: 12),
        markers: Set.of((markers != null) ? [markers] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
         mapController=controller;
         if(change==false){

          location.onLocationChanged().listen((l) {
          /*if (controller != null) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 18),
              ),
            );}*/
        });
         }
        },
        myLocationEnabled: change?false:true,
          ),
  );

}