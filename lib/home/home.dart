import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutternowboylocation/home/maps.dart';
import 'package:flutternowboylocation/pages/customer.dart';
import 'package:flutternowboylocation/pages/deliverboy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

 final GoogleSignIn googleSignIn = GoogleSignIn();
 final usersRef =Firestore.instance.collection("users");
 final DateTime timestamp = DateTime.now();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
bool islogin=false;
bool dboy=false;
  //Maps u= Maps();
  @override
 void initState(){
   super.initState();

   googleSignIn.onCurrentUserChanged.listen((account){
    handleSignIn(account);
   }, onError: (err){
     print('Error In Signin $err ');
   }
   );
  
   /*googleSignIn.signInSilently(suppressErrors:false).then((account){
        handleSignIn(account);
     }).catchError((err){
       print('Error Signed in! : $err');
     });*/
 }

 handleSignIn(GoogleSignInAccount account){
     if (account != null) {
       print('User Sign In $account');
       createUserInFirestore();
       setState(() {
         islogin=true;
       });
     } else {
       setState(() {
         islogin=false;
       });
     }
 }

 createUserInFirestore() async{
    //1. check if user exists in user collection in database (according to their id)
    final GoogleSignInAccount user = googleSignIn.currentUser;
    final DocumentSnapshot doc = await usersRef.document(user.id).get();

    if (!doc.exists) {
    //2. if the user doesn't exists , then we want to take them to the create account page
     //final username = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccount()));

    //3. get username from create account, use it to make new user document in collection
     usersRef.document(user.id).setData({
       "id": user.id,
       //"username": username,
       "email": user.email,
       "photoUrl": user.photoUrl,
       "displayName":user.displayName,
       "bio": "",
       "timestamp": timestamp,
       "islogin":islogin,
       "isdboy":dboy
     });
    }
    /*if(doc.exists)
    userLoca.document(user.id).setData({
      "id": user.id
    });*/
  }        

  login(){
   googleSignIn.signIn();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.teal,
              Colors.blue,
              Colors.purple,
              
            ]
            )
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Location App',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
              ),
              ),
              GestureDetector(
                onTap: login,
                  child: Container(
                       width: 260.0,
                       height: 60.0,
                       decoration: BoxDecoration(
                         image: DecorationImage(
                           image: AssetImage('assets/images/google_signin_button.png'), 
                           fit: BoxFit.cover
                           ),
                       ),
                  ),
             ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 
                 
                 GestureDetector(
                   onTap: (){
                       Navigator.push(
                       context, 
                       MaterialPageRoute(builder: (context) => Customer())
                       );
                   },
                   child: Container(
                     margin: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                     width: 100.0,
                     height: 100.0,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage('assets/images/customer.png'),
                         fit: BoxFit.cover
                       )
                     ),
                   ),
                 ),
                 GestureDetector(
                   onTap: (){
                      Navigator.push(
                       context, 
                       MaterialPageRoute(builder: (context) => Delivery())
                       );
                   },
                   child: Container(
                     margin: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                     width: 120.0,
                     height: 110.0,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage('assets/images/delivery.png'),
                         fit: BoxFit.cover
                       )
                     ),
                   ),
                 )
               ],
            ),
           /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                   margin: EdgeInsets.only(left: 20.0,right: 20.0),
                   child: RaisedButton(
                   //padding: EdgeInsets.all(20.0),
                  child: Text('Customer'),
                   onPressed: (){
                     Navigator.push(
                       context, 
                       MaterialPageRoute(builder: (context) => Customer())
                       );
                   },
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.only(left: 20.0,right: 20.0),
                   child: RaisedButton(
                   //padding: EdgeInsets.all(20.0),
                  child: Text('Delivery Boy'),
                   onPressed: (){
                     Navigator.push(
                       context, 
                       MaterialPageRoute(builder: (context) => Delivery())
                       );
                   },
                   ),
                 )
                 /*GestureDetector(
                   child: Container(
                     width: 100.0,
                     height: 100.0,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: AssetImage('assets/images/delivery.png'),
                         fit: BoxFit.cover
                       )
                     ),
                   ),
                 )*/
               ],
            )*/
          ],
        ),
      ),
    );
  }
}