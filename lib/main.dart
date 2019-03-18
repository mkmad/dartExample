import 'package:flutter/material.dart';

import "persistantStorage/firestoreDB.dart";

void main() {
  var title = "Scaffold example";

  runApp(new MaterialApp(
    // Stateless Widget
    //home: new ScaffoldStatelessWidget(title: title,),

    // State full Widget
    // home: new ScaffoldStatefullWidget(title: title),

    // Login page
    // home: new Login(),

    // Requests page
    //home: new RequestsWidget(
    //  title: "Requests Example",
    //),

//    home: new WeatherSearch(
//      title: "Weather Search",
//    ),

//      home: new TextStorageWidget(
//    title: "Text Storage",)

    //home: new SharedPreferencesStorageWidget(title: "NoSql Storage"),
    home: new FireStoreDB(title: "FireStore storage"),
  ));
}
