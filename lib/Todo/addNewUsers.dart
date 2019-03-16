import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/Todo/todo.dart' as todo;
import 'package:flutter_app/models/user.dart' as users;
import 'package:flutter_app/persistantStorage/databaseHelper.dart' as database;

// Create a custom stateful widget
class AddUsers extends StatefulWidget {
  String title;

  AddUsers({Key key, this.title}) : super(key: key);

  @override
  CustomState createState() => new CustomState(title: title);
}

// This class creates a state for the CustomStatefulWidget
// Note: how it extends State and its of type <CustomStatefulWidget>
class CustomState extends State<AddUsers> {
  String title;

  // controller for text
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  // constructor
  CustomState({this.title});

  // clearing the text fields using setState
  void _clearFields() {
    setState(() {
      _usernameController.clear();
      _passwordController.clear();
    });
  }

  void _insertUser() async {
    var dbHelper = new database.DatabaseHelper.internal();
    String _username = _usernameController.text;
    String _password = _passwordController.text;
    dbHelper.insertUser(users.User(_username, _password));
    dbHelper.close();
  }

  // This function moves to the screen provided below
  Future _moveToNextScreen() async {
    var router = new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new todo.TodoApp(
        title: "ToDO App",
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
                  controller: _usernameController,
                  decoration: new InputDecoration(
                      hintText: "Enter User", icon: new Icon(Icons.map)),
                ),
                new TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: new InputDecoration(
                      hintText: "Enter Password", icon: new Icon(Icons.map)),
                ),
                new FlatButton(
                    textColor: Colors.black,
                    child: new Text("InsertValue"),
                    onPressed: () {
                      _insertUser();
                      _moveToNextScreen();
                      _clearFields();
                    }),
              ],
            )
          ],
        ),
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
