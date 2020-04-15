import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutternowboylocation/home/header.dart';
import 'package:flutternowboylocation/home/maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersloc =Firestore.instance.collection("location");

class Delivery extends StatefulWidget {
  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  StreamSubscription _locationSubscription;
  Location _location= Location();
  bool searchLocation;
  bool addloca;
  Marker marker;
  Circle circle;
  Geoflutterfire geo =Geoflutterfire();

  //GoogleMapController mapController;

 Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/images/delivery_marker.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarkerWithHue( BitmapDescriptor.hueViolet,));//BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getLocation()async{

    try {

      Uint8List imageData = await getMarker();
      var location = await _location.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _location.onLocationChanged().listen((newLocalData) {
        if (mapController != null) {
          mapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing:45.0,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt:50.0,
              zoom: 18.00)));
           GeoFirePoint point = geo.point(latitude: newLocalData.latitude,longitude: newLocalData.longitude);
          // if(usersloc==null)
           usersloc.document("12345678").setData({
             "position": point.data,
             "id":"12345678"
           });
          updateMarkerAndCircle(newLocalData, imageData);
        }
        
      });

    }on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }


    /*_location.onLocationChanged().listen((l){
     mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 12)));
   });*/

  }
    @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'Delivery Boy'),
      body: Stack(
        children: <Widget>[
         bulidgooglemaps(context, initialLocation,circle: circle, boyLocation: searchLocation,markers: marker, change: true)
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: (){
          searchLocation=true;
          getLocation();
        }),
    );
  }
   CameraPosition initialLocation = CameraPosition(target: LatLng(21.007713, 75.565467),zoom: 12);
 }
