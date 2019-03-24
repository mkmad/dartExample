import 'package:flutter/material.dart';

// Create a custom stateful widget
class AnimationExample extends StatefulWidget {
  String title;

  AnimationExample({Key key, this.title}) : super(key: key);

  // It is necessary to create states of every
  // stateful widget
  @override
  State<StatefulWidget> createState() {
    return new CustomState(title: this.title);
  }
}

// This class creates a state for the AnimationExample
// Note: how it extends State and its of type <AnimationExample>
class CustomState extends State<AnimationExample> {
  String title;

  // controllers for the text fields
  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  CustomState({this.title});

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
          backgroundColor: Colors.deepOrange.shade700,
          title: new Text(this.title),
          centerTitle: true,
          // The action widgets are the right icons in the appBar
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => debugPrint("Send icon Tapped!")),
            new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () => debugPrint("Send icon Tapped!")),
          ]),

      // Creates and sets params for body of scaffold
      body: new Container(
        padding: EdgeInsets.only(top: 48.0, left: 24.0, right: 24.0),
        child: new ListView(
          children: <Widget>[
            new Center(
              child: new Text(
                'Welcome to Login Page',
                style: new TextStyle(
                  fontSize: 22.00,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            new SizedBox(
              height: 34.0,
            ),
            new Container(
              height: 120.0,
              width: 400.0,
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    // Note how we declare a controller and decoration
                    // to this text field
                    controller: _userController,
                    decoration: new InputDecoration(
                      hintText: "username",
                      icon: new Icon(
                        Icons.person,
                        color: Colors.deepOrange,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                    ),
                    cursorColor: Colors.deepOrangeAccent,
                    validator: null,
                  ),
                  new TextFormField(
                    // Note how we declare a controller and decoration
                    // to this text field
                    controller: _passwordController,
                    decoration: new InputDecoration(
                      hintText: "password",
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.deepOrange,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                    ),
                    cursorColor: Colors.deepOrangeAccent,
                    // obscureText hides the password while typing
                    obscureText: true,
                    validator: null,
                  )
                ],
              ),
            ),

            // IntrinsicWidth will make all the widgets inside
            // a row or column have the same size (h & w) as the
            // biggest widget in the row/column
            IntrinsicWidth(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Expanded(
                    child: SizedBox(
                        height: 50,
                        child: new RaisedButton(
                            color: Colors.deepOrangeAccent,
                            child: new Text(
                              'Login',
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            onPressed: () {},
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(30.0)))),
                  ),

                  // add an empty space between the buttons( since I am
                  // using expanded the buttons tend to stick to each
                  // other)
                  new SizedBox(
                    width: 10.0,
                  ),

                  new Expanded(
                    child: SizedBox(
                        height: 50,
                        child: new RaisedButton(
                            color: Colors.deepOrangeAccent,
                            child: new Text(
                              'Register',
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            onPressed: () {},
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(30.0)))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      // Creates and sets params for floatingActionButton
      floatingActionButton: new FloatingActionButton(
        onPressed: () => debugPrint("Floating Button Touched"),
        backgroundColor: Colors.pink,
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
              icon: new Icon(Icons.restaurant_menu, color: Colors.black26),
              title: new Text("Menu")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.pages, color: Colors.black26),
              title: new Text("Options")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.settings, color: Colors.black26),
              title: new Text("Settings"))
        ],

        // action handler for item pressed (note: its index based)
        onTap: (int i) => debugPrint("Hey Touched $i"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return createScafflod();
  }
}
