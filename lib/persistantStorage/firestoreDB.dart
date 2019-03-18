import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:flutter_app/Todo/addNewUsers.dart" as addUsers;

// Create a custom stateful widget
class FireStoreDB extends StatefulWidget {
  final String title;

  FireStoreDB({Key key, this.title}) : super(key: key);

  // It is necessary to create states of every
  // stateful widget
  @override
  State<StatefulWidget> createState() {
    return new CustomState(title: this.title);
  }
}

// This class creates a state for the CustomStatefulWidget
// Note: how it extends State and its of type <CustomStatefulWidget>
class CustomState extends State<FireStoreDB> {
  String title;

  List databaseItems;
  final Firestore firestore = Firestore.instance;
  final String collection = "books";

  CustomState({this.title});

  // Initialize all the states and load any state/values from
  // shared preferences
  @override
  void initState() {
    super.initState();

    // load data from FQLITE
    _fetchValues();
  }

  // return a firestore stream builder
  Widget _firestoreStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(collection).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new CircularProgressIndicator();
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Card(
                    color: Colors.white,
                    elevation: 1.5,
                    child: new ListTile(
                        title: new Text(document['title']),
                        subtitle: new Text(document['author']),
                        leading: new CircleAvatar(
                          child: new Text(">"),
                          radius: 5.0,
                        ),
                        // Note: The tailing icon is now a listener
                        trailing: new Listener(
                          key: new Key(document['title']),
                          child: new Icon(
                            Icons.remove_circle,
                            color: Colors.redAccent,
                          ),
                          onPointerDown: (pointerEvent) => {},
                        )));
              }).toList(),
            );
        }
      },
    );
  }

  // fetch values from firebase database
  void _fetchValues() {
    firestore.collection(collection).snapshots().listen((data) => {
          setState(() {
            databaseItems = data.documents;
          })
        });
  }

  // delete an item form the firestore database and call _fetchValue to
  // setState and refresh the view
  void _deleteValue(String reference, int position) {
    Future<void> result = firestore.collection(reference).document().delete();
    result.then((res) {
      setState(() {
        databaseItems.removeAt(position);
      });
    });
  }

  // insert values into firestore database
  void _insertValue(String collection, Map<String, String> value) async {
    Future<void> result =
        firestore.collection(collection).document().setData(value);

    result.then((res) {
      _fetchValues();
    });
  }

  // This function moves to the screen provided below
  Future<void> _moveToNextScreen() async {
    var router = new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new addUsers.AddUsers(
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

      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            color: Colors.white,
            elevation: 1.5,
            child: new Container(
              child: new ListTile(
                title: new Text(databaseItems[index]["title"]),
                subtitle: new Text(databaseItems[index]["author"]),
                leading: new CircleAvatar(
                  child: new Text(">"),
                  radius: 5.0,
                ),
                // Note: The tailing icon is now a listener
                trailing: new Listener(
                  key: new Key(databaseItems[index]["title"]),
                  child: new Icon(
                    Icons.remove_circle,
                    color: Colors.redAccent,
                  ),
                  onPointerDown: (pointerEvent) =>
                      {_deleteValue(collection, index)},
                ),
              ),
            ),
          );
        },
        itemCount: databaseItems == null ? 0 : databaseItems.length,
      ),

      // body: _firestoreStreamBuilder(),

      // Creates and sets params for floatingActionButton
      floatingActionButton: new FloatingActionButton(
        onPressed: () =>
            _insertValue('books', {'title': 'title', 'author': 'author'}),
        backgroundColor: Colors.pink,
        // tooltip describes what the button does when its long pressed
        tooltip: 'Fetch values from database',
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
