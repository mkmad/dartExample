import 'package:flutter/material.dart';
import 'scaffoldStatelessExample.dart';
import 'scaffoldStatefulExample.dart';

void main() {
  var title = "Scaffold example";
  runApp(new MaterialApp(
    // Stateless Widget
    //home: new ScaffoldStatelessWidget(title: title,),

    // State full Widget
    home: new ScaffoldStatefullWidget(title: title),
  ));
}
