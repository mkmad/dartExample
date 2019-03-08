import 'package:flutter/material.dart';

import 'weather/weatherSearch.dart';

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

    home: new WeatherSearch(
      title: "Weather Search",
    ),
  ));
}
