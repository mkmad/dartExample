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

  // current google user
  GoogleSignInAccount _currentUser;

  String _imageUrl;

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

      FirebaseUser user_;

      // firebase user
      await _auth.signInWithCredential(credential).then((FirebaseUser user) {
        assert(user.email != null);
        assert(user.displayName != null);
        assert(!user.isAnonymous);

        print(user.displayName);
        print(user.email);
        print(user.photoUrl);

        // setting image url
        setState(() {
          _imageUrl = user.photoUrl;
        });

        // setting user_ for further tests outside the
        // closure
        user_ = user;
        return user;
      });

      if (user_ != null) {
        assert(await user_.getIdToken() != null);
        // check if its the current user
        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user_.uid == currentUser.uid);
      }
    } catch (error) {
      print(error);
    }
  }

  // handle creating account with email
  Future<FirebaseUser> _handleCreateWithEmail() async {
    FirebaseUser user = await _auth
        .createUserWithEmailAndPassword(email: null, password: null)
        .then((user) {
      print("User with email: ${user.email}");
      print("User with display name: ${user.displayName}");
    });
    return user;
  }

  // handle email login
  Future<void> _handleLoginEmail() async {
    _auth
        .signInWithEmailAndPassword(email: null, password: null)
        .catchError((onError) {})
        .then((user) {
      print("User logged in");
    });
  }

  // handle sign out
  Future<void> _handleSignOut(BuildContext context) async {
    await _googleSignIn.disconnect().then((GoogleSignInAccount account) {
      setState(() {
        _imageUrl = "";
      });

      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text("User Signed Out")));
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(left: 40),
                    child: new Builder(builder: (BuildContext context) {
                      return new RaisedButton(
                        onPressed: _handleCreateWithEmail,
                        color: Colors.redAccent,
                        child: new Text(
                          "Create Account",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 17.0),
                        ),
                      );
                    }),
                  ),
                  new Container(
                    padding: new EdgeInsets.only(left: 40),
                    child: new Builder(builder: (BuildContext context) {
                      return new RaisedButton(
                        onPressed: () => _handleSignOut(context),
                        color: Colors.redAccent,
                        child: new Text(
                          "Sign out",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 17.0),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Image asset form/over the network
            new Image.network(
                _imageUrl == null || _imageUrl.isEmpty ? "" : _imageUrl),

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
