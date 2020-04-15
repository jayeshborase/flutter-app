import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';

class Ulocation{

  final String locationId;
  Map locationposition;

  Ulocation({
  this.locationId,
  this.locationposition,
  });

  factory Ulocation.fromDocument(DocumentSnapshot doc){
      return Ulocation(
         locationId: doc['id'],
         locationposition: doc['position'],
      );
  }

}