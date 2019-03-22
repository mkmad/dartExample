import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Firebase auth and google sign in
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

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

  // controllers for the text fields
  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  // This var keeps track of the radio button's state
  int radioGroupVal = 0;

  GoogleSignInAccount _currentUser;
  String _contactText;

//  @override
//  void initState() {
//    super.initState();
//    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//      setState(() {
//        this._currentUser = account;
//      });
//    });
//    _googleSignIn.signInSilently();
//  }

  // radio button handler that changes the states of the buttons
  void radioHandler(int value) {
    setState(() {
      this.radioGroupVal = value;
    });
  }

  // clearing the text fields using setState
  void _clearFields() {
    setState(() {
      this._userController.clear();
      this._passwordController.clear();
    });
  }

  // handle google login
  Future<FirebaseUser> _handleLoginGoogle() async {
    try {
      // SignInAccount
      _currentUser = await _googleSignIn.signIn();

      // SignInAuthentication
      GoogleSignInAuthentication _googleSignInAuthentication =
          await _currentUser.authentication;

      // AuthCredential
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: _googleSignInAuthentication.accessToken,
        idToken: _googleSignInAuthentication.idToken,
      );

      // firebase user
      final FirebaseUser user = await _auth.signInWithCredential(credential);

      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      // check if its the current user
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      return user;
    } catch (error) {
      print(error);
    }
  }

  // handle email login
  void _handleLoginEmail() async {}

  // handle sign out
  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
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
                    onPressed: _handleLoginGoogle,
                    color: Colors.redAccent,
                    child: new Text(
                      "Google Login",
                      style: new TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.only(left: 40),
                  child: new RaisedButton(
                    onPressed: _handleLoginEmail,
                    color: Colors.redAccent,
                    child: new Text(
                      "Login with email",
                      style: new TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ),
              ],
            ),

            new Center(
              child: new Row(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(left: 40),
                    child: new RaisedButton(
                      onPressed: _handleSignOut,
                      color: Colors.redAccent,
                      child: new Text(
                        "Sign out",
                        style:
                            new TextStyle(color: Colors.white, fontSize: 17.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Row for radio buttons

            // Note: Radio buttons are coupled together using the groupValue
            //       parameter, and we also declare the radio handler in the
            //       onChanged attribute which triggers a setState that changes
            //       the groupValue's value
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Radio(
                    activeColor: Colors.pink,
                    value: 0,
                    groupValue: radioGroupVal,
                    onChanged: radioHandler),
                new Text(
                  "first",
                  style: new TextStyle(color: Colors.black),
                ),
                new Radio(
                    activeColor: Colors.green,
                    value: 1,
                    groupValue: radioGroupVal,
                    onChanged: radioHandler),
                new Text(
                  "Second",
                  style: new TextStyle(color: Colors.black),
                ),
                new Radio(
                    activeColor: Colors.purple,
                    value: 2,
                    groupValue: radioGroupVal,
                    onChanged: radioHandler),
                new Text(
                  "Third",
                  style: new TextStyle(color: Colors.black),
                ),
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
