import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  // Login constructor
  Login({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  final String title = "Login";

  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  // clearing the text fields using setState
  void _clearFields() {
    setState(() {
      _userController.clear();
      _passwordController.clear();
    });
  }

  // create a scaffold
  Scaffold createScaffold() {
    return new Scaffold(
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
        ],
      ),

      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.grey.shade200,
        // Note: ListView is used here so that we can
        //       scroll over the entire page
        child: new ListView(
          children: <Widget>[
            // This is how we declare an image asset
            // Note: We also specify the height, width and color
            new Image.asset(
              "images/face.png",
              width: 90.0,
              height: 90.0,
              color: Colors.deepOrange,
            ),

            // Note: See how padding is also a widget and a child
            new Padding(padding: new EdgeInsets.all(10.0)),

            // We declare an container with height, width and color as well
            new Container(
              height: 120.0,
              width: 400.0,
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    // Note how we declare a controller and decoration
                    // to this text field
                    controller: _userController,
                    decoration: new InputDecoration(
                        hintText: "username", icon: new Icon(Icons.person)),
                  ),
                  new TextField(
                    // Note how we declare a controller and decoration
                    // to this text field
                    controller: _passwordController,
                    decoration: new InputDecoration(
                        hintText: "password", icon: new Icon(Icons.lock)),
                    // obscureText hides the password while typing
                    obscureText: true,
                  )
                ],
              ),
            ),

            // This row acts as a horizontal stack
            new Row(
              children: <Widget>[
                new Container(
                  padding: new EdgeInsets.only(left: 40),
                  child: new RaisedButton(
                    onPressed: () => debugPrint("login pressed"),
                    color: Colors.redAccent,
                    child: new Text(
                      "Login",
                      style: new TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ),

                // Note: The padding for this button is 160 px from the left
                new Container(
                  padding: new EdgeInsets.only(left: 160),
                  child: new RaisedButton(
                    // The onPressed here clears both the input fields
                    // using both the text field controllers
                    onPressed: _clearFields,
                    color: Colors.redAccent,
                    child: new Text(
                      "Clear",
                      style: new TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                )
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
    // TODO: implement build
    return createScaffold();
  }
}
