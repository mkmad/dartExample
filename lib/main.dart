import 'package:flutter/material.dart';
import 'package:flutter_app/scaffold/scaffoldStatelessExample.dart';
import 'package:flutter_app/scaffold/scaffoldStatefulExample.dart';
import "login/login.dart";

void main() {
  var title = "Scaffold example";
  runApp(new MaterialApp(
    // Stateless Widget
    //home: new ScaffoldStatelessWidget(title: title,),

    // State full Widget
    // home: new ScaffoldStatefullWidget(title: title),

    // Login page
    home: new Login(),
  ));
}
