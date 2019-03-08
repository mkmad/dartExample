import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;

import 'weatherHome.dart';

// Create a custom stateful widget
class WeatherSearch extends StatefulWidget {
  String title;

  WeatherSearch({Key key, this.title}) : super(key: key);

  @override
  CustomState createState() => new CustomState(title: title);
}

// This class creates a state for the CustomStatefulWidget
// Note: how it extends State and its of type <CustomStatefulWidget>
class CustomState extends State<WeatherSearch> {
  String title;

  // controller for search field
  final TextEditingController _searchController = new TextEditingController();

  // constructor
  CustomState({this.title});

  // clearing the text fields using setState
  void _clearFields() {
    setState(() {
      _searchController.clear();
    });
  }

  // This function moves to the screen provided below
  Future moveToNextScreen(String city) async {
    var router = new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new WeatherHome(
        title: this.title,
        city: city,
      );
    });

    // Use Navigator and to push using the router that's
    // created
    Map results = await Navigator.of(context).push(router);
    debugPrint(results.toString());
  }

  Scaffold createScafflod() {
    /*
      Scaffold has many in-built widgets like AppBar,
      floatingActionButton, bottomNavigationBar, body etc..

      So, we declare the properties of these widgets and return
      the scaffold

     */

    return new Scaffold(
      // Creates and sets params for AppBar
      appBar: new AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black),
          title: new Text(
            this.title,
            style: new TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          // The action widgets are the right icons in the appBar
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.search),
                color: Colors.grey,
                onPressed: () => debugPrint("Menu Tapped!")),
          ]),

      // Creates and sets params for body of scaffold
      // Note: The raised button will call moveToNextScreen
      //       with the text that's entered by the user
      body: new Container(
        alignment: Alignment.topCenter,
        child: new Stack(
          children: <Widget>[
            new Center(
              child: new Image.asset(
                "images/white_snow.png",
                fit: BoxFit.fill,
              ),
            ),
            new ListView(
              children: <Widget>[
                new TextField(
                  obscureText: false,
                  controller: _searchController,
                  decoration: new InputDecoration(
                      hintText: "search city", icon: new Icon(Icons.map)),
                ),
                new FlatButton(
                    textColor: Colors.black,
                    child: new Text("Get Weather"),
                    onPressed: () {
                      moveToNextScreen(_searchController.text);
                      _clearFields();
                    }),
              ],
            )
          ],
        ),
      ),

      // Creates and sets params for floatingActionButton
      floatingActionButton: new FloatingActionButton(
        onPressed: () => moveToNextScreen,
        backgroundColor: Colors.red,
        // tooltip describes what the button does when its long pressed
        tooltip: 'prints button pressed',
        child: new Icon(Icons.add),
      ),

      // Creates and sets params for bottomNavigationBar
      // Note: bottomNavigationBar requires atleast 2 items
      bottomNavigationBar: new BottomNavigationBar(
        // have to declare the type if there are more
        // than 3 navigation items
        type: BottomNavigationBarType.fixed,

        // The actual buttons
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.account_box, color: Colors.black26),
              title: new Text("Account")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.apps, color: Colors.black26),
              title: new Text("Menu")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.pages, color: Colors.black26),
              title: new Text("Options")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.settings, color: Colors.black26),
              title: new Text("Settings"))
        ],

        // action handler for item pressed (note: its index based)
        onTap: (int index) {
          switch (index) {
            default:
              debugPrint("$index button pressed");
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return createScafflod();
  }
}
